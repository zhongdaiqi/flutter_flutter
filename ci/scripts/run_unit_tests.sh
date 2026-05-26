#!/bin/bash
# Copyright (c) 2025 Huawei Device Co., Ltd. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE_HW file.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
LOG_DIR="$WORK_DIR/Archive/out/unit_tests_logs"
LOG_FILE="$LOG_DIR/unit_tests_$TIMESTAMP.log"

# 加载公共函数库
source "$SCRIPT_DIR/test_utils.sh"

# 测试模式: "gate" (门禁) 或 "daily" (每日构建)
TEST_MODE="${1:-gate}"
shift 2>/dev/null || true

if [[ -n "${PR_URL:-}" && "$TEST_MODE" != "gate" ]]; then
    log_info "Skipping unit test"
    exit 0
fi

# 配置参数
UT_TIMEOUT=${UT_TIMEOUT:-1200}
UT_DEFAULT_CMD=${UT_DEFAULT_CMD:-"flutter test --no-pub --reporter compact"}

# 获取共享 PUB_CACHE
export PUB_CACHE=$(get_shared_pub_cache)
mkdir -p "$PUB_CACHE"

mkdir -p "$LOG_DIR"

print_log_on_exit() {
    if [ "$TEST_MODE" = "gate" ]; then
        echo "========== LOG FILE CONTENT ($LOG_FILE) =========="
        cat "$LOG_FILE"
        echo "========== END OF LOG FILE =========="
    fi
}

trap print_log_on_exit EXIT

# 全局变量
TOTAL_PASSED=0
TOTAL_FAILED=0
FAILED_TESTS=()
PIDS=()
RESULTS=()

# 运行单个测试（并行）
run_single_test() {
    local test_idx="$1"
    local path="$2"
    local cmd="$3"
    local name=$(basename "$path")
    local test_log="$LOG_DIR/test_${test_idx}_${TIMESTAMP}.log"
    local result_file="$LOG_DIR/result_${test_idx}_${TIMESTAMP}.tmp"
    local start_delay=$((test_idx * 2))
    
    # 后台执行
    {
        # 启动延迟
        [ $test_idx -gt 0 ] && sleep $start_delay
        
        local start_time=$(date +%s)
        local status="PASSED"
        local exit_code=0
        
        # 重试机制（最多3次）
        for retry in 0 1 2; do
            if timeout $UT_TIMEOUT bash -c "cd '$SCRIPT_DIR/../../$path' && $cmd" >> "$test_log" 2>&1; then
                status="PASSED"
                break
            else
                exit_code=$?
                if [ $exit_code -eq 124 ]; then
                    status="TIMEOUT"
                    break
                elif grep -q "Waiting for another flutter command" "$test_log" 2>/dev/null; then
                    if [ $retry -lt 2 ]; then
                        sleep 10
                        continue
                    fi
                    status="FAILED"
                else
                    status="FAILED"
                    break
                fi
            fi
        done
        
        local end_time=$(date +%s)
        
        # 写入结果（使用简单格式，更容易解析）
        echo "$test_idx" > "$result_file"
        echo "$name" >> "$result_file"
        echo "$status" >> "$result_file"
        echo "$start_time" >> "$result_file"
        echo "$end_time" >> "$result_file"
        
    } &
    
    PIDS[$test_idx]=$!
}

# 等待并收集结果
collect_results() {
    local total=${#PIDS[@]}
    local completed=0
    
    for idx in "${!PIDS[@]}"; do
        local pid=${PIDS[$idx]}
        local result_file="$LOG_DIR/result_${idx}_${TIMESTAMP}.tmp"
        local test_log="$LOG_DIR/test_${idx}_${TIMESTAMP}.log"
        
        # 等待进程完成
        wait $pid
        
        # 读取结果
        if [ -f "$result_file" ]; then
            local test_idx=$(sed -n '1p' "$result_file")
            local name=$(sed -n '2p' "$result_file")
            local status=$(sed -n '3p' "$result_file")
            local start_time=$(sed -n '4p' "$result_file")
            local end_time=$(sed -n '5p' "$result_file")
            local duration=$((end_time - start_time))
            
            completed=$((completed + 1))
            
            case $status in
                "PASSED")
                    log_info "✓ [$completed/$total] $name (${duration}s)"
                    ;;
                *)
                    log_warn "✗ [$completed/$total] $name (${duration}s) - $status"
                    ;;
            esac
            
            # 更新计数
            case $status in
                "PASSED")
                    TOTAL_PASSED=$((TOTAL_PASSED + 1))
                    ;;
                *)
                    TOTAL_FAILED=$((TOTAL_FAILED + 1))
                    FAILED_TESTS+=("$name")
                    ;;
            esac
            
            # 写入日志
            write_log "$LOG_FILE" "$status" "$name (duration: ${duration}s)"
            
            # 合并详细日志
            if [ -f "$test_log" ]; then
                echo -e "\n========== $name ==========\n" >> "$LOG_FILE"
                cat "$test_log" >> "$LOG_FILE"
                rm -f "$test_log"
            fi
            
            rm -f "$result_file"
        else
            completed=$((completed + 1))
            log_error "[$completed/$total] test_$idx - ERROR"
            TOTAL_FAILED=$((TOTAL_FAILED + 1))
            FAILED_TESTS+=("test_$idx")
        fi
    done
}

# 主流程
ALL_TESTS=("$@")

log_step "Parallel Test Execution"
log_info "Tests: ${#ALL_TESTS[@]}, Log: $LOG_FILE"

# 启动所有测试
write_log "$LOG_FILE" "INFO" "Starting parallel test execution"

for idx in "${!ALL_TESTS[@]}"; do
    test_spec="${ALL_TESTS[$idx]}"
    parsed=$(parse_test_spec "$test_spec" "$UT_DEFAULT_CMD")
    path=$(echo "$parsed" | cut -d'|' -f1)
    cmd=$(echo "$parsed" | cut -d'|' -f2)
    
    run_single_test "$idx" "$path" "$cmd"
done

# 等待并收集结果
collect_results

# 输出汇总
log_step "Summary: $TOTAL_PASSED passed, $TOTAL_FAILED failed"

if [ ${#FAILED_TESTS[@]} -gt 0 ]; then
    log_warn "Failed: ${FAILED_TESTS[*]}"
fi

log_info "Log: $LOG_FILE"

# 记录最终状态
write_log "$LOG_FILE" "INFO" "Test execution completed: $TOTAL_PASSED passed, $TOTAL_FAILED failed"

# 返回退出码
if [ $TOTAL_FAILED -gt 0 ]; then
    exit 1
fi
trap - EXIT
exit 0
