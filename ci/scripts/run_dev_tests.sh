#!/bin/bash
# Copyright (c) 2025 Huawei Device Co., Ltd. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE_HW file.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

# 通用测试函数，接收测试目录和命令作为参数
run_dev_test() {
    local test_dir="$1"
    local test_cmd="$2"
    local test_name="$3"
    
    # 校验目录存在
    if [ ! -d "$test_dir" ]; then
        log_error "测试目录不存在: $test_dir"
        return 1
    fi

    cd "$test_dir" || {
        log_error "无法进入目录: $test_dir"
        return 1
    }

    log_info "进入测试目录: $(pwd)"

    if ! run_cmd "$test_cmd"; then
        log_error "$test_name 测试不通过"
        return 1
    fi

    log_info "$test_name 测试通过"
}

# 主逻辑：循环执行所有传入的测试
main() {
    local ci_dir="$(dirname "$SCRIPT_DIR")"
    local project_root="$(dirname "$ci_dir")"
    
    # 检查参数数量
    if [ $# -eq 0 ]; then
        log_error "用法: $0 <测试目录> <测试命令> [测试名称] ..."
        exit 1
    fi
    
    # 逐个执行测试（三元组：目录、命令、名称）
    local failed=0
    while [ $# -ge 2 ]; do
        local test_dir="$project_root/$1"
        local test_cmd="$2"
        local test_name="${3:-测试}"
        
        if ! run_dev_test "$test_dir" "$test_cmd" "$test_name"; then
            failed=$((failed + 1))
        fi
        
        shift 3  # 移动到下一个三元组
    done
    
    if [ $failed -gt 0 ]; then
        log_error "$failed 个测试失败"
        exit 1
    fi
    
    log_info "所有测试通过"
}

main "$@"
