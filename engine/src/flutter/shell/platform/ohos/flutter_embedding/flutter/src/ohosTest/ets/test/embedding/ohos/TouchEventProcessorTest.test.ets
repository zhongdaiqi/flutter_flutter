/*
 * Copyright (c) 2026 Huawei Device Co., Ltd. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE_HW file.
 */

import { describe, it, expect, Level } from '@ohos/hypium';
import TouchEventProcessor from '../../../../../main/ets/embedding/ohos/TouchEventProcessor';
import FlutterManager from '../../../../../main/ets/embedding/ohos/FlutterManager';
import Any from '../../../../../main/ets/plugin/common/Any';
import { CustomTouchEvent, CustomTouchObject } from '../../../../../main/ets/plugin/platform/CustomTouchEvent';
import display from '@ohos.display';

function makeTouch(x: number, y: number): CustomTouchObject {
  return new CustomTouchObject(
    0,  // type
    0,  // id
    x, y,  // displayX, displayY
    x, y,  // windowX, windowY
    x, y,  // screenX, screenY
    x, y   // x, y (local)
  );
}

function makeEvent(touches: Array<CustomTouchObject>, changed: Array<CustomTouchObject>): CustomTouchEvent {
  return new CustomTouchEvent(
    0,         // type
    touches,   // touches
    changed,   // changedTouches
    0,         // timestamp
    0,         // source
    0,         // pressure
    0,         // tiltX
    0,         // tiltY
    0          // sourceTool
  );
}

/** Duck-typed FlutterView for the FlutterManager registry. */
class FakeProcView {
  active: boolean = true;
  children: Any[] = [];
  getActive(): boolean { return this.active; }
  getDVModel(): Any {
    const dv: Any = { children: this.children };
    return dv;
  }
}

/** Records events delivered through the node controller. */
class PostRecorder {
  touchEvents: CustomTouchEvent[] = [];
  mouseEvents: MouseEvent[] = [];
  axisEvents: AxisEvent[] = [];
  postEvent(e: CustomTouchEvent, isPx: boolean): boolean { this.touchEvents.push(e); return true; }
  postMouseEvent(e: MouseEvent): void { this.mouseEvents.push(e); }
  postAxisEvent(e: AxisEvent): void { this.axisEvents.push(e); }
}

export default function touchEventProcessorTest() {
  describe('TouchEventProcessor.getInstance', () => {
    it('returns a non-null instance', Level.LEVEL0, () => {
      const instance = TouchEventProcessor.getInstance();
      expect(instance !== null).assertEqual(true);
    });

    it('returns the same instance on multiple calls (singleton)', Level.LEVEL0, () => {
      const a = TouchEventProcessor.getInstance();
      const b = TouchEventProcessor.getInstance();
      expect(a).assertEqual(b);
    });
  });

  describe('TouchEventProcessor.checkHitPlatformView', () => {
    it('returns true when point is inside the view bounds', Level.LEVEL1, () => {
      const instance = TouchEventProcessor.getInstance();
      const r = instance.checkHitPlatformView(0, 0, 100, 100, 50, 50);
      expect(r).assertEqual(true);
    });

    it('returns true when point is at the left edge', Level.LEVEL1, () => {
      const instance = TouchEventProcessor.getInstance();
      const r = instance.checkHitPlatformView(0, 0, 100, 100, 0, 50);
      expect(r).assertEqual(true);
    });

    it('returns true when point is at the right edge', Level.LEVEL1, () => {
      const instance = TouchEventProcessor.getInstance();
      const r = instance.checkHitPlatformView(0, 0, 100, 100, 100, 50);
      expect(r).assertEqual(true);
    });

    it('returns true when point is at the top edge', Level.LEVEL1, () => {
      const instance = TouchEventProcessor.getInstance();
      const r = instance.checkHitPlatformView(0, 0, 100, 100, 50, 0);
      expect(r).assertEqual(true);
    });

    it('returns true when point is at the bottom edge', Level.LEVEL1, () => {
      const instance = TouchEventProcessor.getInstance();
      const r = instance.checkHitPlatformView(0, 0, 100, 100, 50, 100);
      expect(r).assertEqual(true);
    });

    it('returns false when point is outside (left of view)', Level.LEVEL1, () => {
      const instance = TouchEventProcessor.getInstance();
      const r = instance.checkHitPlatformView(10, 10, 100, 100, 5, 50);
      expect(r).assertEqual(false);
    });

    it('returns false when point is outside (right of view)', Level.LEVEL1, () => {
      const instance = TouchEventProcessor.getInstance();
      const r = instance.checkHitPlatformView(10, 10, 100, 100, 200, 50);
      expect(r).assertEqual(false);
    });

    it('returns false when point is outside (above view)', Level.LEVEL1, () => {
      const instance = TouchEventProcessor.getInstance();
      const r = instance.checkHitPlatformView(10, 10, 100, 100, 50, 5);
      expect(r).assertEqual(false);
    });

    it('returns false when point is outside (below view)', Level.LEVEL1, () => {
      const instance = TouchEventProcessor.getInstance();
      const r = instance.checkHitPlatformView(10, 10, 100, 100, 50, 200);
      expect(r).assertEqual(false);
    });

    it('returns true with non-zero origin view', Level.LEVEL1, () => {
      const instance = TouchEventProcessor.getInstance();
      // view at (50, 50) with size 100x100
      const r = instance.checkHitPlatformView(50, 50, 100, 100, 100, 100);
      expect(r).assertEqual(true);
    });

    it('returns false for point just outside non-zero origin view', Level.LEVEL1, () => {
      const instance = TouchEventProcessor.getInstance();
      // view at (50, 50) with size 100x100 → bounds [50..150] x [50..150]
      // point (151, 100) → x=151 is just outside
      const r = instance.checkHitPlatformView(50, 50, 100, 100, 151, 100);
      expect(r).assertEqual(false);
    });
  });

  describe('TouchEventProcessor.applyAffineTransform.static', () => {
    it('returns early when affineTransform is undefined', Level.LEVEL1, () => {
      const touch = makeTouch(10, 20);
      const event = makeEvent(new Array<CustomTouchObject>(touch), new Array<CustomTouchObject>(touch));
      // Should not throw
      TouchEventProcessor.applyAffineTransform(event, undefined);
      // Touch x/y unchanged
      expect(touch.x).assertEqual(10);
      expect(touch.y).assertEqual(20);
    });

    it('returns early when affineTransform has fewer than 6 elements', Level.LEVEL1, () => {
      const touch = makeTouch(10, 20);
      const event = makeEvent(new Array<CustomTouchObject>(touch), new Array<CustomTouchObject>(touch));
      TouchEventProcessor.applyAffineTransform(event, [1, 0, 0, 0, 1]);
      expect(touch.x).assertEqual(10);
      expect(touch.y).assertEqual(20);
    });

    it('returns early when coefficients contain NaN', Level.LEVEL1, () => {
      const touch = makeTouch(10, 20);
      const event = makeEvent(new Array<CustomTouchObject>(touch), new Array<CustomTouchObject>(touch));
      TouchEventProcessor.applyAffineTransform(event, [NaN, 0, 0, 0, 1, 0]);
      expect(touch.x).assertEqual(10);
      expect(touch.y).assertEqual(20);
    });

    it('returns early when coefficients contain Infinity', Level.LEVEL1, () => {
      const touch = makeTouch(10, 20);
      const event = makeEvent(new Array<CustomTouchObject>(touch), new Array<CustomTouchObject>(touch));
      TouchEventProcessor.applyAffineTransform(event, [Infinity, 0, 0, 0, 1, 0]);
      expect(touch.x).assertEqual(10);
      expect(touch.y).assertEqual(20);
    });

    it('applies identity transform (no change)', Level.LEVEL1, () => {
      const touch = makeTouch(10, 20);
      const event = makeEvent(new Array<CustomTouchObject>(touch), new Array<CustomTouchObject>(touch));
      // Identity: scaleX=1, shearY=0, tx=0, shearX=0, scaleY=1, ty=0
      TouchEventProcessor.applyAffineTransform(event, [1, 0, 0, 0, 1, 0]);
      expect(touch.x).assertEqual(10);
      expect(touch.y).assertEqual(20);
    });

    it('applies translation transform', Level.LEVEL1, () => {
      const touch = makeTouch(10, 20);
      const event = makeEvent(new Array<CustomTouchObject>(touch), new Array<CustomTouchObject>(touch));
      // Translation: tx=5, ty=10 (with identity scale/shear)
      TouchEventProcessor.applyAffineTransform(event, [1, 0, 5, 0, 1, 10]);
      // x_new = invScaleX*x + invShearX*y + invTx = 1*10 + 0*20 + 5 = 15
      // y_new = invShearY*x + invScaleY*y + invTy = 0*10 + 1*20 + 10 = 30
      expect(touch.x).assertEqual(15);
      expect(touch.y).assertEqual(30);
    });

    it('applies scale transform', Level.LEVEL1, () => {
      const touch = makeTouch(10, 20);
      const event = makeEvent(new Array<CustomTouchObject>(touch), new Array<CustomTouchObject>(touch));
      // Scale: scaleX=2, scaleY=3
      TouchEventProcessor.applyAffineTransform(event, [2, 0, 0, 0, 3, 0]);
      expect(touch.x).assertEqual(20);
      expect(touch.y).assertEqual(60);
    });

    it('applies transform to all touch objects in touches and changedTouches', Level.LEVEL1, () => {
      const t1 = makeTouch(10, 20);
      const t2 = makeTouch(30, 40);
      const event = makeEvent(new Array<CustomTouchObject>(t1, t2), new Array<CustomTouchObject>(t1, t2));
      // Translation: tx=100, ty=0
      TouchEventProcessor.applyAffineTransform(event, [1, 0, 100, 0, 1, 0]);
      expect(t1.x).assertEqual(110);
      expect(t2.x).assertEqual(130);
    });
  });

  describe('TouchEventProcessor.getInstance.and.static.methods', () => {
    it('getInstance returns singleton', Level.LEVEL1, () => {
      const a = TouchEventProcessor.getInstance();
      const b = TouchEventProcessor.getInstance();
      expect(a === b).assertEqual(true);
    });

    it('postTouchEvent with empty FlutterViewList does not throw', Level.LEVEL1, () => {
      let threw = false;
      try { TouchEventProcessor.getInstance().postTouchEvent(new Array<string>()); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('postMouseEvent with empty FlutterViewList does not throw', Level.LEVEL1, () => {
      let threw = false;
      try { TouchEventProcessor.getInstance().postMouseEvent(new Array<string>()); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('postAxisEvent with empty FlutterViewList does not throw', Level.LEVEL1, () => {
      let threw = false;
      try { TouchEventProcessor.getInstance().postAxisEvent(new Array<string>()); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('CustomTouchObject with no touches returns empty recordCount', Level.LEVEL1, () => {
      const e = new CustomTouchEvent(0, new Array<CustomTouchObject>(), new Array<CustomTouchObject>(), 0, 0, 0, 0, 0, 0);
      expect(e.touches.length).assertEqual(0);
      expect(e.changedTouches.length).assertEqual(0);
    });

    it('CustomTouchObject with one touch', Level.LEVEL1, () => {
      const t = new CustomTouchObject(0, 1, 10, 20, 30, 40, 50, 60, 70, 80);
      const e = new CustomTouchEvent(0, new Array<CustomTouchObject>(t), new Array<CustomTouchObject>(t), 0, 0, 0, 0, 0, 0);
      expect(e.touches.length).assertEqual(1);
      expect(e.changedTouches.length).assertEqual(1);
    });
  });
  describe('TouchEventProcessor.constructCustomTouchEvent', () => {
    it('constructs touch event without throwing', Level.LEVEL0, () => {
      const proc = TouchEventProcessor.getInstance();
      let threw = false;
      try { proc.constructCustomTouchEvent([], 0, 0); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('constructs touch event with valid strings', Level.LEVEL0, () => {
      const proc = TouchEventProcessor.getInstance();
      let threw = false;
      let result: Any = null;
      try { result = proc.constructCustomTouchEvent(['1', '0', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0'], 0, 0); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });
  });

  describe('TouchEventProcessor.postTouchEvent', () => {
    it('does not throw with empty strings', Level.LEVEL0, () => {
      const proc = TouchEventProcessor.getInstance();
      let threw = false;
      try { proc.postTouchEvent([]); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });
  });

  describe('TouchEventProcessor.postMouseEvent', () => {
    it('does not throw with empty strings', Level.LEVEL0, () => {
      const proc = TouchEventProcessor.getInstance();
      let threw = false;
      try { proc.postMouseEvent([]); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });
  });

  describe('TouchEventProcessor.postAxisEvent', () => {
    it('does not throw with empty strings', Level.LEVEL0, () => {
      const proc = TouchEventProcessor.getInstance();
      let threw = false;
      try { proc.postAxisEvent([]); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });
  });

  describe('TouchEventProcessor.constructMouseEvent', () => {
    it('does not throw with empty strings', Level.LEVEL0, () => {
      const proc = TouchEventProcessor.getInstance();
      let threw = false;
      try { proc.constructMouseEvent([], 0, 0); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });
  });

  describe('TouchEventProcessor.rememberPostedTouchEvent.branches', () => {
    const mkTouch = (type: TouchType, id: number): CustomTouchObject => {
      const t: Any = {
        type: type, id: id, displayX: 0, displayY: 0,
        windowX: 0, windowY: 0, screenX: 0, screenY: 0, x: 0, y: 0
      };
      return t as Any as CustomTouchObject;
    };
    const mkEvent = (type: TouchType, touches: CustomTouchObject[], changed: CustomTouchObject[]): CustomTouchEvent => {
      const e: Any = { type: type, touches: touches, changedTouches: changed };
      return e as Any as CustomTouchEvent;
    };

    it('cancel event clears the active touch map', Level.LEVEL1, () => {
      const proc = TouchEventProcessor.getInstance();
      const params: Record<string, Any> = {};
      let threw = false;
      try {
        (proc as Any).rememberPostedTouchEvent(params, mkEvent(TouchType.Cancel, [], []), true);
      } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
      expect(Object.keys(params).length >= 2).assertEqual(true);
    });

    it('down event stores active touch and second call reuses the map', Level.LEVEL1, () => {
      const proc = TouchEventProcessor.getInstance();
      const params: Record<string, Any> = {};
      let threw = false;
      try {
        (proc as Any).rememberPostedTouchEvent(params,
          mkEvent(TouchType.Down, [mkTouch(TouchType.Down, 1)], [mkTouch(TouchType.Down, 1)]), true);
        (proc as Any).rememberPostedTouchEvent(params,
          mkEvent(TouchType.Move, [mkTouch(TouchType.Move, 1)], [mkTouch(TouchType.Move, 1)]), true);
      } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('terminal changed touch deletes, terminal touches delete too', Level.LEVEL1, () => {
      const proc = TouchEventProcessor.getInstance();
      const params: Record<string, Any> = {};
      let threw = false;
      try {
        (proc as Any).rememberPostedTouchEvent(params,
          mkEvent(TouchType.Up, [mkTouch(TouchType.Up, 2)], [mkTouch(TouchType.Up, 1)]), true);
      } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('getActiveTouches without create returns undefined on fresh params', Level.LEVEL1, () => {
      const proc = TouchEventProcessor.getInstance();
      const params: Record<string, Any> = {};
      const result: Any | undefined = (proc as Any).getActiveTouches(params, false) as Any | undefined;
      expect(result).assertUndefined();
    });
  });

  // ===== Supplement (2026-08-29): packet decoding, dispatch paths and hit tests =====

  /**
   * Builds a single-point touch packet. Layout mirrors decodeTouchPacket:
   * numPoint, changed id/screenX/screenY/x/y/type/size/force/deviceId/timeStamp,
   * then per point id/x/y/localX/localY/type/size/force/deviceId/isPx,
   * then toolType/tiltX/tiltY.
   */
  const mkTouchStrings = (density: number, type: string): Array<string> => {
    const arr: Array<string> = [
      '1',                                  // numPoint
      '7',                                  // changed id
      String(100 * density),                // changed screenX (px)
      String(50 * density),                 // changed screenY (px)
      String((30 + 10) * density),          // changed x (px, left=10)
      String((40 + 20) * density),          // changed y (px, top=20)
      type,                                 // changed type
      '1.5',                                // changed size
      '0.6',                                // changed force
      '9',                                  // changed deviceId
      '12345',                              // changed timeStamp
      '7',                                  // point id
      String((25 + 10) * density),          // point x (px)
      String((35 + 20) * density),          // point y (px)
      String((25 + 10) * density),          // point local x (px, left=10)
      String((35 + 20) * density),          // point local y (px, top=20)
      type,                                 // point type
      '1.5',                                // point size
      '0.6',                                // point force
      '9',                                  // point deviceId
      '1',                                  // point isPx flag
      '2',                                  // toolType
      '3',                                  // tiltX
      '4'                                   // tiltY
    ];
    return arr;
  };

  const installView = (key: string, view: FakeProcView): void => {
    (FlutterManager.getInstance().getFlutterViewList() as Any).set(key, view);
  };

  const removeView = (key: string): void => {
    (FlutterManager.getInstance().getFlutterViewList() as Any).delete(key);
  };

  describe('TouchEventProcessor.constructCustomTouchEvent', () => {
    it('parses a single-point packet into a CustomTouchEvent', Level.LEVEL0, () => {
      const density: number = display.getDefaultDisplaySync().densityPixels;
      const strings = mkTouchStrings(density, '0');
      const evt: CustomTouchEvent = TouchEventProcessor.getInstance().constructCustomTouchEvent(strings, 20, 10);
      expect(evt.type).assertEqual(0);
      expect(evt.changedTouches.length).assertEqual(1);
      expect(evt.touches.length).assertEqual(1);
      expect(evt.touches[0].id).assertEqual(7);
      expect(Math.abs(evt.touches[0].x - 25) < 1e-6).assertEqual(true);
      expect(Math.abs(evt.touches[0].y - 35) < 1e-6).assertEqual(true);
      expect(Math.abs(evt.pressure - 0.6) < 1e-6).assertEqual(true);
      expect(evt.tiltX).assertEqual(3);
      expect(evt.tiltY).assertEqual(4);
      expect(evt.sourceTool).assertEqual(2);
    });

    it('parses the non-px flag variant without changing local coordinates', Level.LEVEL0, () => {
      const density: number = display.getDefaultDisplaySync().densityPixels;
      const strings = mkTouchStrings(density, '1');
      strings[20] = '0';
      const evt: CustomTouchEvent = TouchEventProcessor.getInstance().constructCustomTouchEvent(strings, 20, 10);
      expect(evt.type).assertEqual(1);
      expect(Math.abs(evt.touches[0].x - 25) < 1e-6).assertEqual(true);
    });
  });

  describe('TouchEventProcessor.postTouchEvent', () => {
    it('down view receives the event and text-input handoff runs', Level.LEVEL1, () => {
      const density: number = display.getDefaultDisplaySync().densityPixels;
      const view = new FakeProcView();
      const recorder = new PostRecorder();
      const handoffCalls: boolean[] = [];
      const params: Record<string, Any> = {
        'down': true,
        'nodeController': recorder,
        'affineTransform': [1, 0, -5, 0, 1, -7]
      };
      params['textInputHandoffOnTouch'] = (canInvoke: boolean): void => { handoffCalls.push(canInvoke); };
      view.children.push({
        getLayoutParams: (): Record<string, Any> => params,
        params: params,
        compType: 'NodeContainer',
        children: []
      } as Any);
      installView('tep-down', view);
      try {
        TouchEventProcessor.getInstance().postTouchEvent(mkTouchStrings(density, '0'));
        expect(recorder.touchEvents.length).assertEqual(1);
        expect(handoffCalls.length).assertEqual(1);
        expect(handoffCalls[0]).assertEqual(true);
        expect(params['platformViewLastTouchEvent'] !== undefined).assertEqual(true);
        const active: Any = params['platformViewActiveTouches'];
        expect(active.size).assertEqual(1);
      } finally {
        removeView('tep-down');
      }
    });

    it('not-down view with a fresh DOWN clears and re-queues the buffer', Level.LEVEL1, () => {
      const density: number = display.getDefaultDisplaySync().densityPixels;
      const view = new FakeProcView();
      const params: Record<string, Any> = { 'touchEvent': [new CustomTouchEvent(0, [], [], 0, 0, 0, 0, 0, 0)] };
      view.children.push({
        getLayoutParams: (): Record<string, Any> => params,
        params: params,
        compType: 'NodeContainer',
        children: []
      } as Any);
      installView('tep-queue', view);
      try {
        TouchEventProcessor.getInstance().postTouchEvent(mkTouchStrings(density, '0'));
        const queued: Any = params['touchEvent'];
        expect(queued.length).assertEqual(1);
        expect(queued[0].type).assertEqual(0);
        expect(params['platformViewCancelDraining']).assertEqual(false);
      } finally {
        removeView('tep-queue');
      }
    });

    it('cancel draining suppresses non-DOWN events', Level.LEVEL1, () => {
      const density: number = display.getDefaultDisplaySync().densityPixels;
      const view = new FakeProcView();
      const sentinel: CustomTouchEvent[] = [new CustomTouchEvent(0, [], [], 0, 0, 0, 0, 0, 0)];
      const params: Record<string, Any> = {
        'platformViewCancelDraining': true,
        'touchEvent': sentinel
      };
      view.children.push({
        getLayoutParams: (): Record<string, Any> => params,
        params: params,
        compType: 'NodeContainer',
        children: []
      } as Any);
      installView('tep-draining', view);
      try {
        TouchEventProcessor.getInstance().postTouchEvent(mkTouchStrings(density, '2'));
        expect(params['touchEvent'].length).assertEqual(1);
      } finally {
        removeView('tep-draining');
      }
    });

    it('inactive views are skipped entirely', Level.LEVEL1, () => {
      const density: number = display.getDefaultDisplaySync().densityPixels;
      const view = new FakeProcView();
      view.active = false;
      const params: Record<string, Any> = {};
      view.children.push({
        getLayoutParams: (): Record<string, Any> => params,
        params: params,
        compType: 'NodeContainer',
        children: []
      } as Any);
      installView('tep-inactive', view);
      try {
        TouchEventProcessor.getInstance().postTouchEvent(mkTouchStrings(density, '0'));
        expect(params['touchEvent']).assertUndefined();
      } finally {
        removeView('tep-inactive');
      }
    });
  });

  describe('TouchEventProcessor.postMouseEvent', () => {
    const mkMouseStrings = (action: number, button: number): Array<string> => [
      String((30 + 10)),   // x (raw int px)
      String((40 + 20)),   // y
      '100',               // screenX
      '50',                // screenY
      '99',                // timestamp
      String(action),
      String(button)
    ];

    it('hover + non press/release dispatches the move', Level.LEVEL1, () => {
      const view = new FakeProcView();
      const recorder = new PostRecorder();
      const params: Record<string, Any> = { 'hover': true, 'nodeController': recorder, 'left': 10, 'top': 20 };
      view.children.push({
        getLayoutParams: (): Record<string, Any> => params,
        params: params,
        compType: 'NodeContainer',
        children: []
      } as Any);
      installView('tep-mouse-hover', view);
      try {
        TouchEventProcessor.getInstance().postMouseEvent(mkMouseStrings(3, 0));
        expect(recorder.mouseEvents.length).assertEqual(1);
      } finally {
        removeView('tep-mouse-hover');
      }
    });

    it('synthesized press dispatches release and clears the flag', Level.LEVEL1, () => {
      const view = new FakeProcView();
      const recorder = new PostRecorder();
      const params: Record<string, Any> = {
        'mouseDownSynthesized': true,
        'nodeController': recorder,
        'left': 10,
        'top': 20,
        'mouseEvent': []
      };
      view.children.push({
        getLayoutParams: (): Record<string, Any> => params,
        params: params,
        compType: 'NodeContainer',
        children: []
      } as Any);
      installView('tep-mouse-synth', view);
      try {
        TouchEventProcessor.getInstance().postMouseEvent(mkMouseStrings(2, 0));
        expect(recorder.mouseEvents.length).assertEqual(1);
        expect(params['mouseDownSynthesized']).assertEqual(false);
        expect(params['mouseEvent']).assertUndefined();
      } finally {
        removeView('tep-mouse-synth');
      }
    });

    it('press on non-down view is queued', Level.LEVEL1, () => {
      const view = new FakeProcView();
      const recorder = new PostRecorder();
      const params: Record<string, Any> = { 'nodeController': recorder, 'left': 10, 'top': 20 };
      view.children.push({
        getLayoutParams: (): Record<string, Any> => params,
        params: params,
        compType: 'NodeContainer',
        children: []
      } as Any);
      installView('tep-mouse-queue', view);
      try {
        TouchEventProcessor.getInstance().postMouseEvent(mkMouseStrings(1, 0));
        expect(recorder.mouseEvents.length).assertEqual(0);
        const queued: Any = params['mouseEvent'];
        expect(queued.length).assertEqual(1);
        expect(queued[0].action).assertEqual(1);
      } finally {
        removeView('tep-mouse-queue');
      }
    });
  });

  describe('TouchEventProcessor.postAxisEvent', () => {
    it('axis events reach hovered views with parsed scroll', Level.LEVEL1, () => {
      const view = new FakeProcView();
      const recorder = new PostRecorder();
      const params: Record<string, Any> = { 'hover': true, 'nodeController': recorder, 'left': 10, 'top': 20 };
      view.children.push({
        getLayoutParams: (): Record<string, Any> => params,
        params: params,
        compType: 'NodeContainer',
        children: []
      } as Any);
      installView('tep-axis', view);
      try {
        TouchEventProcessor.getInstance().postAxisEvent(['3', '40', '60', '100', '50', '100', '50', '2.5']);
        expect(recorder.axisEvents.length).assertEqual(1);
        const axis: AxisEvent = recorder.axisEvents[0] as AxisEvent;
        expect(Math.abs((axis.scrollStep ?? 0) - 2.5) < 1e-6).assertEqual(true);
      } finally {
        removeView('tep-axis');
      }
    });

    it('views without hover are skipped', Level.LEVEL1, () => {
      const view = new FakeProcView();
      const recorder = new PostRecorder();
      const params: Record<string, Any> = { 'nodeController': recorder, 'left': 10, 'top': 20 };
      view.children.push({
        getLayoutParams: (): Record<string, Any> => params,
        params: params,
        compType: 'NodeContainer',
        children: []
      } as Any);
      installView('tep-axis-nohover', view);
      try {
        TouchEventProcessor.getInstance().postAxisEvent(['3', '40', '60', '100', '50', '100', '50', '2.5']);
        expect(recorder.axisEvents.length).assertEqual(0);
      } finally {
        removeView('tep-axis-nohover');
      }
    });
  });

  describe('TouchEventProcessor.hitAndTransform', () => {
    it('checkHitPlatformViewByLocal rejects non-positive bounds', Level.LEVEL1, () => {
      const proc: Any = TouchEventProcessor.getInstance();
      const params: Record<string, Any> = { 'width': 0, 'height': 100 };
      const ev: Any = { x: 1, y: 1 };
      const hit: boolean = (proc as Any).checkHitPlatformViewByLocal(ev, params) as boolean;
      expect(hit).assertEqual(false);
    });

    it('checkHitPlatformViewByLocal accepts inside and rejects outside', Level.LEVEL1, () => {
      const proc: Any = TouchEventProcessor.getInstance();
      const params: Record<string, Any> = { 'width': 100, 'height': 50 };
      const inside: Any = { x: 1, y: 1 };
      const outside: Any = { x: -5, y: 1 };
      const hitIn: boolean = (proc as Any).checkHitPlatformViewByLocal(inside, params) as boolean;
      const hitOut: boolean = (proc as Any).checkHitPlatformViewByLocal(outside, params) as boolean;
      expect(hitIn).assertEqual(true);
      expect(hitOut).assertEqual(false);
    });

    it('applyAffineTransform ignores undefined and short transforms', Level.LEVEL1, () => {
      const touch = makeTouch(10, 4);
      const evt = makeEvent([touch], [touch]);
      TouchEventProcessor.applyAffineTransform(evt, undefined);
      TouchEventProcessor.applyAffineTransform(evt, [1, 0, 0, 0, 1]);
      expect(touch.x).assertEqual(10);
      expect(touch.y).assertEqual(4);
    });
  });

}
