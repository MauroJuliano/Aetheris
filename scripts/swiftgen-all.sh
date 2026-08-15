#!/bin/sh
set -eu

PROJECT_ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)

find "$PROJECT_ROOT" -path "*/Resources/*.lproj/Localizable.strings" -print | sort | while IFS= read -r strings_file; do
  module_root=${strings_file%%/Resources/*}

  if [ "$module_root" = "$PROJECT_ROOT" ]; then
    output="$PROJECT_ROOT/Generated/Strings.generated.swift"
  else
    output="$module_root/Generated/Strings.generated.swift"
  fi

  mkdir -p "$(dirname -- "$output")"

  swiftgen strings \
    --templateName structured-swift5 \
    --param enumName=Strings \
    "$strings_file" \
    --output "$output"
done
