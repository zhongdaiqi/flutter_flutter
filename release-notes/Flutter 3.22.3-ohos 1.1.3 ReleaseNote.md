### 版本概览
本次发布基于 Flutter 3.22.3，深度适配的 OpenHarmony，重点提升平台能力、性能表现与开发体验。

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
- fix ReleaseNativeWindowBuffer crash
- update DartCallback export
- 无条件设置false，重置cached_native_window_为空
- 简化 PiPVisibilityBridge 为单一全局状态 , 修复空 catch / 线程安全注释等问题
- 增加画中画窗口轮询策略，延迟退后台dma清理
- 无条件设置false，重置cached_native_window_
- 修复onsurfacecreate的错误判断
- Fixed incorrect tiltX and tiltY parameter passing in external texture scenarios
- Fix the issue where the PlatformView page does not refresh when switching to dark mode
- extend timeouts of all targets in .ci.yaml (#53912)
- [flutter_releases] Flutter stable 3.22.3 Engine Cherrypicks (#53686)
- [CP-stable]Fix rendering corruption by Flutter and GDK sharing the same OpenGL context (#53183)
- [CP][Impeller] Create framebuffer blend vertices based on the snapshot's texture size instead of coverage (#52790) (#53235)
- [Impeller][CP] dont segfault when tessellating empty polygons. (#53212)
- [CP][Impeller] relax conditions for SkRRect.isSimple conversion to impell… (#53208)
- [CP][Impeller] Round out subpass coverage. (#52973) (#53207)
- [CP][Impeller] Fix stroke curves. (#52978) (#53206)
- [CP][Impeller] Intel iOS Simulators must block on GPU completion. (#53073) (#53205)
- [flutter_releases] Flutter stable 3.22.0 Engine Cherrypicks (#53211)
- [CP-stable]Fix non-vd android platform view input event offsets (#52987)
- [CP-stable]Fix another instance of platform view breakage on Android 14 (#52982)
- [flutter_releases] Flutter stable 3.22.1 Engine Cherrypicks (#52969)
- [Impeller] Vulkan validation off by default. (#52397) (#52904)
- Fix the issue where the keyboard collapses when the subwindow pops up

---

### 兼容性与配套
- 引擎构建最低要求 API：**OpenHarmony API 20**
- 应用构建目标 API：**OpenHarmony API 20**
- 应用最低运行 API：**OpenHarmony API 12**
- Flutter SDK：**3.22.3-ohos-1.1.3**（版本显示为3.22.4-ohos-1.1.3，确保解析兼容）

---

### 发布时间
2026 年 5 月 20 日

---

### 更新详情
- [详细变更日志](../CHANGELOG.md)

---

### 开发资源
- [开发文档与示例](https://gitcode.com/openharmony-tpc/flutter_samples/blob/master/README.md)