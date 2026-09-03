/*
 * Copyright (c) 2026 Huawei Device Co., Ltd. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE_HW file.
 */

import { describe, it, expect, Level } from '@ohos/hypium';
import Any from '../../../../main/ets/plugin/common/Any';
import { pasteboard } from '@kit.BasicServicesKit';
import { PasteboardUtils } from '../../../../main/ets/util/PasteboardUtils';

export default function pasteboardUtilsTest() {
  describe('PasteboardUtils.setCopyData', () => {
    it('does not throw for plain ASCII text', Level.LEVEL0, () => {
      let threw = false;
      try { PasteboardUtils.setCopyData('hello world'); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('does not throw for empty string', Level.LEVEL1, () => {
      let threw = false;
      try { PasteboardUtils.setCopyData(''); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('does not throw for unicode text', Level.LEVEL1, () => {
      let threw = false;
      try { PasteboardUtils.setCopyData('你好世界😀'); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('does not throw for multiline text', Level.LEVEL1, () => {
      let threw = false;
      try { PasteboardUtils.setCopyData('line1\nline2\nline3'); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });
  });

  describe('PasteboardUtils.getPasteDataAsync', () => {
    it('returns a Promise', Level.LEVEL0, () => {
      const p = PasteboardUtils.getPasteDataAsync();
      expect(p).not().assertNull();
      expect(typeof p.then).assertEqual('function');
    });

    it('resolves to a string (eventually)', Level.LEVEL1, async (done: Function) => {
      try {
        const text = await PasteboardUtils.getPasteDataAsync();
        expect(typeof text).assertEqual('string');
      } catch (e) {
        // tolerated: in unit-test env, permission request may fail
      }
      done();
    });
  });

describe('PasteboardUtils.getTargetTypesData', () => {
  class FakePasteRecord {
    private types: string[];
    private value: string;
    private fail: boolean;

    constructor(types: string[], value: string, fail: boolean) {
      this.types = types;
      this.value = value;
      this.fail = fail;
    }

    getValidTypes(_types: string[]): string[] {
      return this.types;
    }

    async getData(_type: string): Promise<string> {
      if (this.fail) {
        throw new Error('no data');
      }
      return this.value;
    }
  }

  it('returns plain text for plain record', 0, async (done: Function) => {
    const record = new FakePasteRecord(['text/plain'], 'hello', false);
    const result = await PasteboardUtils.getTargetTypesData(record as Any as pasteboard.PasteDataRecord);
    expect(result).assertEqual('hello');
    done();
  });

  it('returns empty string when no valid types', 0, async (done: Function) => {
    const record = new FakePasteRecord([], '', false);
    const result = await PasteboardUtils.getTargetTypesData(record as Any as pasteboard.PasteDataRecord);
    expect(result).assertEqual('');
    done();
  });

  it('returns empty string when getData throws', 0, async (done: Function) => {
    const record = new FakePasteRecord(['text/plain'], '', true);
    const result = await PasteboardUtils.getTargetTypesData(record as Any as pasteboard.PasteDataRecord);
    expect(result).assertEqual('');
    done();
  });

  it('converts html record to text', 0, async (done: Function) => {
    const record = new FakePasteRecord(['text/html'], '<b>bold</b>', false);
    const result = await PasteboardUtils.getTargetTypesData(record as Any as pasteboard.PasteDataRecord);
    expect(result.length > 0).assertTrue();
    done();
  });

  it('skips empty first type then returns later plain text', 0, async (done: Function) => {
    class MultiRecord {
      getValidTypes(_types: string[]): string[] {
        return ['text/html', 'text/plain'];
      }
      async getData(type: string): Promise<string> {
        if (type === 'text/html') {
          return '';
        }
        return 'fallback-plain';
      }
    }
    const result = await PasteboardUtils.getTargetTypesData(new MultiRecord() as Any as pasteboard.PasteDataRecord);
    expect(result).assertEqual('fallback-plain');
    done();
  });

  it('swallows html fromHtml failure and keeps empty', 0, async (done: Function) => {
    class BadHtmlRecord {
      getValidTypes(_types: string[]): string[] {
        return ['text/html'];
      }
      async getData(_type: string): Promise<string> {
        return '<not-really-html';
      }
    }
    const result = await PasteboardUtils.getTargetTypesData(new BadHtmlRecord() as Any as pasteboard.PasteDataRecord);
    expect(result).assertEqual('');
    done();
  });
});
}
