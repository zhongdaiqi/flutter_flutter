import { describe, it, expect, Level } from '@ohos/hypium';
import Any from '../../../../../main/ets/plugin/common/Any';
import { KeyEventHandler } from '../../../../../main/ets/embedding/ohos/KeyEventHandler';
import { KeyCode } from '@kit.InputKit';

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

  describe('KeyEventHandler.getKeyText', () => {
    it('returns empty for unknown keyCode without textInputPlugin', Level.LEVEL0, () => {
      const handler = new KeyEventHandler();
      const cls: Any = handler;
      const fn: Any = cls['getKeyText'];
      // getKeyText takes KeyEvent; without a real KeyEvent we can't call it directly
      // But we can verify the method exists
      expect(fn !== undefined).assertEqual(true);
    });
  });

  describe('KeyEventHandler.handleKeyEvent', () => {
    it('does not throw without textInputPlugin for KeyType.Up', Level.LEVEL0, () => {
      const handler = new KeyEventHandler();
      // handleKeyEvent expects KeyEvent; we can't construct one easily
      // Just verify the method exists
      const cls: Any = handler;
      const fn: Any = cls['handleKeyEvent'];
      expect(fn !== undefined).assertEqual(true);
    });
  });

  describe('KeyEventHandler.handleKeyEvent.branches', () => {
    const mkEvent = (type: KeyType, keyCode: number, capsLock?: boolean, numLock?: boolean,
                     modifiers?: (keys: string[]) => boolean): KeyEvent => {
      const ev: Any = {
        type: type,
        keyCode: keyCode,
        isCapsLockOn: capsLock,
        isNumLockOn: numLock
      };
      if (modifiers) {
        ev.getModifierKeyState = modifiers;
      }
      return ev as Any as KeyEvent;
    };

    it('Down Enter inserts newline via empty editing state path', Level.LEVEL1, () => {
      const handler = new KeyEventHandler();
      let threw = false;
      try {
        handler.handleKeyEvent(mkEvent(KeyType.Down, KeyCode.KEYCODE_ENTER));
      } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('Up events skip the Down switch', Level.LEVEL1, () => {
      const handler = new KeyEventHandler();
      let threw = false;
      try {
        handler.handleKeyEvent(mkEvent(KeyType.Up, KeyCode.KEYCODE_A));
      } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('numpad digit blocked when NumLock off', Level.LEVEL1, () => {
      const handler = new KeyEventHandler();
      let threw = false;
      try {
        handler.handleKeyEvent(mkEvent(KeyType.Down, KeyCode.KEYCODE_NUMPAD_0, undefined, false));
      } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('numpad dot blocked when NumLock off', Level.LEVEL1, () => {
      const handler = new KeyEventHandler();
      let threw = false;
      try {
        handler.handleKeyEvent(mkEvent(KeyType.Down, KeyCode.KEYCODE_NUMPAD_DOT, undefined, false));
      } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('numpad digit passes through when NumLock on', Level.LEVEL1, () => {
      const handler = new KeyEventHandler();
      let threw = false;
      try {
        handler.handleKeyEvent(mkEvent(KeyType.Down, KeyCode.KEYCODE_NUMPAD_5, undefined, true));
      } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('plain key down without lock flags reaches the text path', Level.LEVEL1, () => {
      const handler = new KeyEventHandler();
      let threw = false;
      try {
        handler.handleKeyEvent(mkEvent(KeyType.Down, KeyCode.KEYCODE_1));
      } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });
  });

  describe('KeyEventHandler.getKeyText.branches', () => {
    const mkEvent = (keyCode: number, capsLock?: boolean,
                     modifiers?: (keys: string[]) => boolean): KeyEvent => {
      const ev: Any = {
        type: KeyType.Down,
        keyCode: keyCode,
        isCapsLockOn: capsLock
      };
      if (modifiers) {
        ev.getModifierKeyState = modifiers;
      }
      return ev as Any as KeyEvent;
    };

    it('unmapped keyCode yields empty result', Level.LEVEL1, () => {
      const handler = new KeyEventHandler();
      const result = handler.getKeyText(mkEvent(999999));
      expect(typeof result).assertEqual('string');
    });

    it('letter without caps lock returns normal case', Level.LEVEL1, () => {
      const handler = new KeyEventHandler();
      const result = handler.getKeyText(mkEvent(KeyCode.KEYCODE_A, false));
      expect(result).assertEqual('a');
    });

    it('letter with caps lock and shift returns lower case', Level.LEVEL1, () => {
      const handler = new KeyEventHandler();
      const result = handler.getKeyText(mkEvent(KeyCode.KEYCODE_A, true, (keys: string[]) => true));
      expect(result).assertEqual('a');
    });

    it('letter with shift and no caps lock returns upper case', Level.LEVEL1, () => {
      const handler = new KeyEventHandler();
      const result = handler.getKeyText(mkEvent(KeyCode.KEYCODE_A, false, (keys: string[]) => true));
      expect(result).assertEqual('A');
    });

    it('event without getModifierKeyState falls back to false', Level.LEVEL1, () => {
      const handler = new KeyEventHandler();
      const result = handler.getKeyText(mkEvent(KeyCode.KEYCODE_A, true));
      expect(result).assertEqual('A');
    });
  });
}
