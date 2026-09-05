## 版本概述
本版本为Flutter OpenHarmony平台1.0.4-beta版本，基于Flutter 3.35.7版本适配。本版本支持和完善OpenHarmony平台侧能力，提供平台化Channel、外接纹理、云端SDK等特性，并优化性能。

### 主要更新

**新增特性**

- 手机端支持密码保险箱功能（依赖待发布API）
- 切换分栏实现方案，支持router路由方式下的分栏
- 添加分栏功能
- 分栏起始页显示图标
- 添加supportLandscapeFullscreen配置项，支持横屏全屏模式
- 添加对配置项enableReducedContainerSize的处理，当设置为true时，MediaQueryData.size宽度值改为一半
- flutter项目Web页面，支持鼠标拖拽调整尺寸
- Add ohos in platform_channels_benchmarks
- Add ohos in microbenchmarks
- LTPO Performance Optimization
- Frame Buffer PTS Optimization for Delayed Frame Presentation
- 发送低内存警告，触发图像缓存清理
- [OHOS] Add DMA zero-copy image decode path
- [OHOS] Add DMA zero-copy image decode path with P3 support
- ohos开启指针压缩
- 开启指针压缩
- Enable static snapshot linking for OHOS debug mode
- chore: Full release supports compiling the Web SDK
- add targetSize
- add lookupCallbackInformationBigInt
- Saves a DeviceHolderVK with the CommandPoolVK
- PlatformViewController解耦FlutterView

**问题修复**

- 分栏功能中，当栈顶是弹窗时，不要拦截pop函数
- 修改FlutterView.ets中鸿蒙原生事件调用逻辑，增加isActive状态判断
- Fix OHOS platform view active touch cancellation
- 修改静态检查失败的问题，补充版权信息
- Fix the issue where Shift + left arrow can only select one character
- fix NavigationChannel crash
- fix White screen issue when restoring after minimizing the window
- [OHOS] Fix PixelMap ReadPixels temp buffer cleanup
- [OHOS] Restore PixelMap ReadPixels tight-row semantics
- 修复性能雷达滑动丢帧上报字段值问题
- Fixed the issue of small mouse scroll step value
- Fix the issue of DPI repeatedly redirecting to the same page
- 修复一定深度的主页调用popuntil问题+模态弹窗无法关闭问题
- [OHOS] Refine DMA image decode checks
- fix: Fix safe area avoidance in tri-fold freeform multi-window mode
- 修复弹窗问题+优化读取配置文件
- fix TextField accessibility read content
- 解决重复builder问题+解决键盘无法重新聚焦问题+强制pop不能返回+observe多个监听问题
- 当配置文件配置项值为空字符串时，要识别为无效值
- 修复分栏模式下开启无障碍阅读左分栏无法响应的问题
- 防止 SplitViewContainer 在 build 期间调用 setState，避免异常警告
- fix bots ut
- fix flutter_tools ut
- fix dev/devicelab&dev/tools ut
- fix material ut
- Fix the issue of DPI conflicting with Dart's adaptive behavior
- fix Double click the control for the first time and jump to the green box position
- fix flutter_driver&flutter_test&integration_test&snippets ut
- fix ut
- fix flutter test
- fix status bar icons turn gray when statusBarIconBrightness not set
- fix: shorter candidate would cause preview text issue
- Modify the srgb rendering to p3 issue, modify the cpu computing issue, and modify the shadow rendering granularity issue
- fix napi lookupcallbackinformation
- fix lookupCallbackInformation error

## 版本配套
- 引擎构建最低要求 API：**待发布最新API**
- 应用构建目标 API：**待发布最新API**
- 应用最低运行 API：**待发布最新API**
- Flutter SDK：**3.35.7-ohos-1.0.4-beta**（由于flutter版本解析规则，为了避免版本比较解析失败，将显示为3.35.8-ohos-1.0.4-beta）

## Changelog
- [3.35.7-ohos-1.0.4-beta](../CHANGELOG_OHOS.md)

## 赋能文档
- [文档链接](https://gitcode.com/openharmony-tpc/flutter_samples/tree/master/ohos/docs)
