# Changelog

<a id="version20261024"></a>
## [3.44.9+ohos-1.0.0-beta] - `2026-10-24`

### Added

- feat: add --use-ccache option to ohos.py to enable ccache engine builds [!2227](https://gitcode.com/CPF-Flutter/flutter_flutter/merge_requests/2227)
- feat(HCPP): adopt overlay-only a11y registration and inject wrapper-blocked touch to engine [!2263](https://gitcode.com/CPF-Flutter/flutter_flutter/merge_requests/2263)
- feat(Windowing): size tooltip/popup windows to their content [!2204](https://gitcode.com/CPF-Flutter/flutter_flutter/merge_requests/2204)
- feat(Windowing): restructure multi-window hosts per archetype [!2237](https://gitcode.com/CPF-Flutter/flutter_flutter/merge_requests/2237)
- feat(flex_overflow): dynamic DPI overflow strategy with testing API and unit tests [!2062](https://gitcode.com/CPF-Flutter/flutter_flutter/merge_requests/2062)
- feat(Embedding): support engine flags via module.json5 metadata [!1907](https://gitcode.com/CPF-Flutter/flutter_flutter/merge_requests/1907)
- feat(Viewport): add display corner radii support on OHOS; force alpha to one for opaque RGBX_8888 buffers [!1798](https://gitcode.com/CPF-Flutter/flutter_flutter/merge_requests/1798)
- feat(ohos): 完善 GPU 资源回收全流程日志埋点 [!1854](https://gitcode.com/CPF-Flutter/flutter_flutter/merge_requests/1854)

### Changed

- 【3.44】change(Template): 更新oh flutter图标 [!2072](https://gitcode.com/CPF-Flutter/flutter_flutter/merge_requests/2072)
- 【3.44】change(Template): OHOS模板targetSdkVersion升级至26.0.0并统一compatibleSdkVersion至5.0.5(17) [!2024](https://gitcode.com/CPF-Flutter/flutter_flutter/merge_requests/2024)
- 【3.44】规范多窗口napi代码; 多窗口C++层代码瘦身与napi失败路径整改 [!2017](https://gitcode.com/CPF-Flutter/flutter_flutter/merge_requests/2017)
- fix: 多窗口锚定宿主自治重构&窗口规范适配 [!1899](https://gitcode.com/CPF-Flutter/flutter_flutter/merge_requests/1899)
- fix: Refactor input method pre-input display [!1823](https://gitcode.com/CPF-Flutter/flutter_flutter/merge_requests/1823)

### Fixed

- 【3.44】fix(Widgets): expose dismissible ModalBarrier semantics on OHOS [!2260](https://gitcode.com/CPF-Flutter/flutter_flutter/merge_requests/2260)
- fix(Embedding): apply system font weight scale on cold start [!2254](https://gitcode.com/CPF-Flutter/flutter_flutter/merge_requests/2254)
- fix: restrict windowing embedder to Impeller Vulkan and adapt UTs [!2253](https://gitcode.com/CPF-Flutter/flutter_flutter/merge_requests/2253)
- fix: honor embedded GIF loop count on OHOS [!2247](https://gitcode.com/CPF-Flutter/flutter_flutter/merge_requests/2247)
- fix: SystemMouseCursors on OHOS [!2172](https://gitcode.com/CPF-Flutter/flutter_flutter/merge_requests/2172)
- fix: add missing space after --unuse-bisheng and stop swallowing gn failures [!2209](https://gitcode.com/CPF-Flutter/flutter_flutter/merge_requests/2209)
- fix(FlutterView): use window effective density for viewport dpr updates [!2193](https://gitcode.com/CPF-Flutter/flutter_flutter/merge_requests/2193)
- 【3.44】(PlatformView): set width/height zeroing in hidePlatformViewHybrid [!2187](https://gitcode.com/CPF-Flutter/flutter_flutter/merge_requests/2187)
- fix cursor selection range issue [!2151](https://gitcode.com/CPF-Flutter/flutter_flutter/merge_requests/2151)
- 【3.44】fix(PlatformView): keep pv geometry when hiding to fix inappwebview scroll at zero opacity [!2167](https://gitcode.com/CPF-Flutter/flutter_flutter/merge_requests/2167)
- 【3.44】fix(PlatformView): move affine transform to a separate channel message [!2133](https://gitcode.com/CPF-Flutter/flutter_flutter/merge_requests/2133)
- fix(ohos): map custom hvigor build modes to standard flutter modes [!2001](https://gitcode.com/CPF-Flutter/flutter_flutter/merge_requests/2001)
- fix: decode negative BigInt in standard message codecs [!2082](https://gitcode.com/CPF-Flutter/flutter_flutter/merge_requests/2082)
- fix(ohos): restore plugin state after ability recreation [!2043](https://gitcode.com/CPF-Flutter/flutter_flutter/merge_requests/2043)
- fix: physicalTouchSlop missing dpr conversion, touchSlop dropped to 1.4 [!2022](https://gitcode.com/CPF-Flutter/flutter_flutter/merge_requests/2022)
- 【3.44】fix(Texture): implement SurfaceTextureEntry.release() via unregisterTexture [!2000](https://gitcode.com/CPF-Flutter/flutter_flutter/merge_requests/2000)
- fix(Channel): send fallback error envelope when result decode fails; deliver error envelope when dart handler throws [!1971](https://gitcode.com/CPF-Flutter/flutter_flutter/merge_requests/1971)
- fix: unregister preview callbacks [!1986](https://gitcode.com/CPF-Flutter/flutter_flutter/merge_requests/1986)
- fix(safearea): correct safe area padding for edgeToEdge and freeform window exit [!1968](https://gitcode.com/CPF-Flutter/flutter_flutter/merge_requests/1968)
- fix: pass --route parameter to hdc aa start via --ps route Want parameter [!1902](https://gitcode.com/CPF-Flutter/flutter_flutter/merge_requests/1902)
- fix: tooltip/popup窗口deactivate销毁规范&slide闪烁与resize修复 [!1900](https://gitcode.com/CPF-Flutter/flutter_flutter/merge_requests/1900)
- fix(hcpp): 【3.44】Fix the HCPP switch to enable correct texture z-order sequencing [!1877](https://gitcode.com/CPF-Flutter/flutter_flutter/merge_requests/1877)
- fix(memory_leak): Fix some memory leakage issues related to HarmonyOS adaptation [!1862](https://gitcode.com/CPF-Flutter/flutter_flutter/merge_requests/1862)
- fix(Accessibility): expose OHOS semantics to UiTest [!1808](https://gitcode.com/CPF-Flutter/flutter_flutter/merge_requests/1808)
- Fix PlatformView touch/mouse/axis coordinate space errors and left-click offset on windowed HarmonyOS PC,([88563e101a5](https://gitcode.com/CPF-Flutter/flutter_flutter/commit/88563e101a516ca7fec317eb692b2385f66d5ed0))
- fix: Adapt the DevEco signature configuration to the new version,([9b42bdcf4d5](https://gitcode.com/CPF-Flutter/flutter_flutter/commit/9b42bdcf4d5b9f3e4138dab5364a6a3f6fd4940f))
- Solve the problem of abnormal coordinate distribution for platformview click events under dynamic dpi,([edf6527f1c1](https://gitcode.com/CPF-Flutter/flutter_flutter/commit/edf6527f1c16a390092e91bf6cc6205d2c97d91a))
- 【3.44】修复StandardMessageCodec.writeValueInternal 绕过子类覆写导致序列化失败,([75d519e5c8a](https://gitcode.com/CPF-Flutter/flutter_flutter/commit/75d519e5c8a241587c0d976bbe16fe1389111ad0))
- fix: Fix the total frame count issue during sliding frame drops,([74c9ea59084](https://gitcode.com/CPF-Flutter/flutter_flutter/commit/74c9ea5908486c94749c169370904986ed6da231))
- 【3.44】修复channel传递递归数据导致jscrash,([6becd6728c5](https://gitcode.com/CPF-Flutter/flutter_flutter/commit/6becd6728c5f0c0474e57bbd381e49223f361df7))
- postInputEventWithStrategy支持失败回落postInputEvent,([06fe0529665](https://gitcode.com/CPF-Flutter/flutter_flutter/commit/06fe0529665ecd27fa66b4eb58f3ad289b5495f9))
- 更新 FlutterPage.ets 取消 flutterView 断言，避免 crash,([df703385973](https://gitcode.com/CPF-Flutter/flutter_flutter/commit/df703385973bd2fb8f5cae303e08a09de39faa3b))
- fix(ohos): bundle NativeAssetsManifest.json into flutter_assets to align with android,([ca2f2c03c4d](https://gitcode.com/CPF-Flutter/flutter_flutter/commit/ca2f2c03c4d00bbc1ce1f53fc65d7da34651107a))
- fix(input): 修复多引擎场景FlutterView#onWindowCreated未调用,导致输入法弹起时keyboardHeightChangeCallback不执行的问题,([a744aa70b4a](https://gitcode.com/CPF-Flutter/flutter_flutter/commit/a744aa70b4a3436436eed5c588aa2b6b8c2c75b4))
- fix(PlatformView): 【3.44】rename viewId to ohosHcppViewId to avoid subclass name conflicts,([cfd6b9194e2](https://gitcode.com/CPF-Flutter/flutter_flutter/commit/cfd6b9194e2784f8811813d440d97b956fdd240f))

## 3.44.9-ohos-0.0.1
- 修复ohos侧flutter --build-dir=build3 无法生成build3目录,([4e00ef11a1](https://gitcode.com/CPF-Flutter/flutter_flutter/commit/4e00ef11a1208157ff3e14b82ed23beb80d8cd90?ref=oh-3.44.9-dev))
- 解决 flutter 编译执行其他平台产物 crash 的问题,([440167da4f](https://gitcode.com/CPF-Flutter/flutter_flutter/commit/440167da4fd710885d879023c03e615e6170d165?ref=oh-3.44.9-dev))
- 解决 Mac 编译 engine 时 metal 侧报错问题,([850a6af3ed](https://gitcode.com/CPF-Flutter/flutter_flutter/commit/850a6af3ed708007aaaead6f3c48daa686ec36dd?ref=oh-3.44.9-dev))
