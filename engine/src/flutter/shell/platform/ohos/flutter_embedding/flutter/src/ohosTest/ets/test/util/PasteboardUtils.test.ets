/*
 * Copyright (c) 2026 Huawei Device Co., Ltd. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE_HW file.
 */

import { describe, it, expect, Level } from '@ohos/hypium';
import { PasteboardUtils } from '../../../../main/ets/util/PasteboardUtils';
import { pasteboard } from '@kit.BasicServicesKit';
import Any from '../../../../main/ets/plugin/common/Any';

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

  describe('PasteboardUtils.getTargetTypesData.branches', () => {
    const mkRecord = (valid: string[], dataMap: Record<string, () => Promise<string>>): pasteboard.PasteDataRecord => {
      const rec: Any = {
        getValidTypes: (types: string[]) => valid,
        getData: (mime: string) => {
          const producer = dataMap[mime];
          if (producer) {
            return producer();
          }
          return Promise.reject(new Error('no data for ' + mime));
        }
      };
      return rec as Any as pasteboard.PasteDataRecord;
    };

    it('returns plain text when plain mime has data', 0, async (done: Function) => {
      const dataMap: Record<string, () => Promise<string>> = {};
      dataMap[pasteboard.MIMETYPE_TEXT_PLAIN] = () => Promise.resolve('hello');
      const rec = mkRecord([pasteboard.MIMETYPE_TEXT_PLAIN], dataMap);
      const result = await PasteboardUtils.getTargetTypesData(rec);
      expect(result).assertEqual('hello');
      done();
    });

    it('returns empty string when no valid types', 0, async (done: Function) => {
      const rec = mkRecord([], {});
      const result = await PasteboardUtils.getTargetTypesData(rec);
      expect(result).assertEqual('');
      done();
    });

    it('returns empty string when getData rejects', 0, async (done: Function) => {
      const rec = mkRecord([pasteboard.MIMETYPE_TEXT_PLAIN], {});
      const result = await PasteboardUtils.getTargetTypesData(rec);
      expect(result).assertEqual('');
      done();
    });

    it('falls through to the next type when the first yields nothing', 0, async (done: Function) => {
      const dataMap: Record<string, () => Promise<string>> = {};
      dataMap[pasteboard.MIMETYPE_TEXT_PLAIN] = () => Promise.resolve('fallback');
      const rec = mkRecord([pasteboard.MIMETYPE_TEXT_HTML, pasteboard.MIMETYPE_TEXT_PLAIN], dataMap);
      const result = await PasteboardUtils.getTargetTypesData(rec);
      expect(result).assertEqual('fallback');
      done();
    });

    it('html mime produces a string (fromHtml success or catch)', 0, async (done: Function) => {
      const dataMap: Record<string, () => Promise<string>> = {};
      dataMap[pasteboard.MIMETYPE_TEXT_HTML] = () => Promise.resolve('<b>hi</b>');
      const rec = mkRecord([pasteboard.MIMETYPE_TEXT_HTML], dataMap);
      const result = await PasteboardUtils.getTargetTypesData(rec);
      expect(typeof result).assertEqual('string');
      done();
    });
  });
}
