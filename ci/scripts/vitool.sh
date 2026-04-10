#!/bin/bash
# Copyright (c) 2025 Huawei Device Co., Ltd. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE_HW file.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

customer_testing() {
    local ci_dir="$(dirname "$SCRIPT_DIR")"
    local project_root="$(dirname "$ci_dir")"
    local test_dir="$project_root/dev/tools/vitool.sh"

    # 校验目录存在
    if [ ! -d "$test_dir" ]; then
        log_error "测试目录不存在: $test_dir"
        exit 1
    fi

    cd "$test_dir" || {
        log_error "无法进入目录: $test_dir"
        exit 1
    }

    log_info "进入测试目录: $(pwd)"

    if ! run_cmd "flutter test"; then
        log_error "vitool 自动化测试不通过"
        exit 1
    fi

    log_info "vitool 自动化测试通过"
}

vitool "$@"