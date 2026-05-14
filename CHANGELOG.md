# Changelog
## 6.1.1.388
- fix napi lookupcallbackinformation parameter type ([82709afd](https://gitcode.com/openharmony-tpc/flutter_engine/commit/82709afd83c35178f319fd6e0141e13b104ef1fa?ref=cherry-pick-mr-1341-1778729325084-auto&prId=1349))
## 7.0.0.22
- Fixed the issue where EventChannel.endOfStream() method did not trigger the onDone event in Dart ([bd76bd56](https://gitcode.com/openharmony-tpc/flutter_engine/commit/bd76bd56cec1c51a7cef938df8a49b074764c8bd?ref=fix_not_trigger_onDone_322&prId=1320))
## 6.1.1.385
- 解决windowstage可能已经销毁的崩溃 ([919fb3d0](https://gitcode.com/openharmony-tpc/flutter_engine/commit/919fb3d068444c1b5ae5633545b0302b821723a9?ref=catchwindowoff3.22&prId=1322))
## 7.0.0.21
- fix: textField preview cannot be displayed normally ([138be6f4](https://gitcode.com/openharmony-tpc/flutter_engine/commit/138be6f47cf6307363369b31a9dbc30c60627be9?ref=3_22_preview&prId=1316))
## 6.1.1.384
- fix ReleaseNativeWindowBuffer crash ([f45a347d](https://gitcode.com/openharmony-tpc/flutter_engine/commit/f45a347dc2b112c910210f8e2917b44519128a2e?ref=dev3-22&prId=1314))
- update DartCallback export ([0a7dde38](https://gitcode.com/openharmony-tpc/flutter_engine/commit/0a7dde380a493b2deeb69c7c1af4ce2070ef4e19?ref=cherry-pick-mr-1309-1776318727519-auto&prId=1310))
## 6.1.1.383
- 简化 PiPVisibilityBridge 为单一全局状态 , 修复空 catch / 线程安全注释等问题 ([ecffe124](https://gitcode.com/openharmony-tpc/flutter_engine/commit/ecffe124f7988d695cec17fba7143e894d80ca52?ref=pippoll_3.22&prId=1307))
- 增加画中画窗口轮询策略，延迟退后台dma清理 ([af93bc2e](https://gitcode.com/openharmony-tpc/flutter_engine/commit/af93bc2ef208834935ba534c256da38c187c9dae?ref=pippoll_3.22&prId=1307))
- 无条件设置false，重置cached_native_window_ ([aa2852d5](https://gitcode.com/openharmony-tpc/flutter_engine/commit/aa2852d5db096e536766521030497f234b24bd8c?ref=onsurfacefix322&prId=1306))
- 修复onsurfacecreate的错误判断 ([653221e9](https://gitcode.com/openharmony-tpc/flutter_engine/commit/653221e9aecf71f0c84191f8a44af32a9959d8b9?ref=onsurfacefix322&prId=1306))
- Fixed incorrect tiltX and tiltY parameter passing in external texture scenarios ([d506ff97](https://gitcode.com/openharmony-tpc/flutter_engine/commit/d506ff97c1318c9f6afc090ef9801711a54a280d?ref=3_22_tiltY&prId=1295))
## 6.1.1.382
- Fix the issue where the PlatformView page does not refresh when switching to dark mode ([bd440ace](https://gitcode.com/openharmony-tpc/flutter_engine/commit/bd440acefd20182cdc76c1c74666c35e71de8637?ref=oh-3.22.3-dev&prId=1290))
- extend timeouts of all targets in .ci.yaml ([a07818ca](https://gitcode.com/openharmony-tpc/flutter_engine/commit/a07818ca302aa4d535ad892dedada04330c59f3d?ref=merge-3.22.3&prId=1285))
- Flutter stable 3.22.3 Engine Cherrypicks ([4b1fb3e6](https://gitcode.com/openharmony-tpc/flutter_engine/commit/4b1fb3e6336adb046786daeb97738753c99ab6a4?ref=merge-3.22.3&prId=1285))
- Fix rendering corruption by Flutter and GDK sharing the same OpenGL context ([faf03979](https://gitcode.com/openharmony-tpc/flutter_engine/commit/faf03979c1c4b0ec20b8e7ba4fbb4599352c79fc?ref=merge-3.22.3&prId=1285))
- [Impeller] Create framebuffer blend vertices based on the snapshot's texture size instead of coverage ([9ce61b0d](https://gitcode.com/openharmony-tpc/flutter_engine/commit/9ce61b0d9e45a63b62f324b1f5d9cff42a81a551?ref=merge-3.22.3&prId=1285))
- dont segfault when tessellating empty polygons. ([450f6e24](https://gitcode.com/openharmony-tpc/flutter_engine/commit/450f6e24eec1ec2a9dc07659de7dc684fa86c004?ref=merge-3.22.3&prId=1285))
- [Impeller] relax conditions for SkRRect.isSimple conversion to impell… ([da7762f5](https://gitcode.com/openharmony-tpc/flutter_engine/commit/da7762f520836becd37f78423ff08ca2ebacd4b5?ref=merge-3.22.3&prId=1285))
- [Impeller] relax conditions for SkRRect.isSimple conversion to impell… ([da7762f5](https://gitcode.com/openharmony-tpc/flutter_engine/commit/da7762f520836becd37f78423ff08ca2ebacd4b5?ref=merge-3.22.3&prId=1285))
- [Impeller] Round out subpass coverage. ([57ec314c](https://gitcode.com/openharmony-tpc/flutter_engine/commit/57ec314c44cd0102c609628a1dc3a3da37d79114?ref=merge-3.22.3&prId=1285))
- [Impeller] Fix stroke curves. ([305ceefd](https://gitcode.com/openharmony-tpc/flutter_engine/commit/305ceefdb55dc70b2267a06a99a8001091cb26ba?ref=merge-3.22.3&prId=1285))
- [Impeller] Intel iOS Simulators must block on GPU completion.([86cc544d](https://gitcode.com/openharmony-tpc/flutter_engine/commit/86cc544db01c68d60b6fa272aa6b8e01419e46cb?ref=merge-3.22.3&prId=1285))
## 6.1.1.38
- fix: dpi setting when navi is not working ([07243d85](https://gitcode.com/openharmony-tpc/flutter_engine/commit/07243d85dcdbf4f6f9c93e319e5d692b2b81a2f2?ref=oh-3.22.0))
## 6.1.1.37
- Fix the issue where the keyboard collapses when the subwindow pops up ([62761d2b](https://gitcode.com/openharmony-tpc/flutter_engine/commit/62761d2b2b4518f46f4265c093c79644a74b28c8?ref=oh-3.22.0&prId=1262))
## 6.1.1.36
- Reduce memory usage during the preloading phase. ([e27b79e1](https://gitcode.com/openharmony-tpc/flutter_engine/commit/e27b79e19dae260c785882a8eecc2d522ff285e2?ref=preload-dma-3.22&prId=1230))
- chore: Run incremental build on CI. ([91859642](https://gitcode.com/openharmony-tpc/flutter_engine/commit/91859642fd5931fbe4ef5f15b23a53a63a6c1198?ref=oh-3.22.0&prId=1256))
## 6.1.0.314
- Addressed the issue where cropping with original dimensions in a transformed coordinate system resulted in a size mismatch. ([57de2bc5](https://gitcode.com/openharmony-tpc/flutter_engine/commit/57de2bc59010c8e3bb5dcf0378d7a55f91489d50?ref=oh-3.22.0))
## 6.1.0.313
- 修复软键盘直接弹起到界面上问题 ([2aadedba](https://gitcode.com/openharmony-tpc/flutter_engine/commit/2aadedba65469d91bc16a3d7555829c30a989078?ref=oh-3.22.0&prId=1245))
- fix: keyboard home key is not consistent ([75881fc7](https://gitcode.com/openharmony-tpc/flutter_engine/commit/75881fc73b5c31960eba217c2bb7f18f2f3e8715?ref=home_key_issue_22&prId=1244))
## 6.1.0.312
- [Impeller] match Skia's old VMA default block size. Pick https://github.com/flutter/engine/pull/56368 ([5f71cb95](https://gitcode.com/openharmony-tpc/flutter_engine/commit/5f71cb957277505efad246cea73f2aa8bef2297d?ref=oh-3.22.0&prId=1238))
- fix: caplock and return keys are not working with keyboard ([df85cd4b](https://gitcode.com/openharmony-tpc/flutter_engine/commit/df85cd4b019ded3fd14d4131dc2da364b66549c2?ref=3_22_caplock_issue&prId=1225))
- Fixed: onInactive method was not triggered when the WebView became invisible. ([5f986785](https://gitcode.com/openharmony-tpc/flutter_engine/commit/5f9867859a7b606bf7394cb4d350cdc157d2689e?ref=322_platformview_visibility&prId=1232))
- Fix the issue of keyboard popping up and flickering in PlatformView input box ([3559f700](https://gitcode.com/openharmony-tpc/flutter_engine/commit/3559f700ab78c8de1146f3f7540d902ed623c93a?ref=oh-3.22.0&prId=1210))
- 修改3.22的流水线sdk的地址 ([d91b0268](https://gitcode.com/openharmony-tpc/flutter_engine/commit/d91b02688c97053834d627cc8fbae3e942059541?ref=oh-3.22.0&prId=1236))
## 6.1.0.311
- 修复使用multiply混合模式时，在某些GPU上画面变白/变灰的问题 ([c750b3d0](https://gitcode.com/openharmony-tpc/flutter_engine/commit/c750b3d0ac1ad0e8a35a1a7b2d6bca77f36a56c0?ref=oh-3.22.0-multiply-pr&prId=1215))
## 6.1.0.310
- [Impeller] Fixed an issue where gradient effects on HarmonyOS devices exhibited clipping. With mediump enabled by default, IPOrderedDither8x8 uint(dest.x) and uint(dest.y) might experience precision loss on some GPU chips. ([fb2447c5](https://gitcode.com/openharmony-tpc/flutter_engine/commit/fb2447c52528f6e04bc2fc53441c3e3dccc6e54b?ref=gradient_dithering_issue_322&prId=1222))
- Frame gate enabled: keep draining producer queue, but do not schedule ([87d51c88](https://gitcode.com/openharmony-tpc/flutter_engine/commit/87d51c88e5161c0257b9c4408e45008040798e04?ref=externalchange_engine3.22&prId=1226))
- Fix the issue where the clipboard cannot paste content in a custom format ([b8910f95](https://gitcode.com/openharmony-tpc/flutter_engine/commit/b8910f953bad13750b44f28e8d8bbaa5e9d1d16a?ref=oh-3.22.0&prId=1220))
## 6.1.0.30
- 毕昇编译器替换，开启优化选项 ([7496195c](https://gitcode.com/openharmony-tpc/flutter_engine/commit/7496195ce3c6e314db481ad27d1b3d0e5c7d6257?ref=322-bisheng-engine&prId=1218))
- Click the status bar to automatically return to the top ([37837b37](https://gitcode.com/openharmony-tpc/flutter_engine/commit/37837b37ef93a30f0647c2c4cf2c10a5b8401eae?ref=oh-3.22.0&prId=1207))
- 修复多PlatformView场景下输入框失焦问题 ([ffc7fcc5](https://gitcode.com/openharmony-tpc/flutter_engine/commit/ffc7fcc5475b6874b4f238079cf2a41238e3d18c?ref=oh-3.22.0&prId=1213))
- 增加路由跳转和标签页切换的检测能力 ([1906477e](https://gitcode.com/openharmony-tpc/flutter_engine/commit/1906477e54e4d089ff5cba596124bf36ed6b8c9f?ref=3.22-tracing-engine&prId=1216))
- chore: Implement incremental builds. ([906c54e5](https://gitcode.com/openharmony-tpc/flutter_engine/commit/906c54e53130eb2686d0cdfd5a0832cd32c6f56f?ref=oh-3.22.0&prId=1205))
## 6.1.0.29
- [impeller] Vulkan backend supports skipping rendering when dirty region is 0. ([1893c004](https://gitcode.com/openharmony-tpc/flutter_engine/commit/1893c004ebc42cd43153c5c17107d2eda819c64f?ref=skip_damage_zero_322&prId=1203))
- Add monitor for external textures visible area ([e78dbad9](https://gitcode.com/openharmony-tpc/flutter_engine/commit/e78dbad9ca500a05f8fa114410f222f46bb70ed6?ref=oh-3.22.0&prId=1199))
## 6.1.0.28
- Set VMA default block size. See https://github.com/flutter/engine/pull/56368/files ([680b9912](https://gitcode.com/openharmony-tpc/flutter_engine/commit/680b9912066931fd423da20b4d1b3d4f392944b9?ref=mem-3.22&prId=1194))
- 退后台释放DMA资降低内存 ([907c8623](https://gitcode.com/openharmony-tpc/flutter_engine/commit/907c8623a1ebc1d73061cf1e792069d073ab4c8d?ref=DmaFreeInBackground-3.22.0&prId=1182))
## 6.1.0.260
- oh-3.22.0分支更新README文档 ([a8a3aa9d](https://gitcode.com/openharmony-tpc/flutter_engine/commit/a8a3aa9df729bbb172d0c67a63b2a1b842a10986?ref=oh-3.22.0&prId=1184))
- fix: false error log when notify page change successfully ([fa02020c](https://gitcode.com/openharmony-tpc/flutter_engine/commit/fa02020cb10c26084a7bf4b9b0b108a811385f89?ref=22_dpi_log&prId=1197))
- 修改napi相关的内存泄露问题 ([519ae99d](https://gitcode.com/openharmony-tpc/flutter_engine/commit/519ae99da7134eeb3f7eb67f59605304a30ec41f?ref=handle-scope-3.22&prId=1180))
- Fix cache errors related to YUVConversionVK. ([7e68d1d6](https://gitcode.com/openharmony-tpc/flutter_engine/commit/7e68d1d6917ccbdf0e3991102ab50d8560e94752?ref=yuv-cache-3.22&prId=1186))
## 6.1.0.27
- feat: notify OHOS when navigate in Flutter ([0335dd77](https://gitcode.com/openharmony-tpc/flutter_engine/commit/0335dd774b3e62564f119215c82850890784e731?ref=dpi_3_22_dev&prId=1176))
- 增加json5文件注释特性解析支持 ([390dc8ae](https://gitcode.com/openharmony-tpc/flutter_engine/commit/390dc8ae6c62067c761e7ef744d0cb08503d8ce7?ref=oh-3.22.0&prId=1155))
- 滑动丢帧时间上报添加FRAME_ID属性与总帧数属性 ([db448985](https://gitcode.com/openharmony-tpc/flutter_engine/commit/db44898589d0c0467e10f6882ac01608f1763cdf?ref=hiappevent-scroll-322&prId=1172))
- patch cipd cache ([9c3d6ba9](https://gitcode.com/openharmony-tpc/flutter_engine/commit/9c3d6ba9f47e21da86802fac9269561378de9073?ref=oh-3.22.0&prId=1168))
- fix:Fix DropdownButton focus highlight issue on touch devices ([fb521d35](https://gitcode.com/openharmony-tpc/flutter_flutter/commit/fb521d35ae8aa6d549c54fdd82d5a0378dd26cb8?ref=3.22.0-ohos&prId=836))
- support start-paused on ohos ([d3110605](https://gitcode.com/openharmony-tpc/flutter_flutter/commit/d311060504460f318bf5760648c27a97e78c2407?ref=3.22.0-ohos&prId=825))
## 6.1.0.26
- MouseRegion onExit is not triggered when moving the cursor in and out fast ([f1cd23e6](https://gitcode.com/openharmony-tpc/flutter_engine/commit/f1cd23e6e3ce061daa7ac471c381f5deb6208eeb?ref=3_22_dev_pc_mouse&prId=1153))
- 滑动丢帧上报：报文时间字段修改为UTC时间戳格式、新增滑动丢帧上报过程中总帧数属性 ([810959c4](https://gitcode.com/openharmony-tpc/flutter_engine/commit/810959c45d7eeb603979ba7809f24586956b2753?ref=oh-3.22.0))
- Flutter支持Column自适应调整 ([c7126e6e](https://gitcode.com/openharmony-tpc/flutter_engine/commit/c7126e6ef085881a5340d41181ba750ad7a2395d?ref=oh-3.22.0_Column&prId=1141))
- 报文时间修改为UTC时间戳、新增滑动丢帧上报过程中总帧数属性([76c42353](https://gitcode.com/openharmony-tpc/flutter_engine/commit/76c4235390a37b65621e8ada349ca996aa4ab505?ref=oh-3.22.0))
- 更新fluttertpc_dart_sdk仓库版本为f1ce6576 ([f861914d](https://gitcode.com/openharmony-tpc/flutter_engine/commit/f861914df3c53e6372c7c4d5bf6d15bf06a95148?ref=oh-3.22.0&prId=1142))
## 6.1.0.25
- Fix the issue where pasting is not possible after cutting ([2a8b02f6](https://gitcode.com/openharmony-tpc/flutter_engine/commit/2a8b02f681b91a45a9e6709344e847f7f0ff74e5?ref=oh-3.22.0))
## 6.1.0.23
- 同步3.7版本中ets的单元测试代码 ([e89b8989](https://gitcode.com/openharmony-tpc/flutter_engine/pull/1115/commit))
## 6.0.3.22
- 性能雷达 滑动丢帧上报 ([5b360f76](https://gitcode.com/openharmony-tpc/flutter_engine/pull/1119/commit))
- 修复切换输入框时，软键盘类型存在安全类键盘时出现键盘无法唤起的问题 ([163683d2](https://gitcode.com/openharmony-tpc/flutter_engine/pull/1097/commit))
## 6.0.3.21
- 分屏时在应用间输入框焦点相互切换，切至flutter输入字符后候选词显示位置有误 ([2d055323](https://gitcode.com/openharmony-tpc/flutter_engine/commit/2d0553237cf172b8d3eb5e66595db2f30948f645?ref=oh-3.22.0&prId=1104))
- 解决attach异步以及多输入框候选词跟随的问题 ([f09cd956](https://gitcode.com/openharmony-tpc/flutter_engine/commit/f09cd956dfdd9077ebc765816b51994d7e40e64d?ref=oh-3.22.0&prId=1095))
- 增加copyResource方法中的异常捕获，增加try catch及异常日志 ([4fc54722](https://gitcode.com/openharmony-tpc/flutter_engine/commit/4fc54722599b1c8280f1ee2a184cf66d8296609e?ref=oh-3.22.0&prId=1088))
## 6.0.3.20
- 优化候选词位置为光标的右下角，修改获取坐标方式 ([14a59457](https://gitcode.com/openharmony-tpc/flutter_engine/commit/14a594571105b363bf41e61602629ecdc85c8be5?ref=oh-3.22.0&prId=1070))
- 修复多个flutterview情况下，鼠标和手势事件分发错误的问题 ([b0fdd3dc](https://gitcode.com/openharmony-tpc/flutter_engine/commit/b0fdd3dc5c3a8c06039ab2714156096d5379c656?ref=oh-3.22.0&prId=1084))
- 【cp】解决上下分屏打开固定态软键盘后切换左右分屏页面上缩问题 ([bf8957a6](https://gitcode.com/openharmony-tpc/flutter_engine/commit/bf8957a6edc03a1e847e1af1025b719ee74d1d82?ref=oh-3.22.0&prId=1090))
## 6.0.2.122
- 修改IplrVkResMgr和IplrVkFenceWait线程的优先级变动逻辑为只在OHOS_MEMORY_LEVEL_CRITICAL(可用内存极低)时提高优先级 ([1966d11d](https://gitcode.com/openharmony-tpc/flutter_engine/commit/1966d11d1092fefd8f32d3525d9b299a94ba6e89?ref=oh-3.22.0&prId=1075))
## 6.0.2.121
- 当系统触发低内存事件时，提高IplrVkFenceWait和IplrVkResMgr线程的优先级 ([83d26244](https://gitcode.com/openharmony-tpc/flutter_engine/commit/83d2624423b634ac32eef979d7358b795e8a4fac?ref=memory_level&prId=1059))
- pick3.27解决debug模式下调试dart代码出现appfreeze ([f7cc44df](https://gitcode.com/openharmony-tpc/flutter_engine/commit/f7cc44df69506026f5d6377596c49aa0e4ca3fb8?ref=oh-3.22.0&prId=1066))
## 6.0.3.17
- 修改image黑色背景的问题 ([f80e2076](https://gitcode.com/openharmony-tpc/flutter_engine/commit/5a6e1b8060539698cbf305d499848572e767fc17?ref=oh-3.22.0&prId=1057))
- 修改HAR_VERSION的提示等级 ([8d48de06](https://gitcode.com/openharmony-tpc/flutter_engine/commit/8d48de06a6cf7461df4656e60329ac0e10851ec1?ref=oh-3.22.0&prId=1055))
- 修复Channel内存泄漏问题 ([c10f5a47](https://gitcode.com/openharmony-tpc/flutter_engine/commit/c10f5a47f60a8c4939990c21f7f508e44e25c6a1?ref=oh-3.22.0&prId=1041))
## 6.0.0.705
- 销毁xcomponent时，对目前正在处理的手势发送cancel信号 ([f80e2076](https://gitcode.com/openharmony-tpc/flutter_engine/commit/f80e2076cf9e5a3596ffe03889a8226a9f6dbec5?ref=cancel-event&prId=1047))
## 6.0.0.704
- 更新fluttertpc_dart_sdk仓库版本为f5029bd2 ([de48ed88](https://gitcode.com/openharmony-tpc/flutter_engine/commit/de48ed88bd8fc807ee995e63589c48eb96fb3c3f?ref=oh-3.22.0&prId=1040))
- 修复当没有新的帧生成时，AcquireBuffer导致的日志刷屏问题 ([b7b50c84](https://gitcode.com/openharmony-tpc/flutter_engine/commit/b7b50c84149811faddda5e8b3ff762048f9e70a7?ref=oh-3.22.0&prId=1017))
- 修复Channel内存泄漏问题 ([c10f5a47](https://gitcode.com/openharmony-tpc/flutter_engine/commit/c10f5a47f60a8c4939990c21f7f508e44e25c6a1?ref=oh-3.22.0&prId=1041))
- 更新fluttertpc_dart_sdk仓库版本到ee0af3db ([21b87e83](https://gitcode.com/openharmony-tpc/flutter_engine/commit/21b87e83801415fb7268cf3558e74e7316f11279?ref=oh-3.22.0&prId=1034))
## 6.0.0.701
- 修复多web时，鼠标/双指滑动无法滚动的问题 ([21973a44](https://gitcode.com/openharmony-tpc/flutter_engine/commit/21973a442675798a227385a42331067492b3ab1f?ref=oh-3.22.0&prId=1030))
- 编译和上传debug引擎产物时，改为默认不使用unoptimized选项 ([1970b40b](https://gitcode.com/openharmony-tpc/flutter_engine/commit/1970b40bd28013d6b44ca76f6e991871351ddb3f?ref=oh-3.22.0&prId=1027))
## 6.0.0.700
- 预渲染情况下脏区渲染异常修复 ([70dc3dd4](https://gitcode.com/openharmony-tpc/flutter_engine/commit/70dc3dd4dbaba4ab73d7e67d1eb28ec89bcd7f19?ref=damage_paint_fix&prId=1009))
- 解决偶现bottomRect报错问题 ([e5bf1598](https://gitcode.com/openharmony-tpc/flutter_engine/commit/e5bf1598b1af33d1fbe61d6563374de52bf0fb42?ref=oh-3.22.0&prId=1019))
- 修复app点击返回按钮时出现vulkan DestroyImageView崩溃 ([b1b4a31b](https://gitcode.com/openharmony-tpc/flutter_engine/commit/b1b4a31b65c62883190222e911d1734dc5e0016e?ref=oh-3.22.0&prId=1021))
- 处理鸿蒙系统异常touchevent ([5927372a](https://gitcode.com/openharmony-tpc/flutter_engine/commit/5927372a6d6364b806c5874ba558e0d744f89791?ref=hand-touchevent&prId=1020))
- 修复PC调用setWindowLayoutFullScreen接口不生效的问题 ([1ebec606](https://gitcode.com/openharmony-tpc/flutter_engine/commit/1ebec606656739ab6222a5703d8d11548d32adea?ref=oh-3.22.0&prId=1013))
- 解决可能会导致image_source uaf的问题 ([61e16629](https://gitcode.com/openharmony-tpc/flutter_engine/commit/61e166298005b7aa913139a9189fbd6063f46f16?ref=oh-3.22.0&prId=1010))
- 解决delta模式下删除异常的问题 ([91c1a55d](https://gitcode.com/openharmony-tpc/flutter_engine/commit/91c1a55d98c08a8bebae17c5882af07292ef3142?ref=oh-3.22.0&prId=980))
## 6.0.0.603
- 解决可选择文本组件无法滑动问题 ([a8d008e4](https://gitcode.com/openharmony-tpc/flutter_engine/commit/a8d008e4006f036caa37a99997603f6b8bddd9ef?ref=oh-3.22.0&prId=1007))
- 在FlutterEntry中添加系统环境变化监听器，把深色模式、字体等变化发送到dart层 ([8efe18c3](https://gitcode.com/openharmony-tpc/flutter_engine/commit/8efe18c3c4d545f43f1cca6ce26be6d390c01891?prId=1002))
- 解决由于时序问题，导致输入法在同步方法中调用异步粘贴方法，错误插入旧剪贴板数据 ([5d73936e](https://gitcode.com/openharmony-tpc/flutter_engine/commit/5d73936e308da4226a93c09245b74ad377efa336?ref=oh-3.22.0))
- 解决bottomRect of undefined的问题 ([aa8934dd](https://gitcode.com/openharmony-tpc/flutter_engine/commit/aa8934dd671e763b83f28165451d6dbd832754d7?ref=oh-3.22.0&prId=997))
## 6.0.0.602
- 添加hover事件 ([7ae3b049](https://gitcode.com/openharmony-tpc/flutter_engine/commit/7ae3b0494df5987786dffb3b273b81aa746bfcb8?ref=oh-3.22.0&prId=985))
- 新增三方输入法应用反控Flutter输入框的接口适配 ([77a1cb63](https://gitcode.com/openharmony-tpc/flutter_engine/commit/77a1cb6321d565650b41677df60771ed8b718674?ref=feat-input-more-3.22&prId=995))
- impeller渲染超出纹理范围图片时，不走scalePixels，加速大图渲染 ([c3a919dd](https://gitcode.com/openharmony-tpc/flutter_engine/commit/c3a919dd2e5f96ce3a76723526b414114cbd69c7?ref=oh-3.22.0&prId=976))
- 新增ui卡死检测上报 ([3dd71c49](https://gitcode.com/openharmony-tpc/flutter_engine/commit/3dd71c494326053a76ca8f2a8d5baa65db70ef49?ref=oh-3.22.0&prId=977))
- 修复外接纹理情况下，无法抛滑问题 ([aafb5659](https://gitcode.com/openharmony-tpc/flutter_engine/commit/aafb5659ec09dd27d861cb3aab5d0741c8f444eb?ref=oh-3.22.0&prId=990))
## 6.0.0.600
- 适配webview鼠标hover功能 ([9928387c](https://gitcode.com/openharmony-tpc/flutter_engine/commit/9928387ca45be8848daaf1a90ba36a1d8915b8a1?ref=oh-3.22.0&prId=973))
- 解决DeltaTextInputClient回车和删除操作异常的问题 ([f400b855](https://gitcode.com/openharmony-tpc/flutter_engine/commit/f400b8552b12e22e313c845935e055bfed43cbbb?ref=oh-3.22.0&prId=975))
## 6.0.0.504
- 解决使用impeller-vulkan时，放大缩小窗口时偶现花屏的问题 ([3117a469](https://gitcode.com/openharmony-tpc/flutter_engine/commit/3117a469862889dc8ed6cdc8fc2c31f872850884?ref=oh-3.22.0&prId=970))
## 6.0.0.503
- 系统字体配置改为先从系统接口获取再从json文件获取 ([d19d3a2f](https://gitcode.com/openharmony-tpc/flutter_engine/commit/d19d3a2f8db11e9e6f0f7e43eaad607e3849f032?ref=font&prId=908))
- 修复platformview和flutter输入框来回点击导致flutter侧无法输入的问题 ([5dcef493](https://gitcode.com/openharmony-tpc/flutter_engine/commit/5dcef49354a3d9204395a5cf11fc2f17aeb9b358?ref=oh-3.22.0&prId=958))
- flutter引擎上游单元测试移植，修复host编译错误 ([c2fdd5af](https://gitcode.com/openharmony-tpc/flutter_engine/commit/c2fdd5aff3aeebae410364c21f8ebce32e63121b?ref=oh-3.22.0&prId=955))
- 图片编解码替换不拷贝内存接口 ([fd7c81f5](https://gitcode.com/openharmony-tpc/flutter_engine/commit/fd7c81f5ec9a45e2c164ce3e7d7609bfa56b83a3?ref=oh-3.22.0&prId=950))
- 修复message loop中对epoll wait的重复调用 ([e3705299](https://gitcode.com/openharmony-tpc/flutter_engine/commit/e37052993a2005b5bd6130657d27013255b21661?ref=modify-loop&prId=954))
- 使用LTRB格式描述DisplayFeature的信息 ([1966a63d](https://gitcode.com/openharmony-tpc/flutter_engine/commit/1966a63dafbfc6ce449e4dbbb35483303fb82e76?ref=modify-cutout-info&prId=956))
- 同步官方仓对impeller过大纹理限制操作 ([286f1418](https://gitcode.com/openharmony-tpc/flutter_engine/commit/286f1418e7fdf3883f1b6bdb8aeb4f4ec109e548?ref=oh-3.22.0&prId=952))
- 新增物理键盘的ctrl/alt/shift修饰键模式适配，解决长按修饰键跨应用复制粘贴、onKeyEvent回调组合键注入模式的异常情况 ([5ec3f445](https://gitcode.com/openharmony-tpc/flutter_engine/commit/5ec3f445a257ada55faed46d9cd690293d1aa4a9?ref=feat-keyevent-supplement-3.22&prId=926))
## 5.1.0.601
- 修改flutter外接纹理buffer丢弃策略 ([7333ba1b](https://gitcode.com/openharmony-tpc/flutter_engine/commit/7333ba1bf1c5e1420aa92ced2b5bf3ace0bceec9?ref=oh-3.22.0))
- 解决api20外接键盘无法输入问题 ([94d2b279](https://gitcode.com/openharmony-tpc/flutter_engine/commit/94d2b2793f8fb6c81fd5282c08ab06b0def693fa?ref=oh-3.22.0&prId=942))
- 修改模拟器上竖屏视频播放倒转的问题 ([a142a25f](https://gitcode.com/openharmony-tpc/flutter_engine/commit/a142a25fd21d0a7837f64470479eb7e2e705ad34?ref=oh-3.22.0&prId=934))
- 修复鼠标点击事件导致的hover异常问题 ([d40b702a](https://gitcode.com/openharmony-tpc/flutter_engine/commit/d40b702a49091e1c06d14eedd4120b46944d5491?ref=oh-3.22.0&prId=938))
## 6.0.0.402
- 修复nativeShellHolderId变量为null时，执行flutterNapi方法闪退问题 ([2597ff86](https://gitcode.com/openharmony-tpc/flutter_engine/commit/2597ff860704be905a258ddcfeebe1934762d6c6?ref=fix-a11y-shellholderid-null&prId=911))
- 修复多FlutterEntry情况下，生命周期异常的问题 ([e1c4d501](https://gitcode.com/openharmony-tpc/flutter_engine/commit/e1c4d50196f523d6d4b4280430596b941390473c?ref=oh-3.22.0&prId=923))
## 6.0.0.401
- 新增单独上传flutter.har和symbols.zip的脚本 ([244c6914](https://gitcode.com/openharmony-tpc/flutter_engine/commit/244c691495cab82af9052b4c7b9c4568c5d5fb97?ref=oh-3.22.0&prId=913))
- 修改超大gif图场景的内存泄露问题 ([69593346](https://gitcode.com/openharmony-tpc/flutter_engine/commit/69593346903290f33e709273229dfdd87bd009cf?ref=oh-3.22.0))
- resolve the memory leaking of webview ([219f7180](https://gitcode.com/openharmony-tpc/flutter_engine/commit/219f71803ca53ebadd0994a398e9124e38e564e2?ref=oh-3.22.0))
## 5.1.0.503
- 修正 FlutterView 中 routerPageUpdate 监听器的添加和移除 ([33bc06ac](https://gitcode.com/openharmony-tpc/flutter_engine/commit/33bc06acb9beaf328c5c50b111b7e31107b94d1f?ref=fix/router_page_update_observer&prId=880))
- 打包，上传dart sdk的脚本添加--arch参数，可以通过这个参数指定上传arm64或x64的dart sdk ([525076f9](https://gitcode.com/openharmony-tpc/flutter_engine/commit/525076f992ae9a4aad72cf4665fbe2883a282af6?ref=oh-3.22.0&prId=885))
- Fix FlutterAssets getAssetFilePathByName with bundleName not working ([51d4ab57](https://gitcode.com/openharmony-tpc/flutter_engine/commit/51d4ab57b89b8277fa042ba520f1e9cef27dfdb3?ref=getAssetFilePath&prId=889))
- 图片解码适配EXIF旋转 ([b457391a](https://gitcode.com/openharmony-tpc/flutter_engine/commit/b457391a88ec24a66d989ffc4ba5b4af91d1b929?ref=fix_exif&prId=838))
- 解决Shell析构时可能发生的多线程并发问题 ([45a0829e](https://gitcode.com/openharmony-tpc/flutter_engine/commit/45a0829e0488c85b7c0392aac02d7c2a88e0e0f0?ref=avoid-concurrency&prId=870))
- 支持外接纹理局部刷新 ([3dc62d2b](https://gitcode.com/openharmony-tpc/flutter_engine/commit/3dc62d2b8c7321c863e79cd38523c1bf0ca16cf0?ref=external_texture_partial_repaint&prId=872))
- 修改Windows环境编译ohos-x64的engine产物报错的问题 ([b2b97c7b](https://gitcode.com/openharmony-tpc/flutter_engine/commit/b2b97c7ba7e5691925e6db5ac84367cc241dd303?ref=oh-3.22.0))
- 修复MediaQuery.of(context).accessibleNavigation状态值异常 ([eb07902e](https://gitcode.com/openharmony-tpc/flutter_engine/commit/eb07902e0e82459a8da1c896dcdbcabc498b6418?ref=fix-accessibility-navigation-3.22&prId=857))
- API15后通过轴事件实现触控板捏合和抛滑手势，及鼠标滚轮滚动和Ctrl+滚轮缩放 ([849bc84b](https://gitcode.com/openharmony-tpc/flutter_engine/commit/849bc84b7cb079e5b1eefe7ef0c0cbd9c9831353?ref=axis&prId=899))
- 更改xcomponentMap_mutex为可重入锁 ([93fe98f6](https://gitcode.com/openharmony-tpc/flutter_engine/commit/93fe98f6d49f31ca6829f8a76781d852ce9441df?ref=oh-3.22.0&prId=879))
- 新增性能雷达特性 ([23c33d3c](https://gitcode.com/openharmony-tpc/flutter_engine/commit/23c33d3c5e404a61882a0770b3818c08edec4161?ref=3.22_merge_api18&prId=896))
- result.notImplemented()实现中，修改reply方法参数为null ([6a243943](https://gitcode.com/openharmony-tpc/flutter_engine/commit/6a243943cc89f386212c112f4397252ca98786b1?ref=notImplemented_3.22&prId=869))
- flutter_embedding支持ets和native产物分开引用 ([939be92a](https://gitcode.com/openharmony-tpc/flutter_engine/commit/939be92ad4c9dd9efa6775fe239c9d80159cb40b?ref=feature-build-3.22&prId=823))
## 5.1.0.502
- 无障碍支持xcomponent多实例/多引擎场景 ([e7a98130](https://gitcode.com/openharmony-tpc/flutter_engine/commit/e7a98130f574f0b0cff0ff73776c085c5a583d43?ref=oh-3.22.0))
- 修复输入法文本光标位置更新和文本错误替换的问题([4729b57d](https://gitcode.com/openharmony-tpc/flutter_engine/commit/4729b57dec567a345180582670af05fea8624867?ref=fix-input-changeselection_3.22&prId=847))
- 修复外接物理键盘时,用中文输入法输入内容后按删除键,导致额外删除输入框中的字符的问题 ([0fa997df](https://gitcode.com/openharmony-tpc/flutter_engine/commit/0fa997dfa9b6767bdebc6726284845dbbabdf21c?ref=feature-keyevent-3.22&prId=840))
- 修改engine编译依赖的仓库管理方式 ([681fd1f2](https://gitcode.com/openharmony-tpc/flutter_engine/commit/681fd1f2ec188aeadfe9981472379919e0d31522?ref=multi-repos&prId=790))
- 修复输入框导致的闪动的问题 ([33144cd9](https://gitcode.com/openharmony-tpc/flutter_engine/commit/33144cd9b8f738aa43238635cd16e22df40b9b79?ref=oh-3.22.0&prId=830))
- 使用bigint来表示native image和native window的指针 ([2ae04939](https://gitcode.com/openharmony-tpc/flutter_engine/commit/2ae04939365f0b682ec638a91bfd9aacf7723081?ref=new_interface&prId=805))
## 5.1.0.403SP1
- Window内存泄露修复 ([15e9ff7f](https://gitcode.com/openharmony-tpc/flutter_engine/commit/15e9ff7faaac99db25014d9a7b3d15a0050ef1ac?ref=fix_window_leak&prId=796))
- 修改外接纹理的内容时重新调度一帧 ([1d86f339](https://gitcode.com/openharmony-tpc/flutter_engine/commit/1d86f33900d8690d5f2802d09b9a161ad2459e4f?ref=oh-3.22.0))
- 避免主线程外接纹理生产端死锁 ([979e1815](https://gitcode.com/openharmony-tpc/flutter_engine/commit/979e1815f515e83ebe4816e8addc6f50723b3a45?ref=external_teture_avoid_dead_lock&prId=804))
- impeller简单遮挡剔除 & 修复部分场景组件不渲染 ([2ead7ffb](https://gitcode.com/openharmony-tpc/flutter_engine/commit/2ead7ffbc429ae7660947f10f05c75d4c31984eb?ref=oh-3.22.0))
- 修正外接纹理第一帧背景色颜色格式为ABGR ([fd3717ce](https://gitcode.com/openharmony-tpc/flutter_engine/commit/fd3717ce2234d5cea70e3ec19543ead96d885f8e?ref=22-ABGR&prId=793))
- 修复外接键盘时，shift加方向键文字被删除的问题 ([b9772832](https://gitcode.com/openharmony-tpc/flutter_engine/commit/b9772832d2ec3f96a394387e00b41dab3eadd687?ref=oh-3.22.0&prId=786))
- 分支同步外接纹理LRU缓存策略优化 ([a1700852](https://gitcode.com/openharmony-tpc/flutter_engine/commit/a1700852477189eb4ea5f803b14308432640c0a5?ref=code-better-lru&prId=683))
- 路由跳转软键盘状态异常处理 ([ed9aee2e](https://gitcode.com/openharmony-tpc/flutter_engine/commit/ed9aee2ef22cc45117060acf6767782157ba02cc?ref=oh-3.22.0&prId=803))
- 增加导出接口EventSink, StreamHandler ([aa58c13b](https://gitcode.com/openharmony-tpc/flutter_engine/commit/aa58c13b9e8177433b8a3e70cd0c34b66ec1fb90?ref=oh-3.22.0&prId=788))
- 修复3.22版本谷歌社区存在的RangeError问题 ([be8b22ce](https://gitcode.com/openharmony-tpc/flutter_engine/commit/be8b22ce6a6bfab7163f1e443fdd0cfd4816e5ec?ref=oh-3.22.0&prId=800))
## 5.1.0.402
- 在flutternapi的析构函数中执行napi_reference_unref，取消在nativeDestroy中的napi_delete_reference,避免destroy后又调用napi方法导致的crash ([2d7bb045](https://gitcode.com/openharmony-tpc/flutter_engine/commit/2d7bb04571c712838a076cd26a74455d6a91d42e?ref=oh-3.22.0))
- pick !684 支持输入法输入成对符号时，光标自动调整到成对符号中间 (3.7:[1102b9d8](https://gitcode.com/openharmony-tpc/flutter_engine/commit/1102b9d825a32948f63166ff7ffc6147448cf766?ref=dev))
- ohos拉起键盘的方法新增参数,传入设备类型 ([8e6bfac5](https://gitcode.com/openharmony-tpc/flutter_engine/commit/8e6bfac594c4384e50ee4a839ccb0dfa19a69a1a?ref=oh-3.22.0))
- 修复napi和FlutterManager内存泄露问题 ([7083ccc3](https://gitcode.com/openharmony-tpc/flutter_engine/commit/7083ccc3024c6fb340c9ab5c6915c64579f290aa?ref=oh-3.22.0))
- 合入3.22的PR95，修正aibar避让逻辑 (3.7:[b1b571f5](https://gitcode.com/openharmony-tpc/flutter_engine/commit/b1b571f51bd63506f14c5f7b491210ce78672ad1?ref=dev))
- 外接纹理LRU缓存策略优化 ([d0237dcf](https://gitcode.com/openharmony-tpc/flutter_engine/commit/d0237dcf037b388084e816e434f1d5d66bb7b5e8?ref=oh-3.22.0))
- Impeller脏区渲染能力支持 ([d5b896c1](https://gitcode.com/openharmony-tpc/flutter_engine/commit/d5b896c1a111bc1e1a28a52248ae4b83e4f4ea86?ref=oh-3.22.0))
- Impeller简单遮挡剔除 ([8d857bcd](https://gitcode.com/openharmony-tpc/flutter_engine/commit/8d857bcd5fe4c431c21367329b0d309a639e12e9?ref=oh-3.22.0))
- 支持输入法输入成对符号时，光标自动调整到成对符号中间([82c88625](https://gitcode.com/openharmony-tpc/flutter_engine/commit/82c88625d777ba04c65db5989d741fe73303f0ca?ref=oh-3.22.0))
- 使能hwasan内存检查 ([2afe9481](https://gitcode.com/openharmony-tpc/flutter_engine/commit/2afe9481b26e643352171fef5e8e74eb66517fac?ref=oh-3.22.0))
- 修复主动收起软键盘，应用失焦后获焦仍会接续软键盘的问题 ([7c8f6406](https://gitcode.com/openharmony-tpc/flutter_engine/commit/7c8f640607e8a4cb741fe5300f611e3198b53773?ref=oh-3.22.0))
- 修复同一个engineGroup的多engine场景下，只有一个engine能够正常切换字体问题 ([64b9332e](https://gitcode.com/openharmony-tpc/flutter_engine/commit/64b9332e2eb83a60b30de8e58c356abf7533d5a0?ref=oh-3.22.0))
- 修复在新机或者恢复出厂设置后的机器上首次切换字体失效问题 ([c90cb606](https://gitcode.com/openharmony-tpc/flutter_engine/commit/c90cb60687392cf13bcffd7494db1a6d2adabcca?ref=oh-3.22.0))
- 时间戳偏移位置移动 ([c85d4e97](https://gitcode.com/openharmony-tpc/flutter_engine/commit/c85d4e97fa7d5ae980ff84cbbc546095b218b5a0?ref=oh-3.22.0))
## 5.1.0.401
- 修复双指离开页面，导致会有一个手指事件无法结束的的问题 ([464fb8a6](https://gitcode.com/openharmony-tpc/flutter_engine/commit/464fb8a6f5670a7a65a9ced3c0d0228305e65e27?ref=oh-3.22.0))
- 支持在windows-x64的模拟器上运行flutter应用 ([30856cf1](https://gitcode.com/openharmony-tpc/flutter_engine/commit/30856cf1e067c8ecfecab81f72275ce6342cb58c?ref=oh-3.22.0))
- 添加createSurfaceTexture，registerSurfaceTexture接口 ([84182d70](https://gitcode.com/openharmony-tpc/flutter_engine/commit/84182d708232c1023d4890216baa49bbd99625a5?ref=oh-3.22.0))
- 更新版权头信息 ([ee00babb](https://gitcode.com/openharmony-tpc/flutter_engine/commit/ee00babbe26721c313c2b07d0bf0ab5ed1a7b594?ref=oh-3.22.0))
- 添加SetTextureBackGroundColor用户接口 ([7fbbf60c](https://gitcode.com/openharmony-tpc/flutter_engine/commit/7fbbf60c13ea99bdcd997b24369f60bc60181d9e?ref=oh-3.22.0))
- 修改OHOS_PLATFORM宏为__OHOS__，并移动至compiler ([5182ad32](https://gitcode.com/openharmony-tpc/flutter_engine/commit/5182ad32eda7e5cbcff55599589c11b355f15862?ref=oh-3.22.0))
## 5.1.0.305
- 修复一个del删除两个字符的问题 ([fbe06f28](https://gitcode.com/openharmony-tpc/flutter_engine/commit/fbe06f286fb31ae0b132976627dc8867deaf89a1?ref=oh-3.22.0))
- 解决platformview强制销毁时,输入法不自动收回问题 ([b628b0a8](https://gitcode.com/openharmony-tpc/flutter_engine/commit/b628b0a8a2abd04484d423707c055ca5ede97f9d?ref=oh-3.22.0))
- 单指上下滑动切换焦点时增加showOnScreen动作 ([da80e3f8](https://gitcode.com/openharmony-tpc/flutter_engine/commit/da80e3f8c466926a9b5f1d21cd05352cce5d3943?ref=oh-3.22.0))
- 添加兼容3.7的SetDvsyncSwitch接口 ([71dc4d74](https://gitcode.com/openharmony-tpc/flutter_engine/commit/71dc4d74c5392d5baa70561ee668c984ba06a25c?ref=oh-3.22.0))
- 同步paddingtop和PlatformViewParas，并且标记废弃接口 ([6cc4aa4f](https://gitcode.com/openharmony-tpc/flutter_engine/commit/6cc4aa4fcaff42b4f619c2eb9046e62a449909a7?ref=oh-3.22.0))
- pick !618Flutter手势问题处理([1d662178](https://gitcode.com/openharmony-tpc/flutter_engine/commit/1d66217864f7efb1cbfdc4c207a7024f9b0ef7a9?ref=oh-3.22.0))
- 增加napi nativeSetTextureBackGroundColor以保证和3.7版本兼容 ([8ca17a21](https://gitcode.com/openharmony-tpc/flutter_engine/commit/8ca17a211c526dd38bffe1234def2c3be227784c?ref=oh-3.22.0))
- 修改针对节点是否是输入框设置不同的content属性 ([2f2b429d](https://gitcode.com/openharmony-tpc/flutter_engine/commit/2f2b429d67a538517b32a742601bdb0a57f2a4b3?ref=oh-3.22.0))
- 修复字体粗细无法跟随系统缩小 ([2c0823af](https://gitcode.com/openharmony-tpc/flutter_engine/commit/2c0823af10b9418acdebe024f935418e350fd4fc?ref=oh-3.22.0))
- 当执行ohos -b BRANCH时，只更新代码，不编 译LocalEngnie ([dbe17852](https://gitcode.com/openharmony-tpc/flutter_engine/commit/dbe178522d7245d5a7b632686ddc94d230769a3f?ref=oh-3.22.0))
- mac-arm64打包artifacts.zip时添加flutter_tester ([47e808fa](https://gitcode.com/openharmony-tpc/flutter_engine/commit/47e808fa458561bc72be58801bf4853411cb011f?ref=oh-3.22.0))
## 5.1.0.304
- pick590 适配2in1,支持鼠标框选文字,修复滚轮方向 ([f622aa28](https://gitcode.com/openharmony-tpc/flutter_engine/commit/f622aa281322407f37be604ff24a13b37b49b23b?ref=oh-3.22.0))
- 硬件合成下增加BufferQueue大小以避免轮转阻塞 ([765a12c8](https://gitcode.com/openharmony-tpc/flutter_engine/commit/765a12c814ac04e6ba6fbebe18c0b79f21dde1b4?ref=oh-3.22.0))
- pick 610 mediaquery不支持physicaltouchshop信息 ([69b4a497](https://gitcode.com/openharmony-tpc/flutter_engine/commit/69b4a4977a2597353f85a1efd94cdc29b0b73187?ref=oh-3.22.0))
- 以Vsync间隔及时更新屏幕刷新率 ([544584c6](https://gitcode.com/openharmony-tpc/flutter_engine/commit/544584c67ca238635ac801bdb11fc4b9b018e4ac?ref=oh-3.22.0))
- GPU驱动报错打印修复 ([7baab9ea](https://gitcode.com/openharmony-tpc/flutter_engine/commit/7baab9ea1ac736be391a72f23fbbcf078dd188cc?ref=oh-3.22.0))
- 代码格式化 ([993e29fa](https://gitcode.com/openharmony-tpc/flutter_engine/commit/993e29fa1ff4e98eea6f507c1d00f5bc3350a4a2?ref=oh-3.22.0))
- 修复无障碍事件发送时debug日志未检查空指针 ([60af53ba](https://gitcode.com/openharmony-tpc/flutter_engine/commit/60af53ba3c75a20982c76433d04f0d0a89e8bc8f?ref=oh-3.22.0))
## 5.1.0.303
- fix: 当鼠标离开组件时，传递鼠标离开事件到FlutterEngine ([1839a1df](https://gitcode.com/openharmony-tpc/flutter_engine/commit/1839a1df908458ac4bd37a3433d54b48c590cf01?ref=oh-3.22.0))
- 删除重复的@builder ([874f961e](https://gitcode.com/openharmony-tpc/flutter_engine/commit/874f961efc4ea3301d56b28a8e61fdb51551f267?ref=oh-3.22.0))
- 解决混合模式场景下在attach和detach间切换时PlatformView被重复创建的问题  ([721b72c3](https://gitcode.com/openharmony-tpc/flutter_engine/commit/721b72c33a609d86e3ffe2306899d376c1c12e4e?ref=oh-3.22.0))
- feat: 支持FlutterAbility可解除默认全屏，默认根据设备类型决定是否全屏 ([3ee8e619](https://gitcode.com/openharmony-tpc/flutter_engine/commit/3ee8e619013afe574a20f3747a230fa304a8b23e?ref=oh-3.22.0))
- 修复keyevent处理的一些问题 ([6a6d7eaa](https://gitcode.com/openharmony-tpc/flutter_engine/commit/6a6d7eaa1dcd8fead91489ad249b9f8f409d8bcf?ref=oh-3.22.0))
- cherry-pick 3.7.0dev分支等部分内容 ([f8e03357](https://gitcode.com/openharmony-tpc/flutter_engine/commit/f8e033571fe6a43a3b8603e3f7ffb2e7a6d3cbe2?ref=oh-3.22.0))
- cherry-pick 3.7.0dev分支的点击webview穿透等部分内容 ([afbe5a00](https://gitcode.com/openharmony-tpc/flutter_engine/commit/afbe5a004ff9e6c1d4524f6063c4e91c7f1f2401?ref=oh-3.22.0))
- [无障碍] 更正并优化节点查找逻辑 ([35fb25e8](https://gitcode.com/openharmony-tpc/flutter_engine/commit/35fb25e88a78f2ef3967ad131ad8fd6f441dc9b9?ref=oh-3.22.0))
- 补齐无障碍操作编辑框功能 ([3763630a](https://gitcode.com/openharmony-tpc/flutter_engine/commit/3763630adbe7d22f2bf11e8a3fc0cf8de6f93d16?ref=oh-3.22.0))
- Mark the accessibilityLevel of focusable node as "yes" ([b88e3bbd](https://gitcode.com/openharmony-tpc/flutter_engine/commit/b88e3bbdb5c1fe45285026c58a458434a62a9597?ref=oh-3.22.0))
- Fix the bug of updateViewportMetrics when there is no cutout info ([c97d361a](https://gitcode.com/openharmony-tpc/flutter_engine/commit/c97d361a4a864c4c69959889781f60a5635b5c24?ref=oh-3.22.0))
- 解决滑动过快无法正确切换聚焦节点问题 ([db65ccb0](https://gitcode.com/openharmony-tpc/flutter_engine/commit/db65ccb0addbcb2f5af6cd69002d918ba2443f96?ref=oh-3.22.0))
- 同步oh-3.22.0和oh-3.22.0-merge-history分支 ([5c1c284c](https://gitcode.com/openharmony-tpc/flutter_engine/commit/5c1c284c22c907bbbe559bbce86843eee305f059?ref=oh-3.22.0))
- !633 3.22.0分支合入 ([e7191dda](https://gitcode.com/openharmony-tpc/flutter_engine/commit/e7191dda6212b416be935c4b8c88cb479341dd05?ref=oh-3.22.0))
- Merge branch 'oh-3.22.0' into oh-3.22.0-merge-history for accessibility-refactor ([5df9ec0a](https://gitcode.com/openharmony-tpc/flutter_engine/commit/5df9ec0a851b61498bee2f2ffc8d5b1d01b95a20?ref=oh-3.22.0))

