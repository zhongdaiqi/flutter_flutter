### 版本概览
本次发布基于 Flutter 3.35.7，深度适配的 OpenHarmony，重点提升平台能力、性能表现与开发体验。

---

### 主要更新
**新增特性**
- Flutter支持页面级白名单设置DPI
- Flutter预加载阶段内存优化

**问题修复**
- fix: clamp text selection range to prevent RangeError in IME operations
- 修复鼠标左右键按键异常
- 解决旋转屏幕问题
- [OHOS] Fix physical PlatformView text-input handoff
- [OHOS] Avoid throwing from detached PlatformView render
- 解决windowstage可能已经销毁的崩溃
- [OHOS] Fix PlatformView detach lifecycle
- Fixed the issue where EventChannel.endOfStream() method did not trigger the onDone event in Dart
- [ohos] Align debug assemble failure fix with 0fd346da7eab
- [ohos] Stop debug packaging after flutter assemble failure
- fix ReleaseNativeWindowBuffer crash
- Fix OHOS platform view direction binding
- Fixed the issue where navigator steals/grabs focus.
- 简化 PiPVisibilityBridge 为单一全局状态 , 修复空 catch / 线程安全注释等问题
- 增加画中画窗口轮询策略，延迟退后台dma清理
- 无条件设置false，重置cached_native_window_为空
- [OHOS] Refine SearchAnchor overflow scheduling
- [OHOS] Avoid transient release overflow in SearchAnchor
- 无条件设置false，重置cached_native_window_
- [OHOS] Avoid deleting selected text when finishing preview
- Fixed incorrect tiltX and tiltY parameter passing in external texture scenarios
- 修复onsurfacecreate的错误判断
- Add simple occlusion culling for impeller
- feat:Window three-button, window menu bar supports safe area avoidance.
- feat:Adapt the setSpecificSystemBarEnabled interface in ArkUI
- Fix the issue where the PlatformView page does not refresh when switching to dark mode
- Fixed the bug of incorrect rate reporting for LTPO components, and added new debugging methods for LTPO
- Fix the issue where the keyboard collapses when the subwindow pops up

---

### 兼容性与配套
- 引擎构建最低要求 API：**OpenHarmony API 23**
- 应用构建目标 API：**OpenHarmony API 23**
- 应用最低运行 API：**OpenHarmony API 12**
- Flutter SDK：**3.35.7-ohos-1.0.1**（版本显示为3.35.8-ohos-1.0.1，确保解析兼容）

---

### 发布时间
2026 年 5 月 20 日

---

### 更新详情
- [详细变更日志](../CHANGELOG_OHOS.md#3357-ohos-101)

---

### 开发资源
- [开发文档与示例](https://gitcode.com/openharmony-tpc/flutter_samples/blob/master/README.md)