#! /bin/bash
# Copyright (c) 2025 Huawei Device Co., Ltd. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE_HW file.
#
# USE IN CI
# compileCMD: sh ./third_party/flutter_flutter/ci/compile.sh

ROOT_DIR=$(pwd)
# Project directory
PROJECT_DIR="$ROOT_DIR/third_party"
# Archive directory
ARCHIVE_DIR="$ROOT_DIR/Archive/out"
# Build mode, randomly select from debug, profile and release
MODES=("debug" "profile" "release")
BUILD_MODE=${MODES[$RANDOM % ${#MODES[@]}]}

# Target branch
TARGET_FLUTTER_BRANCH="3.22.0-ohos"

# Check environment
function check_env() {
    echo "Check environment"
    # Set environment variables
    # command-line-tools
    export TOOL_HOME=/home/tools/command-line-tools
    export DEVECO_SDK_HOME=$TOOL_HOME/sdk
    export PATH=$DEVECO_SDK_HOME/default/openharmony/toolchains:$TOOL_HOME/ohpm/bin:$TOOL_HOME/hvigor/bin:$TOOL_HOME/tool/node/bin:$PATH
    # Flutter
    export PUB_CACHE=/home/tools/Flutter/PUB
    export PUB_HOSTED_URL=https://pub.flutter-io.cn
    export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
    # Flutter gclient
    export PATH=/home/tools/depot_tools:$PATH
    export DEPOT_TOOLS_UPDATE=0
    export GCLIENT_SUPPRESS_GIT_VERSION_WARNING=1
    # Flutter cipd
    export CIPD_CACHE_DIR=/home/tools/cipd_cache
    export CIPD_HTTP_USER_AGENT_PREFIX="offline"
    export CIPD_NO_SELF_UPDATE=true
    # llvm
    export PATH=$DEVECO_SDK_HOME/default/openharmony/native/llvm/bin:$PATH
    echo "$ set"
    set
}

# Package SDK
function pack_flutter() {
    echo "Packaging SDK"
    echo "$ cd $PROJECT_DIR/flutter_flutter"
    cd $PROJECT_DIR/flutter_flutter
    echo "$ zip -r $ARCHIVE_DIR/flutter.ohos.zip *"
    zip -r $ARCHIVE_DIR/sdk-$TARGET_FLUTTER_BRANCH.zip *
}

# Compile Tester
function compile_tester() {
    echo "Compiling Tester"
    # Check flutter environment
    export PATH=$PROJECT_DIR/flutter_flutter/bin:$PATH
    echo "$ echo \$PATH"
    echo $PATH
    echo "$ flutter doctor -v"
    flutter doctor -v

    echo "$ cd $PROJECT_DIR/flutter_tester"
    cd $PROJECT_DIR/flutter_tester
    flutter build hap --$BUILD_MODE
    # Archive
    cp $PROJECT_DIR/flutter_tester/ohos/entry/build/default/outputs/default/entry-default-unsigned.hap $ARCHIVE_DIR/entry-default-unsigned.hap
    if [ $? -ne 0 ]; then
        echo "Failed to execute: flutter build hap --$BUILD_MODE"
        return 1
    fi
}

function compile() {
    echo "Starting compilation"
    check_env

    pack_flutter
    if [ $? -ne 0 ]; then
        echo "Failed to execute: pack_flutter"
        return 1
    fi

    compile_tester
    if [ $? -ne 0 ]; then
        echo "Failed to execute: compile_tester"
        return 1
    fi
    echo "Compilation phase completed"
}

compile $@
exit $?
