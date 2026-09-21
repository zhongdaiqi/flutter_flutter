/*
 * Copyright (C) 2026 Huawei Device Co., Ltd.
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

import { describe, expect, it } from '@ohos/hypium';
import PlatformPlugin from '../../../../main/ets/plugin/PlatformPlugin';
import {
  Brightness,
  SystemChromeStyle,
  SystemUiMode,
  SystemUiOverlay
} from '../../../../main/ets/embedding/engine/systemchannels/PlatformChannel';
import FlutterManager from '../../../../main/ets/embedding/ohos/FlutterManager';
import Any from '../../../../main/ets/plugin/common/Any';

/** Duck-typed PlatformChannel recording handler registration. */
class FakePluginChannel {
  handler: Any = undefined;
  setHandlerCount: number = 0;
  setPlatformMessageHandler(h: Any): void {
    this.handler = h;
    this.setHandlerCount++;
  }
}

/** Duck-typed main window recording system bar operations. */
class FakePluginWindow {
  barEnable: Array<string> = [];
  decorVisibleCalls: Array<boolean> = [];
  systemBarProps: Array<Any> = [];
  titleButtonHeight: number = 0;
  currentStatusBarColor: string = '#123456';
  getWindowSystemBarProperties(): Any {
    const p: Any = { statusBarColor: this.currentStatusBarColor, isStatusBarLightIcon: false, statusBarContentColor: '#654321' };
    return p;
  }
  setWindowSystemBarEnable(bars: Array<string>): void { this.barEnable = bars; }
  setWindowDecorVisible(visible: boolean): void { this.decorVisibleCalls.push(visible); }
  getTitleButtonRect(): Any { const r: Any = { height: this.titleButtonHeight }; return r; }
  setWindowSystemBarProperties(props: Any): void { this.systemBarProps.push(props); }
}

/** Duck-typed FlutterView recording padding calls. */
class FakePluginView {
  paddingTops: Array<number | undefined> = [];
  setPaddingTop(v?: number): void { this.paddingTops.push(v); }
}

/** Duck-typed MethodResult counting replies. */
class FakeMethodResult {
  successCount: number = 0;
  errorCount: number = 0;
  success(data: Any): void { this.successCount++; }
  error(code: string, message: string, details: Any): void { this.errorCount++; }
}

/** Duck-typed application context counting environment callbacks. */
class FakeAppContext {
  nextId: number = 7;
  onCount: number = 0;
  offCount: number = 0;
  on(event: string, cb: Any): number { this.onCount++; return this.nextId; }
  off(event: string, id: number): void { this.offCount++; }
}

/** Duck-typed UIAbility context recording mission label updates. */
class FakeAbilityContext {
  labels: Array<string> = [];
  setMissionLabel(label: string): Promise<void> {
    this.labels.push(label);
    return Promise.resolve();
  }
}

export default function PlatformPluginTest() {
  describe('PlatformPlugin.systemChrome', () => {
    const buildPlugin = (): PlatformPlugin => {
      const channel = new FakePluginChannel();
      const plugin = new PlatformPlugin(channel as Any, getContext());
      return plugin;
    };

    it('maps system UI overlays to status/navigation config', 0, () => {
      const plugin = buildPlugin();
      const win = new FakePluginWindow();
      (plugin.callback as Any).mainWindow = win;
      const overlays: Array<SystemUiOverlay> = [SystemUiOverlay.TOP_OVERLAYS, SystemUiOverlay.BOTTOM_OVERLAYS];
      (plugin.callback as Any).setSystemChromeEnabledSystemUIOverlays(overlays);
      expect(win.barEnable.length).assertEqual(2);
      expect(win.barEnable[0]).assertEqual('status');
      expect(win.barEnable[1]).assertEqual('navigation');
    });

    it('empty overlay list clears the config', 0, () => {
      const plugin = buildPlugin();
      const win = new FakePluginWindow();
      (plugin.callback as Any).mainWindow = win;
      (plugin.callback as Any).setSystemChromeEnabledSystemUIOverlays([]);
      expect(win.barEnable.length).assertEqual(0);
    });

    it('edge-to-edge mode enables both bars', 0, () => {
      const plugin = buildPlugin();
      const win = new FakePluginWindow();
      (plugin.callback as Any).mainWindow = win;
      (plugin.callback as Any).setSystemChromeEnabledSystemUIMode(SystemUiMode.EDGE_TO_EDGE);
      expect(win.barEnable.length).assertEqual(2);
      expect(win.barEnable[0]).assertEqual('status');
      expect(win.barEnable[1]).assertEqual('navigation');
    });

    it('lean-back mode drives full screen outside free window mode', 0, () => {
      const plugin = buildPlugin();
      const fm = FlutterManager.getInstance();
      const origMode: Any = (fm as Any).isInFreeMultiWindowMode;
      const origFull: Any = (fm as Any).setUseFullScreen;
      const origFree: Any = (fm as Any).setUseFullScreenForFreeWindow;
      let fullCalls = 0;
      let freeCalls = 0;
      (fm as Any).isInFreeMultiWindowMode = (ctx?: Any): boolean => false;
      (fm as Any).setUseFullScreen = (use: boolean, ctx?: Any): void => { fullCalls++; };
      (fm as Any).setUseFullScreenForFreeWindow = (use: boolean, ctx?: Any): void => { freeCalls++; };
      try {
        (plugin.callback as Any).setSystemChromeEnabledSystemUIMode(SystemUiMode.LEAN_BACK);
        expect(fullCalls).assertEqual(1);
        expect(freeCalls).assertEqual(0);
      } finally {
        (fm as Any).isInFreeMultiWindowMode = origMode;
        (fm as Any).setUseFullScreen = origFull;
        (fm as Any).setUseFullScreenForFreeWindow = origFree;
      }
    });

    it('lean-back mode uses the free window path inside multi-window mode', 0, () => {
      const plugin = buildPlugin();
      const fm = FlutterManager.getInstance();
      const origMode: Any = (fm as Any).isInFreeMultiWindowMode;
      const origFree: Any = (fm as Any).setUseFullScreenForFreeWindow;
      let freeCalls = 0;
      (fm as Any).isInFreeMultiWindowMode = (ctx?: Any): boolean => true;
      (fm as Any).setUseFullScreenForFreeWindow = (use: boolean, ctx?: Any): void => { freeCalls++; };
      try {
        (plugin.callback as Any).setSystemChromeEnabledSystemUIMode(SystemUiMode.IMMERSIVE);
        expect(freeCalls).assertEqual(1);
      } finally {
        (fm as Any).isInFreeMultiWindowMode = origMode;
        (fm as Any).setUseFullScreenForFreeWindow = origFree;
      }
    });

    it('unknown system UI mode returns without touching the window', 0, () => {
      const plugin = buildPlugin();
      const win = new FakePluginWindow();
      (plugin.callback as Any).mainWindow = win;
      (plugin.callback as Any).setSystemChromeEnabledSystemUIMode(999 as Any as SystemUiMode);
      expect(win.barEnable.length).assertEqual(0);
      expect(win.systemBarProps.length).assertEqual(0);
    });

    it('overlay style maps dark icons and status bar color', 0, () => {
      const plugin = buildPlugin();
      const win = new FakePluginWindow();
      (plugin.callback as Any).mainWindow = win;
      const style: Any = { statusBarIconBrightness: Brightness.DARK, statusBarColor: 0xff112233 };
      (plugin.callback as Any).setSystemChromeSystemUIOverlayStyle(style as Any as SystemChromeStyle);
      expect(win.systemBarProps.length).assertEqual(1);
      expect((win.systemBarProps[0] as Any).statusBarContentColor).assertEqual('#000000');
      expect((win.systemBarProps[0] as Any).isStatusBarLightIcon).assertEqual(false);
      expect((win.systemBarProps[0] as Any).statusBarColor).assertEqual('#ff112233');
    });

    it('overlay style maps light icons and falls back to window props', 0, () => {
      const plugin = buildPlugin();
      const win = new FakePluginWindow();
      (plugin.callback as Any).mainWindow = win;
      const style: Any = { statusBarIconBrightness: Brightness.LIGHT };
      (plugin.callback as Any).setSystemChromeSystemUIOverlayStyle(style as Any as SystemChromeStyle);
      expect((win.systemBarProps[0] as Any).statusBarContentColor).assertEqual('#FFFFFF');
      expect((win.systemBarProps[0] as Any).isStatusBarLightIcon).assertEqual(true);
      // No explicit color: falls back to the current window properties.
      expect((win.systemBarProps[0] as Any).statusBarColor).assertEqual('#123456');
    });

    it('updateSystemUiOverlays pads the view when decoration is hidden', 0, () => {
      const plugin = buildPlugin();
      const win = new FakePluginWindow();
      win.titleButtonHeight = 30;
      const view = new FakePluginView();
      (plugin.callback as Any).mainWindow = win;
      (plugin.callback as Any).flutterView = view;
      (plugin.callback as Any).showBarOrNavigation = ['navigation'];
      const fm = FlutterManager.getInstance();
      const orig: Any = (fm as Any).isWindowDecorSafeAreaAvoidSupported;
      (fm as Any).isWindowDecorSafeAreaAvoidSupported = (ctx?: Any): boolean => true;
      try {
        plugin.updateSystemUiOverlays();
        expect(win.decorVisibleCalls.length).assertEqual(1);
        expect(win.decorVisibleCalls[0]).assertEqual(false);
        expect(view.paddingTops.length).assertEqual(1);
        expect(view.paddingTops[0]).assertEqual(vp2px(30));
      } finally {
        (fm as Any).isWindowDecorSafeAreaAvoidSupported = orig;
      }
    });

    it('updateSystemUiOverlays clears padding when decoration stays visible', 0, () => {
      const plugin = buildPlugin();
      const win = new FakePluginWindow();
      const view = new FakePluginView();
      (plugin.callback as Any).mainWindow = win;
      (plugin.callback as Any).flutterView = view;
      (plugin.callback as Any).showBarOrNavigation = ['status'];
      const fm = FlutterManager.getInstance();
      const orig: Any = (fm as Any).isWindowDecorSafeAreaAvoidSupported;
      (fm as Any).isWindowDecorSafeAreaAvoidSupported = (ctx?: Any): boolean => true;
      try {
        plugin.updateSystemUiOverlays();
        expect(win.decorVisibleCalls[0]).assertEqual(true);
        expect(view.paddingTops[0]).assertEqual(undefined);
      } finally {
        (fm as Any).isWindowDecorSafeAreaAvoidSupported = orig;
      }
    });

    it('a stored theme is re-applied on overlay updates', 0, () => {
      const plugin = buildPlugin();
      const win = new FakePluginWindow();
      (plugin.callback as Any).mainWindow = win;
      const style: Any = { statusBarIconBrightness: 0 };
      (plugin.callback as Any).setSystemChromeSystemUIOverlayStyle(style as Any as SystemChromeStyle);
      const before = win.systemBarProps.length;
      plugin.updateSystemUiOverlays();
      expect(win.systemBarProps.length).assertEqual(before + 1);
    });

    it('destroy unregisters the environment callback exactly once', 0, () => {
      const plugin = buildPlugin();
      const appCtx = new FakeAppContext();
      const channel = new FakePluginChannel();
      (plugin.callback as Any).applicationContext = appCtx;
      (plugin.callback as Any).platformChannel = channel;
      (plugin.callback as Any).callbackId = 5;
      plugin.destroy();
      expect(appCtx.offCount).assertEqual(1);
      expect((plugin.callback as Any).callbackId).assertNull();
      expect(channel.setHandlerCount).assertEqual(1);
      expect(channel.handler).assertNull();
      // A second destroy must not unregister again.
      plugin.destroy();
      expect(appCtx.offCount).assertEqual(1);
    });

    it('setSystemChromeChangeListener registers once and tolerates null context', 0, () => {
      const plugin = buildPlugin();
      const appCtx = new FakeAppContext();
      (plugin.callback as Any).applicationContext = appCtx;
      plugin.setSystemChromeChangeListener();
      expect((plugin.callback as Any).callbackId).assertEqual(7);
      plugin.setSystemChromeChangeListener();
      expect(appCtx.onCount).assertEqual(1);
      const fresh = buildPlugin();
      (fresh.callback as Any).applicationContext = null;
      let threw = false;
      try { fresh.setSystemChromeChangeListener(); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('setPreferredOrientations reports success and errors', 0, () => {
      const plugin = buildPlugin();
      const errOk: Any = { code: 0 };
      const errBad: Any = { code: 1001 };
      const win: Any = {
        setPreferredOrientation: (o: number, cb: (err: Any) => void): void => { cb(win.nextErr); },
        nextErr: errOk
      };
      (plugin.callback as Any).mainWindow = win;
      const ok = new FakeMethodResult();
      (plugin.callback as Any).setPreferredOrientations(1, ok as Any);
      expect(ok.successCount).assertEqual(1);
      expect(ok.errorCount).assertEqual(0);
      win.nextErr = errBad;
      const bad = new FakeMethodResult();
      (plugin.callback as Any).setPreferredOrientations(2, bad as Any);
      expect(bad.errorCount).assertEqual(1);
      // Missing window throws inside and lands in the error path.
      (plugin.callback as Any).mainWindow = null;
      const noWin = new FakeMethodResult();
      (plugin.callback as Any).setPreferredOrientations(3, noWin as Any);
      expect(noWin.errorCount).assertEqual(1);
    });

    it('popSystemNavigator is consumed by a requesting delegate', 0, () => {
      const plugin = buildPlugin();
      let popped = 0;
      const delegate: Any = { popSystemNavigator: (): boolean => { popped++; return true; } };
      (plugin.callback as Any).platformPluginDelegate = delegate;
      (plugin.callback as Any).popSystemNavigator();
      expect(popped).assertEqual(1);
    });

    it('setApplicationSwitcherDescription forwards the label', 0, () => {
      const plugin = buildPlugin();
      const abilityCtx = new FakeAbilityContext();
      (plugin.callback as Any).uiAbilityContext = abilityCtx;
      const desc: Any = { label: 'mission' };
      (plugin.callback as Any).setApplicationSwitcherDescription(desc as Any);
      expect(abilityCtx.labels.length).assertEqual(1);
      expect(abilityCtx.labels[0]).assertEqual('mission');
    });

    it('clipboardHasStrings reports no strings', 0, () => {
      const plugin = buildPlugin();
      expect((plugin.callback as Any).clipboardHasStrings()).assertEqual(false);
    });
  });
}
