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
import { describe, expect, it } from '@ohos/hypium';
import { TouchEventId, TouchEventTracker } from '../../../../../main/ets/embedding/ohos/TouchEventTracker';
import { TouchEvent } from '@ohos.multimodalInput.touchEvent';
import Any from '../../../../../main/ets/plugin/common/Any';

export default function TouchEventTrackerTest() {
  const touchEventTracker: TouchEventTracker = new TouchEventTracker();

  describe('TouchEventTrackerTest', () => {

    it('getInstance', 0, async (done: Function) => {
      console.info("uitest: getInstance begin");
      const getInstance: TouchEventTracker  = TouchEventTracker.getInstance();
      expect(getInstance).not().assertNull();
      done();
    })

    it('track', 0, async (done: Function) => {
      console.info("uitest: decodeTouchPacket begin");
      const event: TouchEvent | null = null;
      if(event) {
        const decodeTouchPacket: TouchEventId = touchEventTracker.track(event);
        expect(decodeTouchPacket).not().assertNull();
      }
      done();
    })

    it('pop', 0, async (done: Function) => {
      console.info("uitest: pop begin");
      const eventId: TouchEventId | null = null;
      if(eventId) {
        const tuchEvent: TouchEvent = touchEventTracker.pop(eventId);
        expect(tuchEvent).not().assertNull();
      }
      done();
    })
  })

  describe('TouchEventTracker.pop.branches', () => {
    const mkEvent = (marker: string): TouchEvent => ({ marker: marker } as Any as TouchEvent);

    it('pop discards older events and returns the tracked one', 0, () => {
      const tracker = new TouchEventTracker();
      const idA = tracker.track(mkEvent('a'));
      const idB = tracker.track(mkEvent('b'));
      const idC = tracker.track(mkEvent('c'));
      // pop b: while-loop removes a (older), then first==b removes b.
      const popped = tracker.pop(idB);
      expect((popped as Any).marker).assertEqual('b');
      // pop c: loop removes nothing (b already gone, queue now [c]); first==c removes c.
      const poppedC = tracker.pop(idC);
      expect((poppedC as Any).marker).assertEqual('c');
    });

    it('pop drains the whole queue when popping the newest id', 0, () => {
      const tracker = new TouchEventTracker();
      const idA = tracker.track(mkEvent('a'));
      const idB = tracker.track(mkEvent('b'));
      // pop the newest id: while-loop pops a, then first==b exits the loop and the guard pops b.
      const popped = tracker.pop(idB);
      expect((popped as Any).marker).assertEqual('b');
      // queue is now empty: a second pop of the same id exits the while-loop on the
      // length==0 arm and returns undefined without throwing.
      const again = tracker.pop(idB);
      expect(again === undefined).assertEqual(true);
    });

    it('pop first tracked event exits loop on the < guard false arm', 0, () => {
      const tracker = new TouchEventTracker();
      const idA = tracker.track(mkEvent('a'));
      const popped = tracker.pop(idA);
      expect((popped as Any).marker).assertEqual('a');
    });

    it('TouchEventId from/createUnique produce distinct ids', 0, () => {
      const a = TouchEventId.createUnique();
      const b = TouchEventId.createUnique();
      expect(a.getId() === b.getId()).assertEqual(false);
      expect(TouchEventId.from(42).getId()).assertEqual(42);
    });
  })
}