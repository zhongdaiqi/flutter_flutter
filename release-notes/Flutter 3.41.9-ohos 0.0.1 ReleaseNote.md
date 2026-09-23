## 版本概述
本版本为Flutter OpenHarmony平台0.0.1版本（canary1），基于Flutter 3.41.9版本适配。本版本支持和完善OpenHarmony平台侧能力，提供平台化Channel、外接纹理、云端SDK等特性，并优化性能。

## 版本配套

| 配套               | 版本                                                         | 说明                                                         |
| ------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| Flutter SDK        | [3.41.9-ohos-0.0.1](https://gitcode.com/CPF-Flutter/flutter_flutter/tree/3.41.10-ohos-0.0.1-canary1) | 由于 Flutter 版本解析规则，为避免版本比较解析失败，实际显示为 `3.41.10-ohos-0.0.1-canary1` |
| DevEco Studio      | DevEco Studio 6.0.0 Release 及以上                           | 开发工具（IDE），[前往下载](https://developer.huawei.com/consumer/cn/download/deveco-studio) |
| Command Line Tools | Command Line Tools 6.0.0 Release 及以上                      | 开发工具集，[前往下载](https://developer.huawei.com/consumer/cn/download/command-line-tools-for-hmos) |
| 引擎构建最低 SDK   | 6.1.0(23)                                                    | 编译构建引擎产物所需的最低SDK版本                            |
| 应用编译最低 SDK   | 6.0.0(20)                                                    | 在 [build-profile.json5](https://developer.huawei.com/consumer/cn/doc/doccenter-deveco-studio/ide-hvigor-build-profile-app#section45865492619) 中配置："compileSdkVersion": "6.0.0(20)" |
| 应用运行最低 SDK   | 5.0.5(17)                                                    | 在 [build-profile.json5](https://developer.huawei.com/consumer/cn/doc/doccenter-deveco-studio/ide-hvigor-build-profile-app#section45865492619) 中配置："compatibleSdkVersion": "5.0.5(17)" |

## 基础特性

- 支持OpenHarmony平台Flutter Channel
- 支持OpenHarmony平台Flutter Engine
- 支持OpenHarmony平台Flutter命令行工具
- 支持外接纹理
- 支持云端SDK

## Bug修复
- 修复旋转黑屏问题
- 修复插件注册失败问题
- 修复点击状态栏滚动组件回滚失效问题
- 修复setApplicationLocale原生侧接收失败问题
- 修复OHOS侧SetSemanticsTreeEnabled未生效问题

## Changelog
- [3.41.9-ohos-0.0.1](../CHANGELOG_OHOS.md)

## 赋能文档
- [文档链接](https://gitcode.com/openharmony-tpc/flutter_samples/tree/master/ohos/docs)
