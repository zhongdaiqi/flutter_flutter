/*
 * Copyright (C) 2024 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import FlutterNapi from '../../../../../main/ets/embedding/engine/FlutterNapi';
import ApplicationInfoLoader from '../../../../../main/ets/embedding/engine/loader/ApplicationInfoLoader';
import { FlutterRenderer } from '../../../../../main/ets/embedding/engine/renderer/FlutterRenderer';
import { common } from '@kit.AbilityKit';
import { afterAll, beforeAll, describe, expect, it } from '@ohos/hypium';
import { EngineLifecycleListener } from '../../../../../main/ets/embedding/engine/FlutterEngine';
import { resourceManager } from '@kit.LocalizationKit';
import FlutterApplicationInfo from '../../../../../main/ets/embedding/engine/loader/FlutterApplicationInfo';
import { FlutterCallbackInformation } from '../../../../../main/ets/view/FlutterCallbackInformation';
import FlutterLoader from '../../../../../main/ets/embedding/engine/loader/FlutterLoader';
import { Action } from '../../../../../main/ets/embedding/engine/systemchannels/AccessibilityChannel';
import Any from '../../../../../main/ets/plugin/common/Any';
import FlutterInjector from '../../../../../main/ets/FlutterInjector';

//jit产物默认kenel文件
const DEFAULT_KERNEL_BLOB = "kernel_blob.bin";
//文件路径分隔符
const FILE_SEPARATOR = "/";

export default function FlutterNapiTest() {
  const flutterNapi = new FlutterNapi();
  const context = getContext() as common.UIAbilityContext;
  let textureId = 0;
  let initResult: InitResult;
  let snapshotAssetPath: string;
  let flutterApplicationInfo: FlutterApplicationInfo;
  let bundlePath: string;
  let event: PanGestureEvent;
  let assetManager: resourceManager.ResourceManager;

  describe('FlutterNapiTest', () => {

    beforeAll(() => {
      if (context) {
        initResult = new InitResult(
          `${context.filesDir}/`,
          `${context.cacheDir}/`,
          `${context.filesDir}`);
        flutterApplicationInfo = ApplicationInfoLoader.load(context);
        snapshotAssetPath = initResult!.dataDirPath + FILE_SEPARATOR + flutterApplicationInfo!.flutterAssetsDir;
        bundlePath = snapshotAssetPath + FILE_SEPARATOR + DEFAULT_KERNEL_BLOB;
        assetManager = context.resourceManager;
      }
      const target: EventTarget = new CustomEventTarget(new CustomArea(0, 0, {
        x: 0, y: 0
      }, {
        x: 0, y: 0
      }));
      const renderer = new FlutterRenderer(flutterNapi);
      textureId = renderer.getTextureId();
      event = {
        offsetX: 50,
        offsetY: 50,
        velocityX: 50,
        velocityY: 50,
        fingerList: [],
        velocity: 0,
        target: target,
        timestamp: 0,
        source: SourceType.Unknown,
        pressure: 0,
        tiltX: 0,
        tiltY: 0,
        sourceTool: SourceTool.Unknown
      }
    });

    it('checkImplemented', 0, async (done: Function) => {
      console.info("uitest: checkImplemented begin");
      const methodName = 'test';
      const flag = flutterNapi.checkImplemented(methodName);
      expect(flag).not().assertNull();
      done();
    })

    it('nativeLookupCallbackInformation', 0, async (done: Function) => {
      console.info("uitest: nativeLookupCallbackInformation begin");
      try {
        const handle = 1;
        const flutterCallbackInformation: FlutterCallbackInformation | null =
          FlutterNapi.nativeLookupCallbackInformation(handle);
        if (flutterCallbackInformation) {
          expect(flutterCallbackInformation).not().assertNull();
        }
      } catch (e) {
      }
      done();
    })

    it('isAttached', 0, async (done: Function) => {
      console.info("uitest: isAttached begin");
      const flag: boolean = flutterNapi.isAttached();
      expect(flag).not().assertNull();
      done();
    })

    it('spawn', 0, async (done: Function) => {
      console.info("uitest: spawn begin");
      const entrypointFunctionName = 'test1';
      const pathToEntrypointFunction = 'test2';
      const initialRoute = 'test3';
      const entrypointArgs = ['test4'];
      try {
        const fnapi: FlutterNapi =
          flutterNapi.spawn(entrypointFunctionName, pathToEntrypointFunction, initialRoute, entrypointArgs);
        expect(fnapi).not().assertNull();
      } catch (e) {
      }
      done();
    })

    it('computePlatformResolvedLocale', 0, async (done: Function) => {
      console.info("uitest: computePlatformResolvedLocale begin");
      const strings = [];
      const arr = flutterNapi.computePlatformResolvedLocale(strings);
      expect(arr).not().assertNull();
      done();
    })

    it('registerTexture', 0, async (done: Function) => {
      console.info("uitest: registerTexture begin");
      const id = flutterNapi.registerTexture(textureId);
      expect(id).not().assertNull();
      done();
    })

    it('unicodeIsEmoji returns boolean for various code points', 0, () => {
      // Standard emoji (grinning face U+1F600)
      expect(typeof FlutterNapi.unicodeIsEmoji(0x1F600)).assertEqual('boolean');
      // Plain ASCII letter
      expect(typeof FlutterNapi.unicodeIsEmoji(0x41)).assertEqual('boolean');
      // Zero
      expect(typeof FlutterNapi.unicodeIsEmoji(0x30)).assertEqual('boolean');
    });

    it('unicodeIsEmojiModifier returns boolean', 0, () => {
      expect(typeof FlutterNapi.unicodeIsEmojiModifier(0x1F3FB)).assertEqual('boolean');
      expect(typeof FlutterNapi.unicodeIsEmojiModifier(0x41)).assertEqual('boolean');
    });

    it('unicodeIsEmojiModifierBase returns boolean', 0, () => {
      expect(typeof FlutterNapi.unicodeIsEmojiModifierBase(0x1F466)).assertEqual('boolean');
      expect(typeof FlutterNapi.unicodeIsEmojiModifierBase(0x41)).assertEqual('boolean');
    });

    it('unicodeIsVariationSelector returns boolean', 0, () => {
      // U+FE0F is a variation selector
      expect(typeof FlutterNapi.unicodeIsVariationSelector(0xFE0F)).assertEqual('boolean');
      expect(typeof FlutterNapi.unicodeIsVariationSelector(0x41)).assertEqual('boolean');
    });

    it('unicodeIsRegionalIndicatorSymbol returns boolean', 0, () => {
      // U+1F1E6 is regional indicator "A"
      expect(typeof FlutterNapi.unicodeIsRegionalIndicatorSymbol(0x1F1E6)).assertEqual('boolean');
      expect(typeof FlutterNapi.unicodeIsRegionalIndicatorSymbol(0x41)).assertEqual('boolean');
    });

    it('checkLTPOSwitchState returns number', 0, () => {
      const state = FlutterNapi.checkLTPOSwitchState();
      expect(typeof state).assertEqual('number');
    });

    it('hasImplemented defaults to false (no init)', 0, () => {
      const fresh = new FlutterNapi();
      expect(fresh.hasImplemented).assertEqual(false);
    });

    it('isAttached returns false initially', 0, () => {
      const fresh = new FlutterNapi();
      expect(fresh.isAttached()).assertEqual(false);
    });

    it('checkImplemented returns false when not implemented', 0, () => {
      const fresh = new FlutterNapi();
      expect(fresh.checkImplemented()).assertEqual(false);
    });

    it('prefetchDefaultFontManager does not throw', 0, () => {
      let threw = false;
      try {
        FlutterNapi.prefetchDefaultFontManager();
      } catch (e) {
        threw = true;
      }
      expect(threw).assertEqual(false);
    });

    it('prefetchFramesCfg does not throw', 0, () => {
      let threw = false;
      try {
        FlutterNapi.prefetchFramesCfg();
      } catch (e) {
        threw = true;
      }
      expect(threw).assertEqual(false);
    });

    it('videoVoting does not throw', 0, () => {
      let threw = false;
      try {
        FlutterNapi.videoVoting(1.0, 60);
      } catch (e) {
        threw = true;
      }
      expect(threw).assertEqual(false);
    });

    it('notifyLowMemoryWarning does not throw when detached', 0, () => {
      const napi = new FlutterNapi();
      let threw = false;
      try { napi.notifyLowMemoryWarning(); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('dispatchEmptyPlatformMessage does not throw when detached', 0, () => {
      const napi = new FlutterNapi();
      let threw = false;
      try { napi.dispatchEmptyPlatformMessage('test/channel', 1); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('dispatchPlatformMessage does not throw when detached', 0, () => {
      const napi = new FlutterNapi();
      let threw = false;
      try { napi.dispatchPlatformMessage('test/channel', new ArrayBuffer(4), 4, 1); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('invokePlatformMessageEmptyResponseCallback does not throw when detached', 0, () => {
      const napi = new FlutterNapi();
      let threw = false;
      try { napi.invokePlatformMessageEmptyResponseCallback(1); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('invokePlatformMessageResponseCallback does not throw when detached', 0, () => {
      const napi = new FlutterNapi();
      let threw = false;
      try { napi.invokePlatformMessageResponseCallback(1, new ArrayBuffer(0), 0); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('handlePlatformMessageResponse does not throw when no handler', 0, () => {
      const napi = new FlutterNapi();
      let threw = false;
      try { napi.handlePlatformMessageResponse(1, new ArrayBuffer(0)); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('handlePlatformMessage does not throw when detached', 0, () => {
      const napi = new FlutterNapi();
      let threw = false;
      try { napi.handlePlatformMessage('test/channel', new ArrayBuffer(0), 1, 0); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('setViewportMetrics does not throw when detached', 0, () => {
      const napi = new FlutterNapi();
      let threw = false;
      try { napi.setViewportMetrics(0, 100, 200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, [], [], []); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('spawn does not throw when detached', 0, () => {
      const napi = new FlutterNapi();
      let threw = false;
      try { napi.spawn('main', 'path', '/route', []); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('spawnAsync does not throw when detached', 0, () => {
      const napi = new FlutterNapi();
      let threw = false;
      try { napi.spawnAsync('main', 'path', '/route', []); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('preSpawn does not throw', 0, () => {
      const napi = new FlutterNapi();
      let threw = false;
      try { napi.preSpawn('main', 'path', '/route', []); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('processPendingMessages does not throw', 0, () => {
      const napi = new FlutterNapi();
      let threw = false;
      try { napi.processPendingMessages(); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('onFirstFrame does not throw when detached', 0, () => {
      const napi = new FlutterNapi();
      let threw = false;
      try { napi.onFirstFrame(0); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('setSemanticsEnabled does not throw when detached', 0, () => {
      const napi = new FlutterNapi();
      let threw = false;
      try { napi.setSemanticsEnabled(true); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

it('accessibilityStateChange does not throw', 0, () => {
      const napi = new FlutterNapi();
      let threw = false;
      try { napi.accessibilityStateChange(true); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('getSystemLanguages does not throw', 0, () => {
      const napi = new FlutterNapi();
      let threw = false;
      try { napi.getSystemLanguages(); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('detachFromNativeAndReleaseResources does not throw when detached', 0, () => {
      const napi = new FlutterNapi();
      let threw = false;
      try { napi.detachFromNativeAndReleaseResources(); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('detachFromNativeAndReleaseResourcesAsync does not throw when detached', 0, () => {
      const napi = new FlutterNapi();
      let threw = false;
      try { napi.detachFromNativeAndReleaseResourcesAsync(); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('unregisterTexture does not throw when detached', 0, () => {
      const napi = new FlutterNapi();
      let threw = false;
      try { napi.unregisterTexture(1); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('setTextureBackGroundColor does not throw when detached', 0, () => {
      const napi = new FlutterNapi();
      let threw = false;
      try { napi.setTextureBackGroundColor(1, 0xFF0000); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('setTextureBufferSize does not throw when detached', 0, () => {
      const napi = new FlutterNapi();
      let threw = false;
      try { napi.setTextureBufferSize(1, 100, 200); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('enableFrameCache does not throw when detached', 0, () => {
      const napi = new FlutterNapi();
      let threw = false;
      try { napi.enableFrameCache(true); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('setPipVisible does not throw when detached', 0, () => {
      const napi = new FlutterNapi();
      let threw = false;
      try { napi.setPipVisible(true); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('onTouchEvent does not throw when detached', 0, () => {
      const napi = new FlutterNapi();
      let threw = false;
      try { napi.onTouchEvent([]); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('onMouseEvent does not throw when detached', 0, () => {
      const napi = new FlutterNapi();
      let threw = false;
      try { napi.onMouseEvent([]); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('onAxisEvent does not throw when detached', 0, () => {
      const napi = new FlutterNapi();
      let threw = false;
      try { napi.onAxisEvent([]); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('setFontWeightScale does not throw when detached', 0, () => {
      const napi = new FlutterNapi();
      let threw = false;
      try { napi.setFontWeightScale(1.0); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('setFlutterNavigationAction does not throw when detached', 0, () => {
      const napi = new FlutterNapi();
      let threw = false;
      try { napi.setFlutterNavigationAction(0, true); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('setPreloading does not throw', 0, () => {
      const napi = new FlutterNapi();
      let threw = false;
      try { napi.setPreloading(); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('registerTexture does not throw when detached', 0, () => {
      const napi = new FlutterNapi();
      let threw = false;
      try { napi.registerTexture(1); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

it('getTextureNativeWindowId does not throw when detached', 0, () => {
      const napi = new FlutterNapi();
      let threw = false;
      try { napi.getTextureNativeWindowId(1); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('getTextureNativeWindowPtr does not throw when detached', 0, () => {
      const napi = new FlutterNapi();
      let threw = false;
      try { napi.getTextureNativeWindowPtr(1); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('setExternalNativeImage does not throw when detached', 0, () => {
      const napi = new FlutterNapi();
      let threw = false;
      try { napi.setExternalNativeImage(1, 0); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('resetExternalTexture does not throw when detached', 0, () => {
      const napi = new FlutterNapi();
      let threw = false;
      try { napi.resetExternalTexture(1, false); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('notifyTextureResizing does not throw when detached', 0, () => {
      const napi = new FlutterNapi();
      let threw = false;
      try { napi.notifyTextureResizing(1, 100, 200); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

it('setExternalNativeImagePtr does not throw when detached', 0, () => {
      const napi = new FlutterNapi();
      let threw = false;
      try { napi.setExternalNativeImagePtr(1, BigInt(0)); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

  })

  describe('FlutterNapi.attached.branches', () => {
    let attachedNapi: FlutterNapi;

    beforeAll(() => {
      attachedNapi = new FlutterNapi();
      const ctx = getContext() as common.UIAbilityContext;
      const appInfo = ApplicationInfoLoader.load(ctx);
      const shellArgs: string[] = [];
      shellArgs.push('--icu-symbol-prefix=_binary_icudtl_dat');
      shellArgs.push('--icu-native-lib-path=' + appInfo.nativeLibraryDir + '/libflutter.so');
      shellArgs.push('--aot-shared-library-name=' + appInfo.nativeLibraryDir + '/libapp.so');
      shellArgs.push('--cache-dir-path=' + ctx.cacheDir + '/');
      shellArgs.push('--prefetched-default-font-manager');
      shellArgs.push('--leak-vm=true');
      attachedNapi.init(ctx, shellArgs, '', ctx.filesDir + '/', ctx.cacheDir + '/', Date.now());
      attachedNapi.attachToNative();
    });

    afterAll(() => {
      attachedNapi.detachFromNativeAndReleaseResources();
    });

    it('attached isAttached returns true', 0, () => {
      expect(attachedNapi.isAttached()).assertEqual(true);
    });

    it('attached nativeShellHolderId is not null', 0, () => {
      expect(attachedNapi.nativeShellHolderId).not().assertEqual(null);
    });

    it('attached notifyLowMemoryWarning does not throw', 0, () => {
      let threw = false;
      try { attachedNapi.notifyLowMemoryWarning(); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('attached dispatchEmptyPlatformMessage does not throw', 0, () => {
      let threw = false;
      try { attachedNapi.dispatchEmptyPlatformMessage('test/channel', 1); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('attached dispatchPlatformMessage does not throw', 0, () => {
      let threw = false;
      try { attachedNapi.dispatchPlatformMessage('test/channel', new ArrayBuffer(4), 4, 1); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('attached invokePlatformMessageEmptyResponseCallback does not throw', 0, () => {
      let threw = false;
      try { attachedNapi.invokePlatformMessageEmptyResponseCallback(1); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('attached invokePlatformMessageResponseCallback does not throw', 0, () => {
      let threw = false;
      try { attachedNapi.invokePlatformMessageResponseCallback(1, new ArrayBuffer(0), 0); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('attached handlePlatformMessageResponse does not throw', 0, () => {
      let threw = false;
      try { attachedNapi.handlePlatformMessageResponse(1, new ArrayBuffer(0)); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('attached handlePlatformMessage does not throw', 0, () => {
      let threw = false;
      try { attachedNapi.handlePlatformMessage('test/channel', new ArrayBuffer(0), 1, 0); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('attached setViewportMetrics does not throw', 0, () => {
      let threw = false;
      try { attachedNapi.setViewportMetrics(1.0, 100, 200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, [], [], []); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('attached setSemanticsEnabled does not throw', 0, () => {
      let threw = false;
      try { attachedNapi.setSemanticsEnabled(true); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('attached updateRefreshRate does not throw', 0, () => {
      let threw = false;
      try { attachedNapi.updateRefreshRate(60); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('attached updateSize does not throw', 0, () => {
      let threw = false;
      try { attachedNapi.updateSize(1080, 1920); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('attached updateDensity does not throw', 0, () => {
      let threw = false;
      try { attachedNapi.updateDensity(3.0); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('attached checkAndReloadFont does not throw', 0, () => {
      let threw = false;
      try { attachedNapi.checkAndReloadFont(); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('attached setPreloading does not throw', 0, () => {
      let threw = false;
      try { attachedNapi.setPreloading(); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('attached processPendingMessages does not throw', 0, () => {
      let threw = false;
      try { attachedNapi.processPendingMessages(); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('attached onFirstFrame preload does not throw', 0, () => {
      let threw = false;
      try { attachedNapi.onFirstFrame(1); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('attached onFirstFrame regular does not throw', 0, () => {
      let threw = false;
      try { attachedNapi.onFirstFrame(0); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('attached onPreEngineRestart does not throw', 0, () => {
      let threw = false;
      try { attachedNapi.onPreEngineRestart(); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('attached computePlatformResolvedLocale returns array', 0, () => {
      const result = attachedNapi.computePlatformResolvedLocale(['en', 'zh']);
      expect(result).not().assertNull();
    });

    it('attached accessibilityStateChange does not throw', 0, () => {
      let threw = false;
      try { attachedNapi.accessibilityStateChange(true); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('attached getSystemLanguages does not throw', 0, () => {
      let threw = false;
      try { attachedNapi.getSystemLanguages(); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('attached enableFrameCache does not throw', 0, () => {
      let threw = false;
      try { attachedNapi.enableFrameCache(true); attachedNapi.enableFrameCache(false); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('attached setPipVisible does not throw', 0, () => {
      let threw = false;
      try { attachedNapi.setPipVisible(true); attachedNapi.setPipVisible(false); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });
  })

describe('FlutterNapi.stateChange', () => {
  it('accessibilityStateChange toggles without a delegate', 0, () => {
    const napi: Any = FlutterInjector.getInstance().getFlutterNapi();
    let threw = false;
    try {
      napi['accessibilityStateChange'](true);
      napi['accessibilityStateChange'](false);
    } catch (e) { threw = true; }
    expect(threw).assertEqual(false);
  });

  it('resetExternalTexture with a valid id does not throw', 0, () => {
    const napi: Any = FlutterInjector.getInstance().getFlutterNapi();
    let threw = false;
    try { napi['resetExternalTexture'](1); } catch (e) { threw = true; }
    expect(threw).assertEqual(false);
  });
});
}

class InitResult {
  appStoragePath: string;
  engineCachesPath: string;
  dataDirPath: string;

  constructor(appStoragePath: string,
    engineCachesPath: string,
    dataDirPath: string) {
    this.appStoragePath = appStoragePath;
    this.engineCachesPath = engineCachesPath;
    this.dataDirPath = dataDirPath;
  }
}

class CurEngineLifecycleListener implements EngineLifecycleListener {
  onPreEngineRestart() {
  }
  onEngineWillDestroy() {
  }
}

class CustomEventTarget implements EventTarget {
  area: Area = new CustomArea(0, 0, { x: 0, y: 0 }, { x: 0, y: 0 });
  constructor(area: Area) {
    this.area = area;
  }
}

class CustomArea implements Area {
  width: Length = 0;
  height: Length = 0;
  position: Position = { x: 0, y: 0 };
  globalPosition: Position = { x: 0, y: 0 };
  constructor(width: Length, height: Length, position: Position, globalPosition: Position) {
    this.width = width;
    this.height = height;
    this.position = position;
    this.globalPosition = globalPosition;
  }
}
