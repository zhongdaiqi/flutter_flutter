## 版本概述
本版本为Flutter OpenHarmony平台0.0.3版本，基于Flutter 3.35.7版本适配。本版本支持和完善OpenHarmony平台侧能力，提供平台化Channel、外接纹理、云端SDK等特性，并优化性能。

### 主要更新

**新增特性**

- 手机端支持密码保险箱功能（依赖待发布API）

**问题修复**

- Fix OHOS platform view active touch cancellation
- Fix the issue where Shift + left arrow can only select one character
- Frame Buffer PTS Optimization for Delayed Frame Presentation
- fix NavigationChannel crash
- fix White screen issue when restoring after minimizing the window
- Frame Buffer PTS Optimization for Delayed Frame Presentation
- [OHOS] Fix PixelMap ReadPixels temp buffer cleanup
- [OHOS] Restore PixelMap ReadPixels tight-row semantics
- fix：修复性能雷达滑动丢帧上报字段值问题

## 版本配套
- 引擎构建最低要求 API：**待发布最新API**
- 应用构建目标 API：**待发布最新API**
- 应用最低运行 API：**待发布最新API**
- Flutter SDK：**3.35.7-ohos-1.0.4-beta**（由于flutter版本解析规则，为了避免版本比较解析失败，将显示为3.35.8-ohos-1.0.4-beta）

## Changelog
- [3.35.7-ohos-1.0.4-beta](../CHANGELOG_OHOS.md)

## 赋能文档
- [文档链接](https://gitcode.com/openharmony-tpc/flutter_samples/tree/master/ohos/docs)
