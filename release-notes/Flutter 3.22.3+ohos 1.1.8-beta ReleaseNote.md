# Flutter 3.22.3+ohos-1.1.8-beta Release Notes

> **版本状态**：beta<br/>
> **发布日期**：2026-10-24<br/>**Flutter 上游社区基线版本**：[![Flutter Version](https://img-transfer.gitcode.com?p=https%3A%2F%2Fimg.shields.io%2Fbadge%2FFlutter-3.22.3-blue.svg%3Flogo%3Dflutter&projectId=CPF-Flutter&pageUrl=https%3A%2F%2Fgitcode.com%2FCPF-Flutter)](https://github.com/flutter/flutter/commit/5dcb86f68f239346676ceb1ed1ea385bd215fba1)

---

## 版本概述

本版本为 Flutter OpenHarmony 平台 1.1.8-beta 版本，基于 Flutter 3.22.3 版本适配。本版本新增 OHOS 稳定版本升级能力与引擎 ccache 构建选项；修复 PlatformView 仿射变换与坐标、鼠标光标与系统鼠标样式、文本选择范围、BigInt 解码、GIF 循环计数、系统字体权重冷启动、hvigor 自定义构建模式映射、DevEco 签名适配、ModalBarrier 无障碍语义等多方面问题。

## 版本配套

| 配套               | 版本                                                         | 说明                                                         |
| ------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| Flutter SDK        | [3.22.3+ohos-1.1.8-beta](https://gitcode.com/CPF-Flutter/flutter_flutter/tree/3.22.3+ohos-1.1.8-beta) | 版本号采用 `+ohos` build metadata 格式                       |
| DevEco Studio      | DevEco Studio 26.0.0 Release                                 | 开发工具（IDE），[前往下载](https://developer.huawei.com/consumer/cn/download/deveco-studio) |
| Command Line Tools | Command Line Tools 26.0.0 Release                            | 开发工具集，[前往下载](https://developer.huawei.com/consumer/cn/download/command-line-tools-for-hmos) |
| 引擎构建最低 SDK   | 26.0.0                                                       | 配置 `DEVECO_SDK_HOME` 环境变量指向 SDK 路径                 |
| 应用编译最低 SDK   | 26.0.0                                                       | 在 [build-profile.json5](https://developer.huawei.com/consumer/cn/doc/doccenter-deveco-studio/ide-hvigor-build-profile-app#section45865492619) 中配置："compileSdkVersion": "26.0.0" |
| 应用运行最低 SDK   | 5.0.5(17)                                                    | 在 [build-profile.json5](https://developer.huawei.com/consumer/cn/doc/doccenter-deveco-studio/ide-hvigor-build-profile-app#section45865492619) 中配置："compatibleSdkVersion": "5.0.5(17)" |

## 主要变更

### 新增

- 【3.22】feat(Upgrade): support upgrading to the latest OHOS stable release tag
- feat: add --use-ccache option to ohos.py to enable ccache engine builds

### 修复

- 【3.22】fix(PlatformView): handle affine transform as a standalone platform message
- Fix PlatformView touch/mouse/axis coordinate space errors and left-click offset on windowed HarmonyOS PC
- fix cursor selection range issue
- fix(FlutterView): use window effective density for viewport dpr updates
- fix: SystemMouseCursors on OHOS
- fix: add missing space after --unuse-bisheng and stop swallowing gn failures
- fix: decode negative BigInt in standard message codecs
- fix: honor embedded GIF loop count on OHOS
- fix(Embedding): apply system font weight scale on cold start
- fix(ohos): map custom hvigor build modes to standard flutter modes
- fix(Upgrade): prefer the +ohos tag naming over the legacy -ohos one
- fix: Adapt the DevEco signature configuration to the new version
- 【3.22】fix(Widgets): expose dismissible ModalBarrier semantics on OHOS

## Changelog

- [CHANGELOG.md](../CHANGELOG.md#version20261024)

## 资料文档

- [文档](https://gitcode.com/CPF-Flutter/flutter_samples/tree/master/ohos/docs)
