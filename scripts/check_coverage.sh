#!/bin/bash

set -euo pipefail

RESULT_BUNDLE="${1:-TestResults.xcresult}"
BASE_REVISION="${2:-HEAD^}"
MINIMUM_COVERAGE="${3:-80}"

if [[ ! -d "$RESULT_BUNDLE" ]]; then
  echo "Result bundle not found: $RESULT_BUNDLE"
  exit 1
fi

if ! git rev-parse --verify "${BASE_REVISION}^{commit}" >/dev/null 2>&1; then
  echo "Base revision not found: $BASE_REVISION"
  exit 1
fi

if ! [[ "$MINIMUM_COVERAGE" =~ ^[0-9]+([.][0-9]+)?$ ]]; then
  echo "Invalid minimum coverage: $MINIMUM_COVERAGE"
  exit 1
fi

REPORT_JSON=$(mktemp)
DIFF_FILE=$(mktemp)
trap 'rm -f "$REPORT_JSON" "$DIFF_FILE"' EXIT

xcrun xccov view --report --json "$RESULT_BUNDLE" > "$REPORT_JSON"
git diff --unified=0 --diff-filter=ACMR "${BASE_REVISION}...HEAD" -- '*.swift' > "$DIFF_FILE"

python3 - "$RESULT_BUNDLE" "$REPORT_JSON" "$DIFF_FILE" "$MINIMUM_COVERAGE" <<'PY'
import json
import re
import subprocess
import sys

result_bundle, report_path, diff_path, minimum_value = sys.argv[1:]
minimum = float(minimum_value)
testable_file_pattern = re.compile(
    r"(ViewModel|Service|NavigationState|Store)\.swift$"
)


def changed_lines(path):
    changes = {}
    current_path = None
    hunk_pattern = re.compile(r"^@@ -\d+(?:,\d+)? \+(\d+)(?:,(\d+))? @@")

    with open(path, "r", encoding="utf-8") as diff:
        for raw_line in diff:
            line = raw_line.rstrip("\n")
            if line.startswith("+++ b/"):
                current_path = line[6:]
                changes.setdefault(current_path, set())
                continue

            match = hunk_pattern.match(line)
            if current_path is None or match is None:
                continue

            start = int(match.group(1))
            count = int(match.group(2) or "1")
            changes[current_path].update(range(start, start + count))

    return {
        path: lines
        for path, lines in changes.items()
        if lines and testable_file_pattern.search(path)
    }


with open(report_path, "r", encoding="utf-8") as report_file:
    report = json.load(report_file)

coverage_paths = {}
for target in report.get("targets", []):
    if target.get("name", "").endswith(("Tests", "UITests")):
        continue
    for source_file in target.get("files", []):
        absolute_path = source_file.get("path", "")
        coverage_paths[absolute_path] = absolute_path

changes = changed_lines(diff_path)
covered_lines = 0
executable_lines = 0
files_without_coverage = []

for relative_path, modified_lines in sorted(changes.items()):
    absolute_path = next(
        (path for path in coverage_paths if path.endswith(f"/{relative_path}")),
        None,
    )
    if absolute_path is None:
        files_without_coverage.append(relative_path)
        continue

    process = subprocess.run(
        [
            "xcrun", "xccov", "view", "--archive", "--file",
            absolute_path, "--json", result_bundle,
        ],
        check=True,
        capture_output=True,
        text=True,
    )
    archive = json.loads(process.stdout)
    line_entries = archive.get(absolute_path, [])

    for entry in line_entries:
        if not entry.get("isExecutable", False):
            continue
        if int(entry.get("line", 0)) not in modified_lines:
            continue
        executable_lines += 1
        if int(entry.get("executionCount", 0)) > 0:
            covered_lines += 1

if files_without_coverage:
    print("No coverage data was produced for changed testable files:")
    for path in files_without_coverage:
        print(f"- {path}")
    sys.exit(1)

if executable_lines == 0:
    print("Patch coverage: no changed executable lines in testable layers.")
    print("Coverage requirement reached.")
    sys.exit(0)

coverage = round((covered_lines / executable_lines) * 100, 2)
print(f"Patch coverage: {coverage:.2f}% ({covered_lines}/{executable_lines} lines)")
print(f"Minimum required: {minimum:.2f}%")

if coverage < minimum:
    print(f"Patch coverage {coverage:.2f}% is below the required {minimum:.2f}%.")
    sys.exit(1)

print(f"Patch coverage requirement reached: {coverage:.2f}%.")
PY
