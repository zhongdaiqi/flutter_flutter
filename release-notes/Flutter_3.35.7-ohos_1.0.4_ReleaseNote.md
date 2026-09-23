# Flutter 3.35.7-ohos-1.0.4 Release Notes

> **版本状态**：release<br/>
> **发布日期**：2026-08-17<br/>
> **Flutter 上游社区基线版本**：[![Flutter Version](https://img-transfer.gitcode.com?p=https%3A%2F%2Fimg.shields.io%2Fbadge%2FFlutter-3.35.7-blue.svg%3Flogo%3Dflutter&projectId=CPF-Flutter&pageUrl=https%3A%2F%2Fgitcode.com%2FCPF-Flutter)](https://github.com/flutter/flutter/commit/035316565ad77281a75305515e4682e6c4c6f7ca)

---

## 版本概述

本版本为 Flutter OpenHarmony 平台 1.0.4 Release 版本，基于 Flutter 3.35.7 版本适配。本版本支持和完善 OpenHarmony 平台侧能力，提供平台化 Channel、外接纹理、云端 SDK 等特性，并优化性能。

## 版本配套

| 配套               | 版本                                                         | 说明                                                         |
| ------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| Flutter SDK        | [3.35.7-ohos-1.0.4](https://gitcode.com/CPF-Flutter/flutter_flutter/tree/3.35.8-ohos-1.0.4) | 由于 Flutter 版本解析规则，为避免版本比较解析失败，实际显示为 `3.35.8-ohos-1.0.4` |
| DevEco Studio      | DevEco Studio 26.0.0 Release                                 | 开发工具（IDE），[前往下载](https://developer.huawei.com/consumer/cn/download/deveco-studio) |
| Command Line Tools | Command Line Tools 26.0.0 Release                            | 开发工具集，[前往下载](https://developer.huawei.com/consumer/cn/download/command-line-tools-for-hmos) |
| 引擎构建最低 SDK   | 26.0.0                                                       | 编译构建引擎产物所需的最低SDK版本                            |
| 应用编译最低 SDK   | 26.0.0                                                       | 在 [build-profile.json5](https://developer.huawei.com/consumer/cn/doc/doccenter-deveco-studio/ide-hvigor-build-profile-app#section45865492619) 中配置："compileSdkVersion": "26.0.0" |
| 应用运行最低 SDK   | 5.0.5(17)                                                    | 在 [build-profile.json5](https://developer.huawei.com/consumer/cn/doc/doccenter-deveco-studio/ide-hvigor-build-profile-app#section45865492619) 中配置："compatibleSdkVersion": "5.0.5(17)" |

## 主要变更

### 新增

- 支持密码保险箱功能
- flutter page pause when invisible，页面不可见时暂停渲染
- [OHOS] Add DMA zero-copy image decode path with P3 support
- flutter 项目 Web 页面支持鼠标拖拽调整尺寸
- [OHOS] Add async APIs for FlutterEngine spawn/destroy to prevent ANR

### 变更

- LTPO feature is enabled by default

### 修复

- fix: Fix window decoration state not correctly restored after exiting immersive fullscreen on PC
- Flutter 鼠标跨区域拖动 pointerup 丢失修复
- 【3.35】候选词位置为光标的右下角
- 同步三方库代码，解决字体内存泄漏问题
- 手势取消清除遗留 finger
- fix(Scaffold): move status bar tap subscription init to initState to prevent leak on ohos
- 调整 isActive 的判断时机，修复前后台切换 ets 中的状态更新不及时的问题
- fix: DT CPP
- 修改分栏功能获取应用图标的方式，从硬编码图片名改为通过资源 id 获取，避免在自定义图标文件名时失败的问题
- Fixed: flutter drive execution failure
- fix: prevent incorrect backspace during pre-edit multi-select
- 同步三方库代码，解决鸿蒙化 flutter 框架编译执行其他平台产物 crash 的问题
- fix(Impeller): add missing kB10G10R10A2UNorm Metal pixel format mapping
- 提高分栏功能中弹窗消失时主动恢复焦点的逻辑健壮性，解决当弹窗前焦点未聚焦到页面某个组件时恢复行为异常导致卡死的问题
- 修改 EmbeddingNodeController.ets 中可能出现的空指针问题
- Fixes crash when adding and removing multiple page-based route (#177338)
- Fixed the issue with input status when switching input methods
- Fix the issue where entering Chinese first and then English causes the English to be duplicate
- Fixed the issue where typing English first and then Chinese would get overwritten
- 修复折叠机下避让区域计算错误问题
- Fixed the issue where deleting numbers to the left would remove two at a time
- 预加载操作执行后将标记重置为 false，避免 RecreateSwapchain 复用 context 时仍然走到预加载的判断逻辑中
- fix adding the webview to the rotating component makes it unclickable and unscrollable
- [OHOS] Fix PixelMap ReadPixels temp buffer cleanup
- Fix the template syntax error problem

### 性能

- Enable static snapshot linking for OHOS debug mode
- ohos 开启指针压缩
- 发送低内存警告，触发图像缓存清理

## Changelog

- [CHANGELOG_OHOS.md](../CHANGELOG_OHOS.md#version20260808)

## 资料文档

- [文档](https://gitcode.com/CPF-Flutter/flutter_samples/tree/master/ohos/docs)

