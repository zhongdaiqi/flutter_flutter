#!/bin/bash
# Copyright (c) 2025 Huawei Device Co., Ltd. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE_HW file.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

compile_tester() {
    WORK_DIR=$(pwd)
    PROJECT_DIR="$WORK_DIR/third_party"
    ARCHIVE_DIR="$WORK_DIR/Archive/out"

    log_info "Checking Flutter environment"
    run_cmd "flutter doctor -v"

    cd "$PROJECT_DIR/flutter_tester"

    local modes=("debug" "profile" "release")
    BUILD_MODE="${modes[$((RANDOM % 3))]}"

    log_info "Building tester in $BUILD_MODE mode"
    local build_cmd="flutter build hap --$BUILD_MODE"
    run_cmd "$build_cmd"

    # Archive HAP file
    local hap_source="$PROJECT_DIR/flutter_tester/ohos/entry/build/default/outputs/default/entry-default-unsigned.hap"
    local hap_dest="$ARCHIVE_DIR/entry-default-unsigned.hap"

    if [[ -f "$hap_source" ]]; then
        log_info "Copying HAP file to archive"
        run_cmd "cp $hap_source $hap_dest"
    else
        log_error "HAP file not found: $hap_source"
        exit 1
    fi
}

compile_tester "$@"
