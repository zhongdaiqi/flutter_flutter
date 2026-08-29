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
import { beforeAll, describe, expect, it } from '@ohos/hypium';
import { window } from '@kit.ArkUI';
import common from '@ohos.app.ability.common';
import { Context } from '@kit.AbilityKit';
import Any from '../../../../../main/ets/plugin/common/Any';
import FlutterManager, { FullScreenListener, DragDropCallback } from '../../../../../main/ets/embedding/ohos/FlutterManager';

function sleep(time: number) {
  return new Promise<void>((resolve: Function) => setTimeout(resolve, time));
}

const flutterManager: FlutterManager = FlutterManager.getInstance();
const uiAbility = flutterManager.getUIAbility(getContext());

export default function FlutterManagerTest() {
  describe('FlutterManagerTest', () => {
    beforeAll(async () => {
      // Skip beforeAll setup in JsUnit env (uiAbility is null when not in
      // a UIAbility lifecycle). The it() tests below don't depend on
      // beforeAll setup succeeding.
      if (uiAbility === null || uiAbility === undefined) {
        return;
      }
      const windowStage = flutterManager.getWindowStage(uiAbility);
      await sleep(1000);
      flutterManager.pushWindowStage(uiAbility, windowStage);
      await sleep(1000);
      flutterManager.popWindowStage(uiAbility);
      await sleep(1000);
      flutterManager.pushUIAbility(uiAbility);
      await sleep(1000);
      flutterManager.popUIAbility(uiAbility);

    })

    it('TestGetFlutterViewList', 0, async (done: Function) => {
      const result = flutterManager.getFlutterViewList();
      expect(result).not().assertNull();
      done();
    })

    it('TestSetFullScreenListener', 0, async (done: Function) => {
      class MyFullScreenListener implements FullScreenListener {
        useFullScreen(): boolean {
          return true;
        }

        setUseFullScreen(useFullScreen: boolean): void {
          console.info("uitest: setUseFullScreen useFullScreen " + useFullScreen);
        }

        setUseFullScreenForFreeWindow(useFullScreen: boolean): void {
          console.info("uitest: setUseFullScreenForFreeWindow useFullScreen " + useFullScreen);
        }

        onScreenStateChanged(data: window.WindowStatusType): void {
          console.info("uitest: onScreenStateChanged");
        }
      }

      const listener: FullScreenListener = new MyFullScreenListener();
      flutterManager.setFullScreenListener(listener);
      await sleep(1000);
      const result = flutterManager.getFullScreenListener();
      expect(result).not().assertNull();
      done();
    })

    it('TestFullScreen', 0, async (done: Function) => {
      const result = flutterManager.useFullScreen();
      expect(result).assertTrue();
      flutterManager.setUseFullScreen(result);
      flutterManager.clear();
      done();
    })

    it('TestSetUseFullScreenForFreeWindow', 0, (done: Function) => {
      class RecordingFullScreenListener implements FullScreenListener {
        freeWindowArg: boolean = false;
        callCount: number = 0;

        useFullScreen(): boolean {
          return true;
        }

        setUseFullScreen(useFullScreen: boolean): void {
        }

        setUseFullScreenForFreeWindow(useFullScreen: boolean): void {
          this.freeWindowArg = useFullScreen;
          this.callCount = this.callCount + 1;
        }

        onScreenStateChanged(data: window.WindowStatusType): void {
        }
      }

      const listener = new RecordingFullScreenListener();
      flutterManager.setFullScreenListener(listener);

      flutterManager.setUseFullScreenForFreeWindow(true, null);
      expect(listener.callCount).assertEqual(1);
      expect(listener.freeWindowArg).assertTrue();

      flutterManager.setUseFullScreenForFreeWindow(false, null);
      expect(listener.callCount).assertEqual(2);
      expect(listener.freeWindowArg).assertEqual(false);
      done();
    })

    it('TestIsInFreeWindowModeSupported', 0, (done: Function) => {
      const result = flutterManager.isInFreeWindowModeSupported(null);
      expect(result === true || result === false).assertTrue();
      done();
    })

    it('TestIsInFreeMultiWindowMode', 0, (done: Function) => {
      const result = flutterManager.isInFreeMultiWindowMode(null);
      expect(result === true || result === false).assertTrue();
      done();
    })

    it('TestDragCallbacksAccessors', 0, async (done: Function) => {
      const enterCbs = flutterManager.getDragEnterCbs();
      const moveCbs = flutterManager.getDragMoveCbs();
      const leaveCbs = flutterManager.getDragLeaveCbs();
      const dropCbs = flutterManager.getDropCbs();
      expect(enterCbs).not().assertNull();
      expect(moveCbs).not().assertNull();
      expect(leaveCbs).not().assertNull();
      expect(dropCbs).not().assertNull();
      done();
    })

    it('TestAddRemoveDragCallbacks', 0, async (done: Function) => {
      const cb: DragDropCallback = new DragDropCallbackImpl();
      const enterId = flutterManager.addDragEnterCb(cb);
      const moveId = flutterManager.addDragMoveCb(cb);
      const leaveId = flutterManager.addDragLeaveCb(cb);
      const dropId = flutterManager.addDropCb(cb);
      flutterManager.removeDragEnterCb(enterId);
      flutterManager.removeDragMoveCb(moveId);
      flutterManager.removeDragLeaveCb(leaveId);
      flutterManager.removeDropCb(dropId);
      done();
    })

    it('TestHasFlutterView', 0, async (done: Function) => {
      const result = flutterManager.hasFlutterView('non-existent-view');
      expect(result).assertFalse();
      done();
    })

    it('TestGetFlutterViewById', 0, async (done: Function) => {
      const view = flutterManager.getFlutterView('non-existent-view');
      expect(view).assertNull();
      done();
    })

    it('TestDeleteFlutterView', 0, async (done: Function) => {
      let threw = false;
      try { flutterManager.deleteFlutterView('non-existent'); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
      done();
    })

    it('TestGetUIAbility with no context', 0, () => {
      const ability = flutterManager.getUIAbility();
      expect(ability).not().assertNull();
    })

    it('TestGetUIAbility with context', 0, () => {
      const ctx = getContext();
      const ability = flutterManager.getUIAbility(ctx);
      expect(ability).not().assertNull();
    })

    it('TestGetWindowId does not throw', 0, () => {
      const ctx = getContext();
      let threw = false;
      try { flutterManager.getWindowId(getContext()); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    })

    it('TestGetFlutterViewList is not null', 0, () => {
      const list = flutterManager.getFlutterViewList();
      expect(list).not().assertNull();
    })

    it('TestGetNextFlutterViewId returns string', 0, () => {
      const id = flutterManager.getNextFlutterViewId();
      expect(typeof id).assertEqual('string');
    })

    it('TestSetSpecificSystemBarEnabled does not throw with non-existent view', 0, () => {
      let threw = false;
      try {
        flutterManager.setSpecificSystemBarEnabled('non-existent', 'status', true);
      } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    })

    it('TestHandleWindowDecorSafeArea does not throw', 0, () => {
      const ctx = getContext();
      let threw = false;
      try {
        flutterManager.handleWindowDecorSafeArea('non-existent', ctx);
      } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    })

    it('TestSetFullScreenChangeListener does not throw', 0, () => {
      let threw = false;
      try {
        const listener: FullScreenListener = new TestFullScreenListener();
        flutterManager.setFullScreenListener(listener);
      } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    })

    it('TestPopUIAbility does not throw', 0, () => {
      let threw = false;
      try { const ctx = getContext();
      const ability = flutterManager.getUIAbility(ctx);
      if (ability) { flutterManager.popUIAbility(ability); } } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    })

    it('TestIsWindowDecorSafeAreaAvoidSupported does not throw', 0, () => {
      const ctx = getContext();
      let threw = false;
      try { flutterManager.isWindowDecorSafeAreaAvoidSupported(ctx); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    })
  })

  // ===== Supplement (2026-08-29): registry and window-chain behaviour =====
  describe('FlutterManager.registriesAndWindowChain', () => {
    it('push/get/pop UIAbility keeps the list consistent', 0, () => {
      const fm = FlutterManager.getInstance();
      const a1: Any = { context: 'ctx-a' };
      const a2: Any = { context: 'ctx-b' };
      fm.pushUIAbility(a1 as Any);
      fm.pushUIAbility(a2 as Any);
      try {
        expect(fm.getUIAbility()).assertEqual(a1 as Any);
        expect(fm.getUIAbility('ctx-b' as Any as Context)).assertEqual(a2 as Any);
        // Popping an ability that was never pushed leaves the list untouched.
        const stranger: Any = { context: 'ctx-x' };
        fm.popUIAbility(stranger as Any);
        expect((fm as Any).uiAbilityList.length).assertEqual(2);
        fm.popUIAbility(a1 as Any);
        expect((fm as Any).uiAbilityList.length).assertEqual(1);
        expect(fm.getUIAbility()).assertEqual(a2 as Any);
      } finally {
        fm.popUIAbility(a2 as Any);
      }
    });

    it('pushWindowStage registers the pip listener once per ability', 0, () => {
      const fm = FlutterManager.getInstance();
      const ability: Any = { context: 'pip-ctx' };
      const stage = new FakeManagerWindowStage();
      fm.pushWindowStage(ability as Any, stage as Any);
      try {
        expect(stage.onCount).assertEqual(1);
        expect(stage.capturedEvent).assertEqual('windowStageEvent');
        // Re-pushing the same ability does not register a second listener.
        fm.pushWindowStage(ability as Any, stage as Any);
        expect(stage.onCount).assertEqual(1);
        // The stage lookup returns the pushed instance.
        expect(fm.getWindowStage(ability as Any)).assertEqual(stage as Any);
        // Dispatching a shown/hidden event through the captured callback is safe.
        if (stage.capturedCallback !== undefined) {
          (stage.capturedCallback as (e: number) => void)(1);
        }
      } finally {
        fm.popWindowStage(ability as Any);
      }
      expect(stage.offCount).assertEqual(1);
    });

    it('popWindowStage without a listener is a no-op', 0, () => {
      const fm = FlutterManager.getInstance();
      const ability: Any = { context: 'pip-none' };
      let threw = false;
      try { fm.popWindowStage(ability as Any); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('putFlutterView stores and deletes entries', 0, () => {
      const fm = FlutterManager.getInstance();
      const view: Any = { marker: 'v1' };
      (fm as Any).putFlutterView('fm-key-1', view);
      expect(fm.hasFlutterView('fm-key-1')).assertEqual(true);
      expect(fm.getFlutterView('fm-key-1')).assertEqual(view as Any);
      expect(fm.getFlutterViewList().has('fm-key-1')).assertEqual(true);
      (fm as Any).putFlutterView('fm-key-1', null);
      expect(fm.hasFlutterView('fm-key-1')).assertEqual(false);
      expect(fm.getFlutterView('fm-key-1')).assertNull();
    });

    it('getWindowId walks the ability-stage-window chain', 0, () => {
      const fm = FlutterManager.getInstance();
      const ability: Any = { context: 'wid-ctx' };
      const win = new FakeManagerWindow();
      win.propertiesId = 33;
      const stage = new FakeManagerWindowStage();
      stage.mainWindow = win;
      fm.pushUIAbility(ability as Any);
      fm.pushWindowStage(ability as Any, stage as Any);
      try {
        expect(fm.getWindowId('wid-ctx' as Any as common.Context)).assertEqual(33);
      } finally {
        fm.popWindowStage(ability as Any);
        fm.popUIAbility(ability as Any);
      }
      // Missing chain entries fall back to 0 without throwing.
      expect(fm.getWindowId('wid-ctx' as Any as common.Context)).assertEqual(0);
    });

    it('setSpecificSystemBarEnabled applies avoid-area padding', 0, () => {
      const fm = FlutterManager.getInstance();
      const ability: Any = { context: 'bar-ctx' };
      const win = new FakeManagerWindow();
      const stage = new FakeManagerWindowStage();
      stage.mainWindow = win;
      const view = new FakeManagerView();
      (fm as Any).putFlutterView('bar-view', view);
      fm.pushUIAbility(ability as Any);
      fm.pushWindowStage(ability as Any, stage as Any);
      try {
        win.systemTop = 36;
        fm.setSpecificSystemBarEnabled('bar-view', 'status', false, true, 'bar-ctx' as Any as Context);
        expect(view.paddingTops.length).assertEqual(1);
        expect(view.paddingTops[0]).assertEqual(36);
        expect(win.lastBarArgs.length).assertEqual(3);
        expect(win.lastBarArgs[0]).assertEqual('status');
        expect(win.lastBarArgs[1]).assertEqual(false);
        // Zero-height avoid area does not touch padding again.
        win.systemTop = 0;
        view.paddingTops = [];
        fm.setSpecificSystemBarEnabled('bar-view', 'status', true, undefined, 'bar-ctx' as Any as Context);
        expect(view.paddingTops.length).assertEqual(0);
        // Navigation indicator path pads the bottom.
        win.navBottom = 24;
        fm.setSpecificSystemBarEnabled('bar-view', 'navigationIndicator', false, undefined, 'bar-ctx' as Any as Context);
        expect(view.paddingBottoms.length).assertEqual(1);
        expect(view.paddingBottoms[0]).assertEqual(24);
      } finally {
        fm.popWindowStage(ability as Any);
        fm.popUIAbility(ability as Any);
        (fm as Any).putFlutterView('bar-view', null);
      }
    });

    it('setSpecificSystemBarEnabled with unknown view returns early', 0, () => {
      const fm = FlutterManager.getInstance();
      let threw = false;
      try { fm.setSpecificSystemBarEnabled('no-such-view', 'status', true); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('handleWindowDecorSafeArea pads by title button height when hidden', 0, () => {
      const fm = FlutterManager.getInstance();
      const ability: Any = { context: 'decor-ctx' };
      const win = new FakeManagerWindow();
      win.decorVisible = false;
      win.titleButtonHeight = 30;
      const stage = new FakeManagerWindowStage();
      stage.mainWindow = win;
      const view = new FakeManagerView();
      (fm as Any).putFlutterView('decor-view', view);
      fm.pushUIAbility(ability as Any);
      fm.pushWindowStage(ability as Any, stage as Any);
      const original: Any = (fm as Any).isWindowDecorSafeAreaAvoidSupported;
      (fm as Any).isWindowDecorSafeAreaAvoidSupported = (ctx?: Context): boolean => true;
      try {
        fm.handleWindowDecorSafeArea('decor-view', 'decor-ctx' as Any as Context);
        expect(view.paddingTops.length).assertEqual(1);
        expect(view.paddingTops[0]).assertEqual(vp2px(30));
        // Visible decoration clears the padding instead.
        win.decorVisible = true;
        view.paddingTops = [];
        fm.handleWindowDecorSafeArea('decor-view', 'decor-ctx' as Any as Context);
        expect(view.paddingTops.length).assertEqual(1);
        expect(view.paddingTops[0]).assertEqual(0);
        // Hidden title buttons also clear the padding.
        win.decorVisible = false;
        win.titleButtonHeight = 0;
        view.paddingTops = [];
        fm.handleWindowDecorSafeArea('decor-view', 'decor-ctx' as Any as Context);
        expect(view.paddingTops[0]).assertEqual(0);
      } finally {
        (fm as Any).isWindowDecorSafeAreaAvoidSupported = original;
        fm.popWindowStage(ability as Any);
        fm.popUIAbility(ability as Any);
        (fm as Any).putFlutterView('decor-view', null);
      }
    });

    it('handleWindowDecorSafeArea skips when unsupported or view missing', 0, () => {
      const fm = FlutterManager.getInstance();
      let threw = false;
      try {
        fm.handleWindowDecorSafeArea('no-such-view');
      } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('isInFreeWindowModeSupported reflects the window chain', 0, () => {
      const fm = FlutterManager.getInstance();
      const ability: Any = { context: 'free-ctx' };
      const win = new FakeManagerWindow();
      win.freeWindowMode = (): boolean => true;
      const stage = new FakeManagerWindowStage();
      stage.mainWindow = win;
      fm.pushUIAbility(ability as Any);
      fm.pushWindowStage(ability as Any, stage as Any);
      try {
        expect(fm.isInFreeWindowModeSupported('free-ctx' as Any as Context)).assertEqual(true);
        expect(fm.isInFreeMultiWindowMode('free-ctx' as Any as Context)).assertEqual(true);
      } finally {
        fm.popWindowStage(ability as Any);
        fm.popUIAbility(ability as Any);
      }
      // Without a registered chain both checks fall back to false.
      expect(fm.isInFreeWindowModeSupported('free-ctx' as Any as Context)).assertEqual(false);
      expect(fm.isInFreeMultiWindowMode('free-ctx' as Any as Context)).assertEqual(false);
    });
  })
}

class DragDropCallbackImpl implements DragDropCallback {
  do(event: Object, extraParams: string): void {
    // no-op
  }
}
class TestFullScreenListener implements FullScreenListener {
  useFullScreen(): boolean { return false; }
  setUseFullScreen(_useFullScreen: boolean, _context?: Context | null | undefined): void {}
  setUseFullScreenForFreeWindow(_useFullScreen: boolean, _context?: Context | null | undefined): void {}
  onScreenStateChanged(_data: window.WindowStatusType): void {}
}

/** Duck-typed WindowStage recording pip listener registration. */
class FakeManagerWindowStage {
  onCount: number = 0;
  offCount: number = 0;
  capturedEvent: string = '';
  capturedCallback: Any = undefined;
  mainWindow: FakeManagerWindow | null = null;
  on(event: string, callback: (e: number) => void): void {
    this.onCount++;
    this.capturedEvent = event;
    this.capturedCallback = callback;
  }
  off(event: string, callback: (e: number) => void): void { this.offCount++; }
  getMainWindowSync(): FakeManagerWindow | null { return this.mainWindow; }
}

/** Duck-typed main window recording system-bar operations. */
class FakeManagerWindow {
  propertiesId: number = 0;
  systemTop: number = 0;
  navBottom: number = 0;
  decorVisible: boolean = false;
  titleButtonHeight: number = 0;
  lastBarArgs: Array<Any> = [];
  freeWindowMode: (() => boolean) | null = null;
  getWindowProperties(): Any { const p: Any = { id: this.propertiesId }; return p; }
  setSpecificSystemBarEnabled(bar: string, visible: boolean, animation?: boolean): void {
    this.lastBarArgs = [bar, visible, animation];
  }
  getWindowAvoidArea(type: number): Any {
    const top: Any = { height: this.systemTop };
    const bottom: Any = { height: this.navBottom };
    const a: Any = { topRect: top, bottomRect: bottom };
    return a;
  }
  getWindowStatus(): number { return 3; }
  getWindowDecorVisible(): boolean { return this.decorVisible; }
  getTitleButtonRect(): Any { const r: Any = { height: this.titleButtonHeight }; return r; }
  isInFreeWindowMode(): boolean { return this.freeWindowMode !== null && this.freeWindowMode(); }
}

/** Duck-typed FlutterView recording padding calls. */
class FakeManagerView {
  paddingTops: Array<number> = [];
  paddingBottoms: Array<number> = [];
  setPaddingTop(v: number): void { this.paddingTops.push(v); }
  setPaddingBottom(v: number): void { this.paddingBottoms.push(v); }
}
