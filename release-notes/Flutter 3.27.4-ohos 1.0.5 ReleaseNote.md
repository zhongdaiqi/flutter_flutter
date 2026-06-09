## 版本概述
本版本为基于Flutter 3.27.4适配的OpenHarmony版本。本版本支持和完善OpenHarmony平台侧能力，提升稳定性。

## 新增特性
- 毕昇编译器替换，开启优化选项
- Click the status bar to automatically return to the top
- 增加路由跳转和标签页切换的检测能力
- [impeller] Vulkan backend supports skipping rendering when dirty region is 0.
- 【3.27】Add monitor for external textures visible area
- 退后台释放DMA资降低内存

## Bug修复
- Addressed the issue where cropping with original dimensions in a transformed coordinate system resulted in a size mismatch.
- fix: keyboard home key is not consistent
- 修复软键盘直接弹起到界面上问题
- fix: caplock and return keys are not working with keyboard
- Fixed: onInactive method was not triggered when the WebView became invisible.
- [Impeller] match Skia's old VMA default block size.
- Fix the issue of keyboard popping up and flickering in PlatformView input box
- 修复使用multiply混合模式时，在某些GPU上画面变白/变灰的问题
- Frame gate enabled: keep draining producer queue, but do not schedule
- Fix the issue where the clipboard cannot paste content in a custom format
- [Impeller] Fixed an issue where gradient effects on HarmonyOS devices exhibited clipping. With mediump enabled by default, `IPOrderedDither8x8 uint(dest.x)` and `uint(dest.y)` might experience precision loss on some GPU chips.
- 修复多PlatformView场景下输入框失焦问题
- fix: false error log when notify page change successfully
- Set VMA default block size.
- Fix cache errors related to YUVConversionVK.

## 版本发布时间
2026年3月16日

## 版本配套
- 引擎构建最低要求 API：**OpenHarmony API 20**
- 应用构建目标 API：**OpenHarmony API 20**
- 应用最低运行 API：**OpenHarmony API 12**
- Flutter SDK：**3.27.4-ohos-1.0.5**（由于flutter版本解析规则，为了避免版本比较解析失败，将显示为3.27.5-ohos-1.0.5）

## Changelog
- [3.27.4-ohos-1.0.5](../CHANGELOG_OHOS.md)

## 赋能文档
- [文档链接](https://gitcode.com/openharmony-tpc/flutter_samples/tree/master/ohos/docs)