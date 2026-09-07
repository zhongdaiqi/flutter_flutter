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
import { FlutterMutatorView } from '../../../../../../main/ets/embedding/engine/mutatorsstack/FlutterMutatorView';
import { FlutterMutatorsStack } from '../../../../../../main/ets/embedding/engine/mutatorsstack/FlutterMutatorsStack';
import { DVModel } from '../../../../../../main/ets/view/DynamicView/dynamicView';
import Any from '../../../../../../main/ets/plugin/common/Any';

class DVModelParam {
  compType: string;
  children: Array<Any>;
  attributes: Any;
  events: Any;

  constructor(compType: string, children: Array<Any>, attributes: Any, events: Any) {
    this.compType = compType;
    this.children = children;
    this.attributes = attributes;
    this.events = events;
  }
}

export default function FlutterMutatorViewTest() {
  describe('FlutterMutatorViewTest', () => {
    it('TestGetDvModel', 0, async (done: Function) => {
      let flutterMutatorView = new FlutterMutatorView();
      let dvModel = flutterMutatorView.getDvModel();
      expect(dvModel).not().assertNull();
      done();
    })

    it('TestGetDvModelReturnsSameInstanceOnSecondCall', 0, () => {
      const v = new FlutterMutatorView();
      const a = v.getDvModel();
      const b = v.getDvModel();
      expect(a === b).assertEqual(true);
    });

    it('TestSetOnDescendantFocusChangeListenerDoesNotThrow', 0, () => {
      const v = new FlutterMutatorView();
      let threw = false;
      try { v.setOnDescendantFocusChangeListener(() => {}, () => {}); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('TestGetDvModelFromSecondViewReturnsDifferent', 0, () => {
      const v1 = new FlutterMutatorView();
      const v2 = new FlutterMutatorView();
      expect(v1.getDvModel() === v2.getDvModel()).assertEqual(false);
    });
  });

  describe('DVModelParam.mirror', () => {
    it('default ctor assigns fields', 0, () => {
      const p = new DVModelParam('row', [], {}, {});
      expect(p.compType).assertEqual('row');
      expect(p.children.length).assertEqual(0);
    });
  });

describe('FlutterMutatorView.readyToDisplay', () => {
  it('applies clip rect mutators to params', 0, () => {
    const view = new FlutterMutatorView();
    const stack = new FlutterMutatorsStack();
    stack.pushClipRect(11, 22, 0);
    view.readyToDisplay(stack, 5, 6, 100, 200);
    const model: Any = view.getDvModel();
    const params: Any = model['params'];
    expect(params['rectWidth']).assertEqual(11);
    expect(params['rectHeight']).assertEqual(22);
  });

  it('applies clip path mutators to params', 0, () => {
    const view = new FlutterMutatorView();
    const stack = new FlutterMutatorsStack();
    stack.pushClipPath(31, 41, 'M0 0');
    view.readyToDisplay(stack, 5, 6, 100, 200);
    const model: Any = view.getDvModel();
    const params: Any = model['params'];
    expect(params['pathWidth']).assertEqual(31);
    expect(params['pathHeight']).assertEqual(41);
    expect(params['pathCommands']).assertEqual('M0 0');
  });

  it('sets layout margins with empty stack', 0, () => {
    const view = new FlutterMutatorView();
    view.readyToDisplay(new FlutterMutatorsStack(), 7, 8, 90, 80);
    const model: Any = view.getDvModel();
    const params: Any = model['params'];
    expect(params['marginLeft']).assertEqual(7);
    expect(params['marginTop']).assertEqual(8);
    expect(params['width']).assertEqual(90);
    expect(params['height']).assertEqual(80);
  });

  it('touch handlers update translate params without throwing', 0, () => {
    const view: Any = new FlutterMutatorView();
    view.readyToDisplay(new FlutterMutatorsStack(), 7, 8, 90, 80);
    const onTouch: Any = view['onTouch'];
    let threw = false;
    try {
      onTouch({ 'type': TouchType.Down } as Any);
      onTouch({ 'type': TouchType.Move } as Any);
      onTouch({ 'type': TouchType.Up } as Any);
    } catch (e) {
      threw = true;
    }
    expect(threw).assertEqual(false);
    const model: Any = view.getDvModel();
    const params: Any = model['params'];
    expect(params['translateX']).assertEqual(7);
    expect(params['translateY']).assertEqual(8);
  });
});
}
