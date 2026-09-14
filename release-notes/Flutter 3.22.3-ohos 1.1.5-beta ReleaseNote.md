### 版本概览
本次发布基于 Flutter 3.22.3，深度适配的 OpenHarmony，重点提升平台能力、性能表现与开发体验。

---

### 主要更新
**新增特性**

- 手机端支持密码保险箱功能（依赖待发布API）
- flutter项目Web页面，支持鼠标拖拽调整尺寸
- add lookupCallbackInformationBigInt
- PlatformViewController解耦FlutterView

**问题修复**

- Fix OHOS platform view active touch cancellation
- Fix the issue where Shift + left arrow can only select one character
- fix NavigationChannel crash
- fix White screen issue when restoring after minimizing the window
- Fixed the issue of small mouse scroll step value
- fix：修复性能雷达滑动丢帧上报字段值问题
- 捕获componentUtils.getRectangleById异常
- Fix the issue of DPI repeatedly redirecting to the same page
- fix TextField accessibility read content
- Fix the issue of DPI conflicting with Dart's adaptive behavior
- 修复物理键盘输入对称符号光标位置错误
- fix: shorter candidate would cause preview text issue
- fix napi lookupcallbackinformation
- fix lookupCallbackInformation error
- fix: clamp text selection range to prevent RangeError in IME operations
- fix status bar icons turn gray when statusBarIconBrightness not set
- 修复鼠标左右键按键异常
- fix green border not update
- fix napi lookupcallbackinformation parameter type
- 解决预加载场景渲染异常问题

---

### 兼容性与配套
- 引擎构建最低要求 API：**待发布最新API**
- 应用构建目标 API：**待发布最新API**
- 应用最低运行 API：**待发布最新API**
- Flutter SDK：**3.22.3-ohos-1.1.5-beta**（版本显示为3.22.4-ohos-1.1.5-beta，确保解析兼容）

---

### 发布时间
2026 年 7 月 4 日

---

### 更新详情
- [详细变更日志](../CHANGELOG.md)

---

### 开发资源
- [开发文档与示例](https://gitcode.com/CPF-Flutter/flutter_samples/blob/master/README.md)
