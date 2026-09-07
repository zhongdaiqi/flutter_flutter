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
import Any from '../../../../../main/ets/plugin/common/Any';
import { TouchEventId, TouchEventTracker } from '../../../../../main/ets/embedding/ohos/TouchEventTracker';
import { TouchEvent } from '@ohos.multimodalInput.touchEvent';

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
describe('TouchEventTracker.pop', () => {
  it('pop returns undefined for an untracked event id', 0, () => {
    const tracker = TouchEventTracker.getInstance();
    const e: Any = tracker;
    const unknownId: number = 99999;
    const result: Any = tracker.pop(new TouchEventId(99999));
    expect(result === undefined || result === null).assertEqual(true);
  });
});
}
