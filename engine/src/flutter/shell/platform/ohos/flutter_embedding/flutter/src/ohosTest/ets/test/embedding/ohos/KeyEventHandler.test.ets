import { describe, it, expect, Level } from '@ohos/hypium';
import Any from '../../../../../main/ets/plugin/common/Any';
import { KeyEventHandler } from '../../../../../main/ets/embedding/ohos/KeyEventHandler';
import TextInputPlugin from '../../../../../main/ets/plugin/editing/TextInputPlugin';
import { KeyCode } from '@kit.InputKit';

class RecordingEditingState {
  inserted: string[] = [];
  deleteCodes: number[] = [];
  endDeletionCodes: number[] = [];
  handleInsertTextEvent(text: string): void {
    this.inserted.push(text);
  }
  startDeleting(code: number): void {
    this.deleteCodes.push(code);
  }
  endDeletion(code: number): void {
    this.endDeletionCodes.push(code);
  }
}

class FakeKeyHandlerPlugin {
  public recorder: RecordingEditingState = new RecordingEditingState();
  getEditingState(): RecordingEditingState {
    return this.recorder;
  }
}

class FakeKeyEventForHandler {
  keyCode: number;
  type: number;
  isCapsLockOn?: boolean;
  isNumLockOn?: boolean;
  private modifierStates: Map<string, boolean> = new Map();

  constructor(keyCode: number, isDown: boolean) {
    this.keyCode = keyCode;
    this.type = isDown ? 0 : 1;
  }

  setModifier(name: string, pressed: boolean): void {
    this.modifierStates.set(name, pressed);
  }

  setCapsLock(on: boolean): void {
    this.isCapsLockOn = on;
  }

  setNumLock(on: boolean): void {
    this.isNumLockOn = on;
  }

  getModifierKeyState(keys: string[]): boolean {
    for (const key of keys) {
      const state = this.modifierStates.get(key);
      if (state !== undefined) {
        return state;
      }
    }
    return false;
  }
}

class FakeBareKeyEvent {
  keyCode: number;
  type: number;
  constructor(keyCode: number, isDown: boolean) {
    this.keyCode = keyCode;
    this.type = isDown ? 0 : 1;
  }
}

class FakeThrowingModifierEvent extends FakeKeyEventForHandler {
  getModifierKeyState(keys: string[]): boolean {
    throw new Error('modifier getter failed');
  }
}

class HandlerFixture {
  public handler: KeyEventHandler;
  public plugin: FakeKeyHandlerPlugin;
  constructor() {
    this.plugin = new FakeKeyHandlerPlugin();
    this.handler = new KeyEventHandler(this.plugin as Any as TextInputPlugin);
  }
}

export default function keyEventHandlerTest() {
  describe('KeyEventHandler.construct', () => {
    it('constructsWithoutCrash', Level.LEVEL1, () => {
      const handler: KeyEventHandler = new KeyEventHandler();
      expect(handler).not().assertNull();
    });

    it('constructsWithUndefinedTextInputPlugin', Level.LEVEL1, () => {
      const handler: KeyEventHandler = new KeyEventHandler(undefined);
      expect(handler).not().assertNull();
    });
  });

  describe('KeyEventHandler.startDeleting', () => {
    it('doesNotCrashWithoutTextInputPlugin on startDeleting', Level.LEVEL0, () => {
      const handler: KeyEventHandler = new KeyEventHandler();
      handler.startDeleting(KeyCode.KEYCODE_DEL);
    });
  });

  describe('KeyEventHandler.endDeletion', () => {
    it('doesNotCrashWithoutTextInputPlugin on endDeletion', Level.LEVEL0, () => {
      const handler: KeyEventHandler = new KeyEventHandler();
      handler.endDeletion(KeyCode.KEYCODE_DEL);
    });
  });

  describe('KeyEventHandler.startDeleting.with.various.codes', () => {
    it('doesNotCrashWithKeyCodeBack', Level.LEVEL1, () => {
      const handler: KeyEventHandler = new KeyEventHandler();
      let threw = false;
      try { handler.startDeleting(KeyCode.KEYCODE_BACK); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('endDeletion with KeyCodeEnter does not crash', Level.LEVEL1, () => {
      const handler: KeyEventHandler = new KeyEventHandler();
      let threw = false;
      try { handler.endDeletion(KeyCode.KEYCODE_ENTER); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });
  });

  describe('KeyEventHandler.static.keyTextMap.access', () => {
    // Bracket access of the private static field forces class load and
    // initializer execution. ArkTS strict mode may disallow private field
    // bracket access, so we use the typed class reference.
    it('bracket access to keyTextMap does not throw', Level.LEVEL1, () => {
      const cls: Any = KeyEventHandler as Any;
      let threw = false;
      try {
        const m: Any = cls['keyTextMap'];
        expect(m !== undefined).assertEqual(true);
      } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('multiple constructors do not throw', Level.LEVEL1, () => {
      let threw = false;
      try {
        new KeyEventHandler();
        new KeyEventHandler();
        new KeyEventHandler(undefined);
      } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });
  });

  describe('KeyEventHandler.getKeyText.real', () => {
    it('returns lowercase for plain letter key', Level.LEVEL0, () => {
      const handler = new KeyEventHandler();
      const event = new FakeKeyEventForHandler(KeyCode.KEYCODE_A, true);
      expect(handler.getKeyText(event as Any as KeyEvent)).assertEqual('a');
    });

    it('returns uppercase for letter key with Shift', Level.LEVEL0, () => {
      const handler = new KeyEventHandler();
      const event = new FakeKeyEventForHandler(KeyCode.KEYCODE_A, true);
      event.setModifier('Shift', true);
      expect(handler.getKeyText(event as Any as KeyEvent)).assertEqual('A');
    });

    it('returns uppercase for letter key with CapsLock', Level.LEVEL0, () => {
      const handler = new KeyEventHandler();
      const event = new FakeKeyEventForHandler(KeyCode.KEYCODE_A, true);
      event.setCapsLock(true);
      expect(handler.getKeyText(event as Any as KeyEvent)).assertEqual('A');
    });

    it('returns lowercase for letter key with CapsLock and Shift', Level.LEVEL0, () => {
      const handler = new KeyEventHandler();
      const event = new FakeKeyEventForHandler(KeyCode.KEYCODE_A, true);
      event.setCapsLock(true);
      event.setModifier('Shift', true);
      expect(handler.getKeyText(event as Any as KeyEvent)).assertEqual('a');
    });

    it('returns shift symbol for digit key with Shift', Level.LEVEL0, () => {
      const handler = new KeyEventHandler();
      const event = new FakeKeyEventForHandler(KeyCode.KEYCODE_1, true);
      event.setModifier('Shift', true);
      expect(handler.getKeyText(event as Any as KeyEvent)).assertEqual('!');
    });

    it('returns plain digit without Shift', Level.LEVEL0, () => {
      const handler = new KeyEventHandler();
      const event = new FakeKeyEventForHandler(KeyCode.KEYCODE_1, true);
      expect(handler.getKeyText(event as Any as KeyEvent)).assertEqual('1');
    });

    it('returns shift case for symbol key with Shift', Level.LEVEL0, () => {
      const handler = new KeyEventHandler();
      const event = new FakeKeyEventForHandler(KeyCode.KEYCODE_GRAVE, true);
      event.setModifier('Shift', true);
      expect(handler.getKeyText(event as Any as KeyEvent)).assertEqual('~');
    });

    it('returns empty string for unmapped keyCode', Level.LEVEL0, () => {
      const handler = new KeyEventHandler();
      const event = new FakeKeyEventForHandler(99999, true);
      expect(handler.getKeyText(event as Any as KeyEvent)).assertEqual('');
    });

    it('treats missing CapsLock field as off', Level.LEVEL0, () => {
      const handler = new KeyEventHandler();
      const event = new FakeBareKeyEvent(KeyCode.KEYCODE_A, true);
      expect(handler.getKeyText(event as Any as KeyEvent)).assertEqual('a');
    });

    it('returns digit text for numpad key', Level.LEVEL0, () => {
      const handler = new KeyEventHandler();
      const event = new FakeKeyEventForHandler(KeyCode.KEYCODE_NUMPAD_0, true);
      expect(handler.getKeyText(event as Any as KeyEvent)).assertEqual('0');
    });
  });

  describe('KeyEventHandler.handleKeyEvent.real', () => {
    it('ignores key up events', Level.LEVEL0, () => {
      const fx = new HandlerFixture();
      const event = new FakeKeyEventForHandler(KeyCode.KEYCODE_A, false);
      fx.handler.handleKeyEvent(event as Any as KeyEvent);
      expect(fx.plugin.recorder.inserted.length).assertEqual(0);
    });

    it('inserts newline for Enter key down', Level.LEVEL0, () => {
      const fx = new HandlerFixture();
      const event = new FakeKeyEventForHandler(KeyCode.KEYCODE_ENTER, true);
      fx.handler.handleKeyEvent(event as Any as KeyEvent);
      expect(fx.plugin.recorder.inserted.length).assertEqual(1);
      expect(fx.plugin.recorder.inserted[0]).assertEqual('\n');
    });

    it('inserts newline for numpad Enter key down', Level.LEVEL0, () => {
      const fx = new HandlerFixture();
      const event = new FakeKeyEventForHandler(KeyCode.KEYCODE_NUMPAD_ENTER, true);
      fx.handler.handleKeyEvent(event as Any as KeyEvent);
      expect(fx.plugin.recorder.inserted.length).assertEqual(1);
      expect(fx.plugin.recorder.inserted[0]).assertEqual('\n');
    });

    it('inserts nothing without textInputPlugin for Enter', Level.LEVEL0, () => {
      const handler = new KeyEventHandler();
      const event = new FakeKeyEventForHandler(KeyCode.KEYCODE_ENTER, true);
      let threw = false;
      try {
        handler.handleKeyEvent(event as Any as KeyEvent);
      } catch (e) {
        threw = true;
      }
      expect(threw).assertEqual(false);
    });

    it('blocks numpad digit when NumLock is off', Level.LEVEL0, () => {
      const fx = new HandlerFixture();
      const event = new FakeKeyEventForHandler(KeyCode.KEYCODE_NUMPAD_0, true);
      event.setNumLock(false);
      fx.handler.handleKeyEvent(event as Any as KeyEvent);
      expect(fx.plugin.recorder.inserted.length).assertEqual(0);
    });

    it('inserts numpad digit when NumLock is on', Level.LEVEL0, () => {
      const fx = new HandlerFixture();
      const event = new FakeKeyEventForHandler(KeyCode.KEYCODE_NUMPAD_0, true);
      event.setNumLock(true);
      fx.handler.handleKeyEvent(event as Any as KeyEvent);
      expect(fx.plugin.recorder.inserted.length).assertEqual(1);
      expect(fx.plugin.recorder.inserted[0]).assertEqual('0');
    });

    it('does not insert letter when Ctrl is pressed', Level.LEVEL0, () => {
      const fx = new HandlerFixture();
      const event = new FakeKeyEventForHandler(KeyCode.KEYCODE_A, true);
      event.setModifier('Ctrl', true);
      fx.handler.handleKeyEvent(event as Any as KeyEvent);
      expect(fx.plugin.recorder.inserted.length).assertEqual(0);
    });

    it('does not insert letter when Alt is pressed', Level.LEVEL0, () => {
      const fx = new HandlerFixture();
      const event = new FakeKeyEventForHandler(KeyCode.KEYCODE_A, true);
      event.setModifier('Alt', true);
      fx.handler.handleKeyEvent(event as Any as KeyEvent);
      expect(fx.plugin.recorder.inserted.length).assertEqual(0);
    });

    it('inserts letter text on plain key down', Level.LEVEL0, () => {
      const fx = new HandlerFixture();
      const event = new FakeKeyEventForHandler(KeyCode.KEYCODE_A, true);
      fx.handler.handleKeyEvent(event as Any as KeyEvent);
      expect(fx.plugin.recorder.inserted.length).assertEqual(1);
      expect(fx.plugin.recorder.inserted[0]).assertEqual('a');
    });

    it('does not insert for unmapped keyCode', Level.LEVEL0, () => {
      const fx = new HandlerFixture();
      const event = new FakeKeyEventForHandler(99999, true);
      fx.handler.handleKeyEvent(event as Any as KeyEvent);
      expect(fx.plugin.recorder.inserted.length).assertEqual(0);
    });

    it('missing modifier getter is treated as not pressed', Level.LEVEL0, () => {
      const fx = new HandlerFixture();
      const event = new FakeBareKeyEvent(KeyCode.KEYCODE_A, true);
      fx.handler.handleKeyEvent(event as Any as KeyEvent);
      expect(fx.plugin.recorder.inserted.length).assertEqual(1);
      expect(fx.plugin.recorder.inserted[0]).assertEqual('a');
    });

    it('modifier getter throwing is caught and treated as not pressed', Level.LEVEL0, () => {
      const fx = new HandlerFixture();
      const event = new FakeThrowingModifierEvent(KeyCode.KEYCODE_A, true);
      let threw = false;
      try {
        fx.handler.handleKeyEvent(event as Any as KeyEvent);
      } catch (e) {
        threw = true;
      }
      expect(threw).assertEqual(false);
      expect(fx.plugin.recorder.inserted.length).assertEqual(1);
      expect(fx.plugin.recorder.inserted[0]).assertEqual('a');
    });
  });

  describe('KeyEventHandler.deletion.withPlugin', () => {
    it('startDeleting forwards code to editing state', Level.LEVEL0, () => {
      const fx = new HandlerFixture();
      fx.handler.startDeleting(KeyCode.KEYCODE_DEL);
      expect(fx.plugin.recorder.deleteCodes.length).assertEqual(1);
      expect(fx.plugin.recorder.deleteCodes[0]).assertEqual(KeyCode.KEYCODE_DEL);
    });

    it('endDeletion forwards code to editing state', Level.LEVEL0, () => {
      const fx = new HandlerFixture();
      fx.handler.endDeletion(KeyCode.KEYCODE_DEL);
      expect(fx.plugin.recorder.endDeletionCodes.length).assertEqual(1);
      expect(fx.plugin.recorder.endDeletionCodes[0]).assertEqual(KeyCode.KEYCODE_DEL);
    });
  });
}
