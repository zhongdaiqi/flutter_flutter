# Flutter 3.22.3-ohos-1.1.5 Release Notes

> **版本状态**：release<br/>
> **发布日期**：2026-08-17<br/>
> **Flutter 上游社区基线版本**：[![Flutter Version](https://img-transfer.gitcode.com?p=https%3A%2F%2Fimg.shields.io%2Fbadge%2FFlutter-3.22.3-blue.svg%3Flogo%3Dflutter&projectId=CPF-Flutter&pageUrl=https%3A%2F%2Fgitcode.com%2FCPF-Flutter)](https://github.com/flutter/flutter/commit/5dcb86f68f239346676ceb1ed1ea385bd215fba1)

---

## 版本概述

本版本为 Flutter OpenHarmony 平台 1.1.5 Release 版本，基于 Flutter 3.22.3 版本适配。本版本支持和完善 OpenHarmony 平台侧能力，提供平台化 Channel、外接纹理、云端 SDK 等特性，并优化性能。

## 版本配套

| 配套               | 版本                                                         | 说明                                                         |
| ------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| Flutter SDK        | [3.22.3-ohos-1.1.5](https://gitcode.com/CPF-Flutter/flutter_flutter/tree/3.22.4-ohos-1.1.5) | 由于 Flutter 版本解析规则，为避免版本比较解析失败，实际显示为 `3.22.4-ohos-1.1.5` |
| DevEco Studio      | DevEco Studio 26.0.0 Release                                 | 开发工具（IDE），[前往下载](https://developer.huawei.com/consumer/cn/download/deveco-studio) |
| Command Line Tools | Command Line Tools 26.0.0 Release                            | 开发工具集，[前往下载](https://developer.huawei.com/consumer/cn/download/command-line-tools-for-hmos) |
| 引擎构建最低 SDK   | 26.0.0                                                       | 编译构建引擎产物所需的最低SDK版本                            |
| 应用编译最低 SDK   | 26.0.0                                                       | 在 [build-profile.json5](https://developer.huawei.com/consumer/cn/doc/doccenter-deveco-studio/ide-hvigor-build-profile-app#section45865492619) 中配置："compileSdkVersion": "26.0.0" |
| 应用运行最低 SDK   | 5.0.5(17)                                                    | 在 [build-profile.json5](https://developer.huawei.com/consumer/cn/doc/doccenter-deveco-studio/ide-hvigor-build-profile-app#section45865492619) 中配置："compatibleSdkVersion": "5.0.5(17)" |
## 主要变更

### 新增

- 支持密码保险箱功能
- flutter项目Web页面，支持鼠标拖拽调整尺寸

### 修复

- 调整isActive的判断时机,修复前后台切换ets中的状态更新不及时的问题
- 同步三方库代码，解决鸿蒙化flutter框架编译执行其他平台产物crash的问题
- Fixed the issue with input status when switching input methods
- 修改EmbeddingNodeController.ets中可能出现的空指针问题
- 修改FlutterView.ets中鸿蒙原生事件调用逻辑,增加isActive状态判断
- 预加载操作执行后,将标记重置为false,避免RecreateSwapchain复用context时仍然走到预加载的判断逻辑中
- Fix the issue where entering Chinese first and then English causes the English to be duplicated
- Fixed the issue where typing English first and then Chinese would get overwritten
- Fixed the issue of incorrect calculation of the avoidance area under the folding machine
- Fixed the issue where deleting numbers to the left would remove two at a time
- fix adding the webview to the rotating component makes it unclickable and unscrollable
- fix(Scaffold): move OHOS status bar tap subscription to initState
- fix: update comment to match pre-edit CJK merge logic

## Changelog

- [CHANGELOG.md](../CHANGELOG.md#version20260807)

## 资料文档

- [文档](https://gitcode.com/CPF-Flutter/flutter_samples/tree/master/ohos/docs)
