## 版本概述
本版本为基于Flutter 3.32.4适配的OpenHarmony版本。本版本支持和完善OpenHarmony平台侧能力，提升稳定性。

## 新增特性
- 毕昇编译器替换，开启优化选项
- 增加路由跳转和标签页切换的检测能力
- [impeller] Vulkan backend supports skipping rendering when dirty region is 0.
- Add monitor for external textures visible area
- 退后台释放DMA资降低内存
- Add HarmonyOS platform detection
- 【3.32】滑动丢帧事件上报添加FRAME_ID属性与总帧数属性
- support start-paused on ohos
- Add CI script
- 滑动丢帧上报：报文时间修改为UTC时间戳、新增滑动丢帧上报过程中总帧数属性
- LTPO的channel通信优化，速度值纠正；增加100ms性能兜底，优化代码
- 【3.32】【性能雷达】滑动丢帧上报
- 同步滑动trace的dfx能力到flutter3.32版本
- 当系统触发内存事件时，提高IplrVkFenceWait和IplrVkResMgr线程的优先级
- 3.32新增LTPO功能
- 在FlutterEntry中添加系统环境变化监听器，把深色模式、字体等变化发送到dart
- 添加hover事件
- feat: ohos platform supports text-editing callbacks implementation which will be invoked by inputmethod apps
- 3.22新增ui卡死检测上报
- 图片纹理过大时，不走scalePixels
- 添加322的hover功能
- 同步官方仓对impeller过大纹理限制操作
- 图片编解码替换不拷贝内存接口
- feat: Add new features for physical keyboard input in ctrl/alt/shift modifier key state mode
- APNG动图支持修改

## Bug修复
- Addressed the issue where cropping with original dimensions in a transformed coordinate system resulted in a size mismatch.
- 修复软键盘直接弹起到界面上问题
- fix: keyboard home key is not consistent
- Remove 'ohpm clean' during compilation process.
- fix: caplock and return keys are not working with keyboard
- Fixed: onInactive method was not triggered when the WebView became invisible.
- 修复monorepo flutter_audioplayers编译失败找不到.dart_tool/package_config.json问题
- Fix the issue of keyboard popping up and flickering in PlatformView input box
- 分支修复使用multiply混合模式时，在某些GPU上画面变白/变灰的问题
- Frame gate enabled: keep draining producer queue, but do not schedule
- Fix the issue where the clipboard cannot paste content in a custom format
- [Impeller] Fixed an issue where gradient effects on HarmonyOS devices exhibited clipping. With mediump enabled by default, `IPOrderedDither8x8 uint(dest.x)` and `uint(dest.y)` might experience precision loss on some GPU chips.
- 修复多PlatformView场景下输入框失焦问题【3.32】
- Fixed occasional connection failures in flutter run.
- Fix cache errors related to YUVConversionVK.
- Run 'bin/et format'
- 修改napi相关的内存泄露问题
- Use Flutter's config command to specify build-dir.
- fix: MouseRegion onExit is not triggered when moving the cursor in and out fast
- fix:Fix DropdownButton focus highlight issue on touch devices
- 滑动丢帧上报：报文时间修改为UTC时间戳、新增滑动丢帧上报过程中总帧数属性
- 修复断点模式appfreeze问题
- Fix the issue where pasting is not possible after cutting
- 同步看门狗问题解决到3.32分支
- Solve the error when compiling the release mode using the local engine
- 销毁xcomponent时，对目前正在处理的手势发送cancel信号
- format
- fix: pressing TextField with preview text would delete it
- 修复切换输入框时，软键盘类型存在安全类键盘时出现键盘无法唤起的问题
- 分屏时在应用间输入框焦点相互切换，切至flutter输入字符后候选词显示位置有误
- 解决attach异步以及多输入框候选词跟随的问题
- Add simple occlusion culling for impeller
- 增加copyResource方法中的异常捕获，增加try catch及异常日志
- 修复多个flutterview情况下，鼠标和手势事件分发错误的问题
- 解决上下分屏打开固定态软键盘后切换左右分屏页面上缩问题
- 修复多个flutterview情况下，鼠标和手势事件分发错误的问题
- 修复LTPO问题
- 解决切换输入框候选词不更新及候选词跟随问题
- 修改IplrVkResMgr和IplrVkFenceWait线程的优先级变动逻辑为只在OHOS_MEMORY_LEVEL_CRITICAL(可用内存极低)时提高优先级
- 修复3.32Channel内存泄漏问题
- 输入法候选词在光标右下角
- 3.32使用skia渲染模式时，image组件在部分场景下背景颜色变黑
- 修改HAR_VERSION的提示等级
- 修改ohos平台下alertdialog滚动默认值为true
- 修改ohos_image_generator.cpp,ohos_touch_processor.cpp中部分智能指针创建方式
- 编译和上传debug引擎产物时，默认改为不使用unoptimized选项。
- 修复多web时，鼠标/双指滑动无法滚动的问题
- 修复app点击返回按钮时出现vulkan DestroyImageView崩溃，在最后一个 vk 图像被销毁之前保持设备持有者和分配器处于活动状态
- Handle abnormal touch events
- 解决偶现bottomRect报错问题
- 修复PC无法全屏的问题
- 解决可能会导致image_source uaf的问题
- 解决delta模式下删除异常的问题
- fix: Clear damage region when the swapchain is changed to prevent rendering errors.
- 解决可选择文本组件无法滑动问题
- fix: Solve the problem of incorrectly inserting old clipboard data in syn func using async pasting func in the input method.
- 解决bottomRect of undefined的问题
- fix: Solve the problem of incorrectly inserting old clipboard data in syn func using async pasting func in the input method.
- 修复外接纹理情况下，无法抛滑问题
- 解决DeltaTextInputClient回车和删除操作异常的问题
- window大小变化时添加执行TeardownOnScreenContext()，避免使用impeller-vulkan时，放大缩小窗口时偶现花屏的问题
- 系统字体配置改为先从系统接口获取再从json文件获取
- 修复platformview和flutter输入框来回点击导致flutter侧无法输入
- Use LTRB to describe information of DisplayFeature
- Modify message loop impl of ohos
- 修复鼠标点击事件导致的hover异常问题
- Set framework type of the nativewindow
- Modify max_jank_frame for external texture
- 修改模拟器上竖屏视频播放倒转的问题
- 修复多FlutterEntry情况下，生命周期异常的问题)
- 修改超大gif图场景的内存泄露问题
- fix: Do not execute the nativeAccessibilityStateChange method when nativeShellHolderId is null
- fix: resolve the memory leaking of webview
- 修改APNG动图遗漏endif
- 修复canvas.drawCirle出现白边的情况
- pick engine:994,解决drawRect出现白边的问题
- 解决3.32连续执行两次flutter clean会报错的情况

## 版本发布时间
2026年3月16日

## 版本配套
- OpenHarmony API20及以上
- Flutter SDK: 3.32.4-ohos-0.0.2（由于flutter版本解析规则，为了避免版本比较解析失败，将显示为3.32.5-ohos-0.0.2）

## Changelog
- [3.32.4-ohos-0.0.2](../CHANGELOG_OHOS.md)

## 赋能文档
- [文档链接](https://gitcode.com/openharmony-tpc/flutter_samples/tree/master/ohos/docs)