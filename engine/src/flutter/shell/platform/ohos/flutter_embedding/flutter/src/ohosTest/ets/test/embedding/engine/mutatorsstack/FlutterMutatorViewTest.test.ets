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
import { DVModel, DVModelEvents, DVModelChildren, DVModelParameters } from '../../../../../../main/ets/view/DynamicView/dynamicView';
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

  describe('FlutterMutatorView.readyToDisplay.branches', () => {
    it('applies layout params and non-empty clip stacks', 0, () => {
      const view = new FlutterMutatorView();
      const stack = new FlutterMutatorsStack();
      stack.pushClipRect(10, 20, 0);
      stack.pushClipPath(30, 40, 'M0,0 L10,10');
      view.readyToDisplay(stack, 1, 2, 30, 40);
      const params = view.getDvModel()!.params as Record<string, Any>;
      expect(params['marginLeft']).assertEqual(1);
      expect(params['marginTop']).assertEqual(2);
      expect(params['width']).assertEqual(30);
      expect(params['rectWidth']).assertEqual(10);
      expect(params['rectHeight']).assertEqual(20);
      expect(params['pathWidth']).assertEqual(30);
      expect(params['pathHeight']).assertEqual(40);
      expect(params['matrix']).not().assertNull();
    });

    it('empty clip stack leaves path/rect params unset', 0, () => {
      const view = new FlutterMutatorView();
      view.readyToDisplay(new FlutterMutatorsStack(), 5, 6, 7, 8);
      const params = view.getDvModel()!.params as Record<string, Any>;
      expect(params['marginLeft']).assertEqual(5);
      expect(params['pathWidth']).assertUndefined();
      expect(params['rectWidth']).assertUndefined();
      expect(params['matrix']).not().assertNull();
    });

    it('dealMutators returns early when stack is null', 0, () => {
      const view = new FlutterMutatorView();
      (view as Any).mutatorsStack = null;
      let threw = false;
      try {
        (view as Any).dealMutators();
      } catch (e) {
        threw = true;
      }
      expect(threw).assertEqual(false);
    });

    it('setLayoutParams replaces null params with a fresh instance', 0, () => {
      const view = new FlutterMutatorView();
      (view as Any).model.params = null;
      const parameters = new DVModelParameters() as Record<string, Any>;
      parameters['marginLeft'] = 11;
      parameters['marginTop'] = 22;
      parameters['width'] = 33;
      parameters['height'] = 44;
      view.setLayoutParams(parameters as Any as DVModelParameters);
      const params = view.getDvModel()!.params as Record<string, Any>;
      expect(params['width']).assertEqual(33);
    });
  });

  describe('FlutterMutatorView.onTouch.branches', () => {
    it('Down/Move/Up touch types translate params without throwing', 0, () => {
      const view = new FlutterMutatorView();
      const parameters = new DVModelParameters() as Record<string, Any>;
      parameters['marginLeft'] = 3;
      parameters['marginTop'] = 4;
      view.setLayoutParams(parameters as Any as DVModelParameters);
      const onTouch = (view as Any).onTouch as Function;
      let threw = false;
      try {
        onTouch({ type: TouchType.Down });
        onTouch({ type: TouchType.Move });
        onTouch({ type: TouchType.Up });
        onTouch({ type: TouchType.Cancel });
      } catch (e) {
        threw = true;
      }
      expect(threw).assertEqual(false);
      const params = view.getDvModel()!.params as Record<string, Any>;
      expect(params['translateX']).assertEqual(3);
    });

    it('addDvModel appends a child model', 0, () => {
      const view = new FlutterMutatorView();
      const child = new DVModel('row', new DVModelParameters(), new DVModelEvents(), new DVModelChildren());
      const before = view.getDvModel()!.children.length;
      view.addDvModel(child);
      expect(view.getDvModel()!.children.length).assertEqual(before + 1);
    });
  });
}
