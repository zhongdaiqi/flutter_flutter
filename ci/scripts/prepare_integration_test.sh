#!/bin/bash
# Copyright (c) 2025 Huawei Device Co., Ltd. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE_HW file.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

WORK_DIR=$(pwd)
PROJECT_DIR="$WORK_DIR/third_party"
ARCHIVE_DIR="$WORK_DIR/Archive/out"

prepare_integration_test() {
    local flutter_version="$1"

    if [[ -z "$flutter_version" ]]; then
        log_error "flutter_version is required"
        exit 1
    fi

    local tests_dir="$PROJECT_DIR/tests"
    if [[ ! -d "$tests_dir" ]]; then
        log_error "tests directory not found: $tests_dir"
        exit 1
    fi

    local resource_dir="$tests_dir/resource"
    run_cmd "mkdir -p $resource_dir"

    log_info "Generating config files for integration test"

    log_info "flutter.version: $flutter_version"
    echo "$flutter_version" > "$resource_dir/flutter.version"

    local pr_no=""
    if [[ -n "$PR_URL" ]]; then
        pr_no=$(echo "$PR_URL" | grep -oP 'merge_requests/\K[0-9]+')
    fi
    if [[ -n "$pr_no" ]]; then
        log_info "flutter.pr_no: $pr_no"
        echo "$pr_no" > "$resource_dir/flutter.pr_no"
    fi

    log_info "Moving tests to archive directory"
    run_cmd "mv $PROJECT_DIR/tests $ARCHIVE_DIR/"

    log_info "Integration test preparation completed"
}

prepare_integration_test "$@"
