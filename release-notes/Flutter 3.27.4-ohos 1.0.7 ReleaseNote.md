### 版本概览
本次发布基于 Flutter 3.27.4，深度适配的 OpenHarmony，重点提升平台能力、性能表现与开发体验。

---

### 主要更新
**新增特性**
- add lookupCallbackInformationBigInt,([7c4ca16382](https://gitcode.com/CPF-Flutter/flutter_engine/commit/7c4ca16382821e3916e9ec1a088ee6b7801c1976))
- PlatformViewController解耦FlutterView,([975b470b60](https://gitcode.com/CPF-Flutter/flutter_engine/commit/975b470b60ad4c94e23a39ee52c93c8616908544))
- Add simple occlusion culling for impeller,([8bf201595c](https://gitcode.com/CPF-Flutter/flutter_engine/commit/8bf201595c5735474fb90636b1fb428f4fcddad6))
- 增加画中画窗口轮询策略，延迟退后台dma清理,([005d2d4502](https://gitcode.com/CPF-Flutter/flutter_engine/commit/005d2d45028fb5ee5cdf5ee824dfb75fc3de0b12))

**问题修复**

- Fix OHOS platform view active touch cancellation,([7dda026b45](https://gitcode.com/CPF-Flutter/flutter_engine/commit/7dda026b452ca8e813d3c7351e157ed40542b98b))
- Fix the issue where Shift + left arrow can only select one character,([1d7991bc9a](https://gitcode.com/CPF-Flutter/flutter_engine/commit/1d7991bc9a22114d50a34cefcb4a0ba183c1835e))
- fix NavigationChannel crash,([5906f788c0](https://gitcode.com/CPF-Flutter/flutter_engine/commit/5906f788c01aea3fd05a91a87b1b6ae31fc0559b))
- fix White screen issue when restoring after minimizing the window,([262d97978a](https://gitcode.com/CPF-Flutter/flutter_engine/commit/262d97978ab5e9eb27e5d34f48c2895d6a0e7fb9))
- fix：修复性能雷达滑动丢帧上报字段值问题,([858da8abc3](https://gitcode.com/CPF-Flutter/flutter_engine/commit/858da8abc3231035f2a5f9025d5d850c09f2b776))
- Fixed the issue of small mouse scroll step value,([615535ca2c](https://gitcode.com/CPF-Flutter/flutter_engine/commit/615535ca2c72c4e655fbe001d9abd8f4851e3926))
- Fix the issue of DPI repeatedly redirecting to the same page,([8af6fe7553](https://gitcode.com/CPF-Flutter/flutter_engine/commit/8af6fe7553c3b4072f341f3d5121a5ab97dd8650))
- 修改getRectangleById异常未捕获问题,([ade77f0110](https://gitcode.com/CPF-Flutter/flutter_engine/commit/ade77f01103ef1436347e00e8d5b6a2c64411b7f))
- fix TextField accessibility read content,([7ba97db2db](https://gitcode.com/CPF-Flutter/flutter_engine/commit/7ba97db2db4da08cc3454eef97493b06977b0f81))
- Fix the issue of DPI conflicting with Dart's adaptive behavior,([61d6b716d6](https://gitcode.com/CPF-Flutter/flutter_engine/commit/61d6b716d618a6073e6a9d8d3f2c9ac416354276))
- fix status bar icons turn gray when statusBarIconBrightness not set,([3d397e4ce9](https://gitcode.com/CPF-Flutter/flutter_engine/commit/3d397e4ce93583c4707441702153104e9eda7d4f))
- 修复物理键盘输入对称符号光标位置错误,([05e8a6667a](https://gitcode.com/CPF-Flutter/flutter_engine/commit/05e8a6667ae10d1747bce5b7afa094df1e38fcfb))
- fix: shorter candidate would cause preview text issue,([95a887d8e3](https://gitcode.com/CPF-Flutter/flutter_engine/commit/95a887d8e3a383732e81ddfb36350f70362bf06f))
- fix napi lookupcallbackinformation,([4be695a178](https://gitcode.com/CPF-Flutter/flutter_engine/commit/4be695a1787efd29c899d0b8d8dfb6c188d85ace))
- fix lookupCallbackInformation error,([6e315cd7ef](https://gitcode.com/CPF-Flutter/flutter_engine/commit/6e315cd7ef219aa758379f56eec63a5d6730659e))
- fix green border not update,([c5f275459d](https://gitcode.com/CPF-Flutter/flutter_engine/commit/c5f275459da01fdc95d9a22485c658ff269e5e1f))
- 修复鼠标左右键按键异常,([e094652c34](https://gitcode.com/CPF-Flutter/flutter_engine/commit/e094652c344c1173bedbcd46e9258b4c37f82c81))
- fix napi lookupcallbackinformation parameter type,([7b12fd058e](https://gitcode.com/CPF-Flutter/flutter_engine/commit/7b12fd058e50ed7414b232833e82b43e54864573))
- 解决预加载场景渲染异常问题,([1c08ea9332](https://gitcode.com/CPF-Flutter/flutter_engine/commit/1c08ea9332dd1197c5aa939cf7bdfe0a9a5c93f7))
- 解决旋转屏幕锁定问题,([6bb7fc0409](https://gitcode.com/CPF-Flutter/flutter_engine/commit/6bb7fc04097c1fbf695d456dcb4a1b34ff79b643))
- 解决windowstage可能已经销毁的崩溃,([89a2d0426d](https://gitcode.com/CPF-Flutter/flutter_engine/commit/89a2d0426db6a8e79809b50019b973d4130bcc67))
- Fixed the issue where EventChannel.endOfStream() method did not trigger the onDone event in Dart,([18c6c77f73](https://gitcode.com/CPF-Flutter/flutter_engine/commit/18c6c77f733b5d1206eaecf2f3949567d3c75845))
- fix: textField preview cannot be displayed normally,([9877eaefdf](https://gitcode.com/CPF-Flutter/flutter_engine/commit/9877eaefdff8364ed3efcb5b61cec76b7c14a61a))
- fix ReleaseNativeWindowBuffer crash,([0fcafa4cd2](https://gitcode.com/CPF-Flutter/flutter_engine/commit/0fcafa4cd2b102337ae935342e3d3c7cb42f0152))
- 修复onsurfacecreate的错误判断,([383a61ce7a](https://gitcode.com/CPF-Flutter/flutter_engine/commit/383a61ce7a4529ffe4507847ce26d2b3739f4352))
- Avoid deleting selected text when finishing preview,([0aff17c786](https://gitcode.com/CPF-Flutter/flutter_engine/commit/0aff17c7869d99751ce739190f0785b411315a22))
- Fixed incorrect tiltX and tiltY parameter passing in external texture scenarios,([6a0927a953](https://gitcode.com/CPF-Flutter/flutter_engine/commit/6a0927a953bdeefaf7084ce4f0ecce147a633ee5))
- 简化 PiPVisibilityBridge 为单一全局状态 , 修复空 catch / 线程安全注释等问题,([369a320244](https://gitcode.com/CPF-Flutter/flutter_engine/commit/369a320244cfd7b25c15c1a4ea8a3cf9bba1b327))
- 修复crash，优化ohos_image_generator.cpp代码,([e559fb6c6d](https://gitcode.com/CPF-Flutter/flutter_engine/commit/e559fb6c6d419a52637bcccbfc1a99ad86db5796))
- Fix the issue where the PlatformView page does not refresh when switching to dark mode,([0081f72a83](https://gitcode.com/CPF-Flutter/flutter_engine/commit/0081f72a8338deb942a8f36b1ef3df3da4f820ac))
- fix: dpi setting when navi is not working,([ea6c518455](https://gitcode.com/CPF-Flutter/flutter_engine/commit/ea6c5184553c793ed422cf01f25d5bdc2101f486))
- Fix the issue where the keyboard collapses when the subwindow pops up,([5c27d160df](https://gitcode.com/CPF-Flutter/flutter_engine/commit/5c27d160df24a62e521d12a295c6693c2b23c9b6))
- Fixed the spelling error in the channel message name 'nativeVsync' within LTPO,([1fa308c12a](https://gitcode.com/CPF-Flutter/flutter_engine/commit/1fa308c12ac207fd6f02b2d310dd496ad0cc26d1))
- pick pr1097 修复切换输入框时，软键盘类型存在安全类键盘时出现键盘无法唤起的问题,([62229184c9](https://gitcode.com/CPF-Flutter/flutter_engine/commit/62229184c99ac4c3241d300dd7ba9b3e79b2178c))

---

### 兼容性与配套
- 引擎构建最低要求 API：**OpenHarmony API 22**
- 应用构建目标 API：**OpenHarmony API 22**
- 应用最低运行 API：**OpenHarmony API 12**
- Flutter SDK： **3.27.4-ohos-1.0.7**（版本显示为3.27.5-ohos-1.0.7，确保解析兼容）

### 发布时间
2026 年 7 月 4 日

---

### 更新详情
- [详细变更日志](../CHANGELOG_OHOS.md#3274-ohos-106)

---

### 开发资源
- [开发文档与示例](https://gitcode.com/openharmony-tpc/flutter_samples/blob/master/README.md)

