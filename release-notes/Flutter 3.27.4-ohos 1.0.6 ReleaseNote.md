### 版本概览
本次发布基于 Flutter 3.27.4，深度适配的 OpenHarmony，重点提升平台能力、性能表现与开发体验。

---

### 主要更新
**新增特性**
- Flutter支持页面级白名单设置DPI
- Flutter预加载阶段内存优化

**问题修复**
- fix: clamp text selection range to prevent RangeError in IME operations
- 修复鼠标左右键按键异常
- 解决旋转屏幕锁定问题
- 解决windowstage可能已经销毁的崩溃
- Fixed the issue where EventChannel.endOfStream() method did not trigger the onDone event in Dart
- chang DefaultOnFrameAvailableWithLock
- fix ReleaseNativeWindowBuffer crash
- update DartCallback export
- 无条件设置false，重置cached_native_window_为空
- 修复onsurfacecreate的错误判断
- Avoid deleting selected text when finishing preview
- Fixed incorrect tiltX and tiltY parameter passing in external texture scenarios
- Add simple occlusion culling for impeller
- 简化 PiPVisibilityBridge 为单一全局状态 , 修复空 catch / 线程安全注释等问题
- 增加画中画窗口轮询策略，延迟退后台dma清理
- Fix the issue where the PlatformView page does not refresh when switching to dark mode
- Fix the issue where the keyboard collapses when the subwindow pops up
- Fixed the spelling error in the channel message name 'nativeVsync' within LTPO
- 修复切换输入框时，软键盘类型存在安全类键盘时出现键盘无法唤起的问题

---

### 兼容性与配套
- 引擎构建最低要求 API：**OpenHarmony API 22**
- 应用构建目标 API：**OpenHarmony API 22**
- 应用最低运行 API：**OpenHarmony API 12**
- Flutter SDK： **3.27.4-ohos-1.0.6**（版本显示为3.27.5-ohos-1.0.6，确保解析兼容）

---

### 发布时间
2026 年 5 月 20 日

---

### 更新详情
- [详细变更日志](../CHANGELOG_OHOS.md#3274-ohos-106)

---

### 开发资源
- [开发文档与示例](https://gitcode.com/openharmony-tpc/flutter_samples/blob/master/README.md)