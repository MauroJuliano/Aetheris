#!/bin/bash

set -euo pipefail

RESULT_PATH="${1:-DerivedData}"
MINIMUM_COVERAGE="${2:-40}"

if ! [[ "$MINIMUM_COVERAGE" =~ ^[0-9]+([.][0-9]+)?$ ]]; then
  echo "Invalid minimum coverage: $MINIMUM_COVERAGE"
  exit 1
fi

if [[ "$RESULT_PATH" == *.xcresult ]]; then
  RESULT_BUNDLE="$RESULT_PATH"
else
  RESULT_BUNDLE=$(find "$RESULT_PATH" \
    -type d \
    -name "*.xcresult" \
    -exec stat -f '%m %N' {} + \
    | sort -nr \
    | head -n 1 \
    | cut -d ' ' -f 2- || true)
fi

if [[ -z "$RESULT_BUNDLE" || ! -d "$RESULT_BUNDLE" ]]; then
  echo "No xcresult bundle was found at $RESULT_PATH."
  exit 1
fi

COVERAGE_JSON=$(mktemp)
trap 'rm -f "$COVERAGE_JSON"' EXIT

xcrun xccov view \
  --report \
  --json \
  "$RESULT_BUNDLE" > "$COVERAGE_JSON"

COVERAGE=$(python3 - "$COVERAGE_JSON" <<'PY'
import json
import re
import sys

with open(sys.argv[1], "r", encoding="utf-8") as file:
    report = json.load(file)

covered_lines = 0
executable_lines = 0
included_files = 0
testable_file_pattern = re.compile(
    r"(ViewModel|Service|NavigationState|Store)\.swift$"
)

for target in report.get("targets", []):
    name = target.get("name", "")
    if name.endswith(("Tests", "UITests")):
        continue

    for source_file in target.get("files", []):
        path = source_file.get("path", "")
        if not testable_file_pattern.search(path):
            continue

        included_files += 1
        covered_lines += int(source_file.get("coveredLines", 0))
        executable_lines += int(source_file.get("executableLines", 0))

if included_files == 0 or executable_lines == 0:
    print("0")
else:
    print(round((covered_lines / executable_lines) * 100, 2))
PY
)

echo "Testable-layer coverage: ${COVERAGE}%"
echo "Minimum required: ${MINIMUM_COVERAGE}%"

python3 - "$COVERAGE" "$MINIMUM_COVERAGE" <<'PY'
import sys

coverage = float(sys.argv[1])
minimum = float(sys.argv[2])

if coverage < minimum:
    print(f"Coverage {coverage:.2f}% is below the required {minimum:.2f}%.")
    sys.exit(1)

print(f"Coverage requirement reached: {coverage:.2f}%.")
PY
