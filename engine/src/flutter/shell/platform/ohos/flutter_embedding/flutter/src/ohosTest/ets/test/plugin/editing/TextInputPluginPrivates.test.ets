/*
 * Copyright (c) 2026 Huawei Device Co., Ltd. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE_HW file.
 */

import { describe, it, expect } from '@ohos/hypium';
import Any from '../../../../../main/ets/plugin/common/Any';
import common from '@ohos.app.ability.common';
import inputMethod from '@ohos.inputMethod';
import { PointerDeviceKind } from '../../../../../main/ets/embedding/ohos/OhosTouchProcessor';
import DartExecutor from '../../../../../main/ets/embedding/engine/dart/DartExecutor';
import TextInputChannel from '../../../../../main/ets/embedding/engine/systemchannels/TextInputChannel';
import TextInputPluginDefault from '../../../../../main/ets/plugin/editing/TextInputPlugin';
import FlutterInjector from '../../../../../main/ets/FlutterInjector';

export default function textInputPluginPrivatesTest() {
  // ===== Supplement (2026-08-29): state-driven behaviour via injected handler state =====
  describe('TextInputMethodHandlerImpl.stateBehaviour', () => {
    const buildHandler = (): Any => {
      const context: common.Context = getContext();
      const assetManager = context.resourceManager;
      const flutterNapi = FlutterInjector.getInstance().getFlutterNapi();
      const dartExecutor = new DartExecutor(flutterNapi, assetManager);
      dartExecutor.onAttachedToNAPI();
      const textInputChannel = new TextInputChannel(dartExecutor);
      const plugin = new TextInputPluginDefault(textInputChannel, "test_view", undefined);
      return (plugin as Any)['mTextInputHandler'];
    };

    const setPlatformViewTarget = (h: Any, id: number): void => {
      const target: Any = { type: 3, id: id };
      h.inputTarget = target;
      h.keyboardFocusState = true;
      h.suppressNextHideForPhysicalPlatformView = true;
      h.pendingTeardownPlatformViewClientId = -1;
    };

    it('clearPlatformViewClient resets a matching platform view target', 0, () => {
      const h: Any = buildHandler();
      setPlatformViewTarget(h, 5);
      h.clearPlatformViewClient(5);
      expect((h.inputTarget as Any).type).assertEqual(0);
      expect((h.inputTarget as Any).id).assertEqual(0);
      expect(h.keyboardFocusState).assertEqual(false);
      expect(h.suppressNextHideForPhysicalPlatformView).assertEqual(false);
      expect(h.pendingTeardownPlatformViewClientId).assertEqual(-1);
    });

    it('clearPlatformViewClient ignores other view ids', 0, () => {
      const h: Any = buildHandler();
      setPlatformViewTarget(h, 5);
      h.clearPlatformViewClient(9);
      expect((h.inputTarget as Any).type).assertEqual(3);
      expect((h.inputTarget as Any).id).assertEqual(5);
    });

    it('clearPlatformViewClient ignores framework targets', 0, () => {
      const h: Any = buildHandler();
      const fw5: Any = { type: 1, id: 5 };
      h.inputTarget = fw5;
      h.clearPlatformViewClient(5);
      expect((h.inputTarget as Any).type).assertEqual(1);
    });

    it('clearPlatformViewClientForTeardown books the pending id when hidden', 0, () => {
      const h: Any = buildHandler();
      setPlatformViewTarget(h, 5);
      h.keyboardStatus = inputMethod.KeyboardStatus.HIDE;
      h.clearPlatformViewClientForTeardown(5);
      expect(h.pendingTeardownPlatformViewClientId).assertEqual(5);
      expect((h.inputTarget as Any).type).assertEqual(0);
      expect(h.keyboardFocusState).assertEqual(false);
      expect(h.keyboardStatus).assertEqual(inputMethod.KeyboardStatus.HIDE);
    });

    it('clearPlatformViewClientForTeardown ignores other view ids', 0, () => {
      const h: Any = buildHandler();
      setPlatformViewTarget(h, 5);
      h.clearPlatformViewClientForTeardown(9);
      expect(h.pendingTeardownPlatformViewClientId).assertEqual(-1);
      expect((h.inputTarget as Any).type).assertEqual(3);
    });

    it('isFrameworkTextInputActive follows the input target type', 0, () => {
      const h: Any = buildHandler();
      const fwTarget: Any = { type: 1, id: 2 };
      h.inputTarget = fwTarget;
      expect(h.isFrameworkTextInputActive()).assertEqual(true);
      const noTarget: Any = { type: 0, id: 0 };
      h.inputTarget = noTarget;
      expect(h.isFrameworkTextInputActive()).assertEqual(false);
    });

    it('getRequestReason maps device kinds to request reasons', 0, () => {
      const h: Any = buildHandler();
      h.configuration = null;
      expect(h.getRequestReason()).assertEqual(inputMethod.RequestKeyboardReason.NONE);
      const cfgTouch: Any = { deviceKind: PointerDeviceKind.TOUCH };
      h.configuration = cfgTouch;
      expect(h.getRequestReason()).assertEqual(inputMethod.RequestKeyboardReason.TOUCH);
      const cfgMouse: Any = { deviceKind: PointerDeviceKind.MOUSE };
      h.configuration = cfgMouse;
      expect(h.getRequestReason()).assertEqual(inputMethod.RequestKeyboardReason.MOUSE);
      const cfgStylus: Any = { deviceKind: PointerDeviceKind.STYLUS };
      h.configuration = cfgStylus;
      expect(h.getRequestReason()).assertEqual(inputMethod.RequestKeyboardReason.OTHER);
      const cfgTrackpad: Any = { deviceKind: PointerDeviceKind.TRACKPAD };
      h.configuration = cfgTrackpad;
      expect(h.getRequestReason()).assertEqual(inputMethod.RequestKeyboardReason.OTHER);
      const cfgUnknown: Any = { deviceKind: PointerDeviceKind.UNKNOWN };
      h.configuration = cfgUnknown;
      expect(h.getRequestReason()).assertEqual(inputMethod.RequestKeyboardReason.NONE);
    });

    it('needsAutofill reflects configuration presence', 0, () => {
      const h: Any = buildHandler();
      h.autofillConfiguration = null;
      expect(h.needsAutofill()).assertEqual(false);
      const autoCfg: Any = { fields: [] };
      h.autofillConfiguration = autoCfg;
      expect(h.needsAutofill()).assertEqual(true);
    });

    it('isSameAutofillGroup compares field identifiers', 0, () => {
      const h: Any = buildHandler();
      const autoCfg: Any = { fields: [] };
      h.autofillConfiguration = autoCfg;
      const mkField = (id: string): Any => {
        const af: Any = { uniqueIdentifier: id };
        const f: Any = { autofill: af };
        return f;
      };
      const baseFields: Any = { fields: [mkField('a'), mkField('b')] };
      h.configuration = baseFields;
      // Incoming configurations carry the focused field's autofill descriptor.
      const afA: Any = { uniqueIdentifier: 'a' };
      const same: Any = { fields: [mkField('b'), mkField('a')], autofill: afA };
      expect(h.isSameAutofillGroup(same)).assertEqual(true);
      const differentLength: Any = { fields: [mkField('a')], autofill: afA };
      expect(h.isSameAutofillGroup(differentLength)).assertEqual(false);
      const unknownId: Any = { fields: [mkField('a'), mkField('x')], autofill: afA };
      expect(h.isSameAutofillGroup(unknownId)).assertEqual(false);
      const emptyNext: Any = { fields: [], autofill: afA };
      expect(h.isSameAutofillGroup(emptyNext)).assertEqual(false);
      expect(h.isSameAutofillGroup(null)).assertEqual(false);
    });

    it('isSameAutofillGroup is false when autofill is not needed', 0, () => {
      const h: Any = buildHandler();
      h.autofillConfiguration = null;
      h.configuration = { fields: [] };
      const next: Any = { fields: [] };
      expect(h.isSameAutofillGroup(next)).assertEqual(false);
    });

    it('maybeRunPendingAutofillRequest keeps flags when autofill is off', 0, () => {
      const h: Any = buildHandler();
      h.autofillConfiguration = null;
      h.pendingAutofillAfterImeAttach = true;
      h.pendingAutofillRequest = true;
      h.maybeRunPendingAutofillRequest();
      expect(h.pendingAutofillAfterImeAttach).assertEqual(true);
      expect(h.pendingAutofillRequest).assertEqual(true);
    });

    it('maybeRunPendingAutofillRequest returns without pending flags', 0, () => {
      const h: Any = buildHandler();
      const autoCfg: Any = { fields: [] };
      h.autofillConfiguration = autoCfg;
      h.pendingAutofillAfterImeAttach = false;
      h.pendingAutofillRequest = false;
      let threw = false;
      try { h.maybeRunPendingAutofillRequest(); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
      expect(h.pendingAutofillAfterImeAttach).assertEqual(false);
    });

    it('notifyValueChanged stores text for the active autofill field', 0, () => {
      const h: Any = buildHandler();
      const autoCfg: Any = { fields: [] };
      h.autofillConfiguration = autoCfg;
      const af1: Any = { uniqueIdentifier: 'f1' };
      const cfgAf: Any = { autofill: af1 };
      h.configuration = cfgAf;
      h.autofillFieldTexts = new Map<string, string>();
      h.notifyValueChanged('hello');
      expect((h.autofillFieldTexts as Map<string, string>).get('f1')).assertEqual('hello');
    });

    it('notifyValueChanged is a no-op without autofill configuration', 0, () => {
      const h: Any = buildHandler();
      h.autofillConfiguration = null;
      h.configuration = null;
      h.autofillFieldTexts = new Map<string, string>();
      h.notifyValueChanged('hello');
      expect((h.autofillFieldTexts as Map<string, string>).size).assertEqual(0);
    });

    it('applyAutofillValues with empty map does nothing', 0, () => {
      const h: Any = buildHandler();
      let threw = false;
      try { h.applyAutofillValues(new Map<number, string>()); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('nodeIdFor returns zero for unknown identifiers', 0, () => {
      const h: Any = buildHandler();
      h.nodeIdMap = new Map<string, number>();
      expect(h.nodeIdFor('missing')).assertEqual(0);
      (h.nodeIdMap as Map<string, number>).set('known', 12);
      expect(h.nodeIdFor('known')).assertEqual(12);
    });
  });
}
