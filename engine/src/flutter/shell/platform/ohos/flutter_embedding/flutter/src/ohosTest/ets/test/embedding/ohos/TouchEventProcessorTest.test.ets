/*
 * Copyright (c) 2026 Huawei Device Co., Ltd. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE_HW file.
 */

import { describe, it, expect, Level } from '@ohos/hypium';
import TouchEventProcessor from '../../../../../main/ets/embedding/ohos/TouchEventProcessor';
import FlutterManager from '../../../../../main/ets/embedding/ohos/FlutterManager';
import { FlutterView } from '../../../../../main/ets/view/FlutterView';
import common from '@ohos.app.ability.common';
import { FlutterMutatorsStack } from '../../../../../main/ets/embedding/engine/mutatorsstack/FlutterMutatorsStack';
import { FlutterMutatorView } from '../../../../../main/ets/embedding/engine/mutatorsstack/FlutterMutatorView';
import Any from '../../../../../main/ets/plugin/common/Any';
import { CustomTouchEvent, CustomTouchObject } from '../../../../../main/ets/plugin/platform/CustomTouchEvent';

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

describe('TouchEventProcessor.touchHelpers', () => {
  it('isTerminalTouch classifies terminal touch types', 0, () => {
    const p: Any = TouchEventProcessor.getInstance();
    expect(p['isTerminalTouch'](TouchType.Up)).assertEqual(true);
    expect(p['isTerminalTouch'](TouchType.Cancel)).assertEqual(true);
    expect(p['isTerminalTouch'](TouchType.Down)).assertEqual(false);
    expect(p['isTerminalTouch'](TouchType.Move)).assertEqual(false);
  });

  it('cloneTouchObjectWithType copies fields and swaps type', 0, () => {
    const p: Any = TouchEventProcessor.getInstance();
    const touch = new CustomTouchObject(TouchType.Down, 3, 9, 8, 7, 6, 5, 4, 3, 2);
    const cloned: CustomTouchObject = p['cloneTouchObjectWithType'](touch, TouchType.Cancel);
    expect(cloned.type).assertEqual(TouchType.Cancel);
    expect(cloned.id).assertEqual(3);
    expect(cloned.displayX).assertEqual(9);
    expect(cloned.displayY).assertEqual(8);
    expect(cloned.windowX).assertEqual(7);
    expect(cloned.windowY).assertEqual(6);
    expect(cloned.screenX).assertEqual(5);
    expect(cloned.screenY).assertEqual(4);
    expect(cloned.x).assertEqual(3);
    expect(cloned.y).assertEqual(2);
  });

  it('getActiveTouches creates reuses and returns undefined without create', 0, () => {
    const p: Any = TouchEventProcessor.getInstance();
    const params: Record<string, Any> = {};
    expect(p['getActiveTouches'](params, false)).assertUndefined();
    const m1: Any = p['getActiveTouches'](params, true);
    expect(m1).not().assertNull();
    expect(p['getActiveTouches'](params, false) === m1).assertEqual(true);
  });
});
describe('TouchEventProcessor.rememberPostedTouchEvent', () => {
  it('tracks move touches and stores the last event', 0, () => {
    const p: Any = TouchEventProcessor.getInstance();
    const params: Record<string, Any> = {};
    const touch = new CustomTouchObject(TouchType.Move, 5, 1, 2, 3, 4, 5, 6, 7, 8);
    const event = new CustomTouchEvent(TouchType.Move, [touch], [touch], 1234,
      SourceType.TouchScreen, 1, 0, 0, SourceTool.Finger);
    p['rememberPostedTouchEvent'](params, event);
    expect(params['platformViewLastTouchEvent'] === event).assertEqual(true);
    expect(params['platformViewLastTouchEventIsPx']).assertEqual(true);
    const active = params['platformViewActiveTouches'] as Map<number, CustomTouchObject>;
    expect(active.size).assertEqual(1);
    expect(active.get(5)!.id).assertEqual(5);
  });

  it('clears active touches on cancel event', 0, () => {
    const p: Any = TouchEventProcessor.getInstance();
    const params: Record<string, Any> = {};
    const seed = new CustomTouchObject(TouchType.Move, 5, 1, 1, 1, 1, 1, 1, 1, 1);
    const seedEvent = new CustomTouchEvent(TouchType.Move, [seed], [seed], 1234,
      SourceType.TouchScreen, 1, 0, 0, SourceTool.Finger);
    p['rememberPostedTouchEvent'](params, seedEvent);
    const cancelTouch = new CustomTouchObject(TouchType.Cancel, 5, 1, 1, 1, 1, 1, 1, 1, 1);
    const cancelEvent = new CustomTouchEvent(TouchType.Cancel, [cancelTouch], [cancelTouch], 1300,
      SourceType.TouchScreen, 1, 0, 0, SourceTool.Finger);
    p['rememberPostedTouchEvent'](params, cancelEvent);
    const active = params['platformViewActiveTouches'] as Map<number, CustomTouchObject>;
    expect(active.size).assertEqual(0);
  });

  it('removes terminal touches in both changed and full lists', 0, () => {
    const p: Any = TouchEventProcessor.getInstance();
    const params: Record<string, Any> = {};
    const seedA = new CustomTouchObject(TouchType.Move, 1, 1, 1, 1, 1, 1, 1, 1, 1);
    const seedB = new CustomTouchObject(TouchType.Move, 2, 1, 1, 1, 1, 1, 1, 1, 1);
    const seedEvent = new CustomTouchEvent(TouchType.Move, [seedA, seedB], [seedA, seedB], 1234,
      SourceType.TouchScreen, 1, 0, 0, SourceTool.Finger);
    p['rememberPostedTouchEvent'](params, seedEvent);
    // terminal arrives in changedTouches, survivor in touches
    const upA = new CustomTouchObject(TouchType.Up, 1, 1, 1, 1, 1, 1, 1, 1, 1);
    const stayB = new CustomTouchObject(TouchType.Up, 2, 1, 1, 1, 1, 1, 1, 1, 1);
    const upEvent = new CustomTouchEvent(TouchType.Up, [stayB], [upA], 1300,
      SourceType.TouchScreen, 1, 0, 0, SourceTool.Finger);
    p['rememberPostedTouchEvent'](params, upEvent);
    const active = params['platformViewActiveTouches'] as Map<number, CustomTouchObject>;
    expect(active.size).assertEqual(0);
  });
});

describe('TouchEventProcessor.applyAffineToObjects', () => {
  it('updates local coords with a finite inverse', 0, () => {
    const cls: Any = TouchEventProcessor;
    const obj = new CustomTouchObject(TouchType.Move, 0, 10, 20, 0, 0, 0, 0, 99, 99);
    // lx = 1*10 + 0*20 + 5 = 15; ly = 0*10 + 1*20 + 7 = 27
    cls['applyAffineToObjects']([obj], 1, 0, 5, 0, 1, 7);
    expect(obj.x).assertEqual(15);
    expect(obj.y).assertEqual(27);
  });

  it('keeps the old coord when the mapped value is not finite', 0, () => {
    const cls: Any = TouchEventProcessor;
    const obj = new CustomTouchObject(TouchType.Move, 0, 10, 20, 0, 0, 0, 0, 99, 99);
    // invScaleX NaN -> lx NaN (x kept); ly = 20 + 7 finite (y updated)
    cls['applyAffineToObjects']([obj], Number.NaN, 0, 5, 0, 1, 7);
    expect(obj.x).assertEqual(99);
    expect(obj.y).assertEqual(27);
  });

  it('keeps y when ly is not finite', 0, () => {
    const cls: Any = TouchEventProcessor;
    const obj = new CustomTouchObject(TouchType.Move, 0, 10, 20, 0, 0, 0, 0, 99, 99);
    cls['applyAffineToObjects']([obj], 1, 0, 5, 0, Number.NaN, 7);
    expect(obj.x).assertEqual(15);
    expect(obj.y).assertEqual(99);
  });
});

describe('TouchEventProcessor.checkHitPlatformViewByLocal', () => {
  it('returns false for zero-size views', 0, () => {
    const p: Any = TouchEventProcessor.getInstance();
    const mouse = { 'x': 5, 'y': 5 } as Any as MouseEvent;
    const params: Record<string, Any> = { 'width': 0, 'height': 0 };
    expect(p['checkHitPlatformViewByLocal'](mouse, params)).assertEqual(false);
  });

  it('returns true inside the view bounds', 0, () => {
    const p: Any = TouchEventProcessor.getInstance();
    const mouse = { 'x': 5, 'y': 5 } as Any as MouseEvent;
    const params: Record<string, Any> = { 'width': 100, 'height': 100 };
    expect(p['checkHitPlatformViewByLocal'](mouse, params)).assertEqual(true);
  });

  it('returns false outside the view bounds', 0, () => {
    const p: Any = TouchEventProcessor.getInstance();
    const mouse = { 'x': 100000, 'y': 5 } as Any as MouseEvent;
    const params: Record<string, Any> = { 'width': 100, 'height': 100 };
    expect(p['checkHitPlatformViewByLocal'](mouse, params)).assertEqual(false);
  });
});
}
