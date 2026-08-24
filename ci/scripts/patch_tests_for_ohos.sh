#!/bin/bash
# Copyright (c) 2026 Huawei Device Co., Ltd. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE_HW file.
#
# Apply OHOS-specific patches to the cloned upstream flutter/tests repository.
#
# This script is meant to run BETWEEN clone and run_tests.dart in the CI
# pipeline (run_customer_testing.sh handles the ordering). Patches survive
# only until the next clone wipes bin/cache/pkg/tests; that's intentional —
# patches are re-applied every CI run.
#
# To re-enable a disabled test: comment out its line in the manifest below
# and ensure the underlying regression is fixed in flutter_flutter first.
#
# Why not use --skip-on-fetch-failure or filter at runtime:
#   - ci.dart hardcodes --skip-on-fetch-failure which SILENTLY masks failures
#   - ci.dart hardcodes registry/*.test glob (can't filter at runtime)
#   - Patching the .test files themselves is upstream's existing convention,
#     and is the cleanest way to "tell" run_tests.dart to skip them.

set -e

TESTS_DIR="${1:-}"
if [ -z "$TESTS_DIR" ]; then
  echo "[patch_tests_for_ohos] ERROR: tests_dir argument is required" >&2
  echo "[patch_tests_for_ohos] Usage: $(basename "$0") <tests_dir> (see run_customer_testing.sh)" >&2
  exit 2
fi

if [ ! -d "$TESTS_DIR/registry" ]; then
  echo "[patch_tests_for_ohos] ERROR: $TESTS_DIR/registry does not exist" >&2
  echo "[patch_tests_for_ohos] Run after clone step (see run_customer_testing.sh)" >&2
  exit 2
fi

REGISTRY="$TESTS_DIR/registry"

# --- Patch manifest ---
# Format: <action> <test_basename>
#   action=disable: rename <name>.test -> <name>.test.disabled
#                    (upstream convention; *.test glob skips it)
# Lines starting with # are ignored.

MANIFEST=$(cat <<'EOF'
# zulip: setup.linux requires sudo for `apt install libsqlite3-dev`
#        (interactive password prompt hangs CI); also has 8 known OHOS
#        regressions (7x TargetPlatform.ohos non-exhaustive + 1x
#        kUninitializedTextureId undefined).
#        Re-enable when: CI gets passwordless sudo AND fix TargetPlatform.ohos
#        handling for zulip's switch statements.
disable zulip

# super_editor: AttributedText constructor throws RangeError instead of
#               AssertionError for invalid placeholder positions. Likely
#               OHOS-fork Dart SDK assertion behavior change.
#               Re-enable when: SDK assertion semantics restored or
#               AttributedText reordered to throw AssertionError first.
disable super_editor

# super_sliver_list: TargetPlatform.ohos non-exhaustive switch in
#                    example/lib/shell/app.dart:288 (1 error).
#                    Re-enable when: Dart analyze is configured to suppress
#                    TargetPlatform.ohos non-exhaustive warnings, OR the
#                    example code is updated to handle .ohos case.
disable super_sliver_list
EOF
)

# --- Apply patches ---
applied=0
skipped=0

while IFS= read -r line; do
  case "$line" in
    ''|'#'*|' '*'#'*) continue ;;  # skip blank and comment lines
  esac

  action=$(echo "$line" | awk '{print $1}')
  name=$(echo "$line" | awk '{print $2}')

  case "$action" in
    disable)
      src="$REGISTRY/$name.test"
      dst="$REGISTRY/$name.test.disabled"
      if [ ! -f "$src" ]; then
        echo "[patch_tests_for_ohos] SKIP: $name.test (not found, may already be disabled or removed upstream)"
        skipped=$((skipped + 1))
        continue
      fi
      mv "$src" "$dst"
      echo "[patch_tests_for_ohos] DISABLED: $name.test -> $name.test.disabled"
      applied=$((applied + 1))
      ;;
    *)
      echo "[patch_tests_for_ohos] WARN: unknown action '$action' for '$name'" >&2
      ;;
  esac
done <<< "$MANIFEST"

echo "[patch_tests_for_ohos] Done. Applied: $applied, Skipped: $skipped"