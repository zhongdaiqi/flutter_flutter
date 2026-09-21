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
import FlutterEngine from '../../../../../main/ets/embedding/engine/FlutterEngine';
import FlutterEngineCache from '../../../../../main/ets/embedding/engine/FlutterEngineCache';

export default function FlutterEngineCacheTest() {
  const flutterEngineCache: FlutterEngineCache = new FlutterEngineCache();

  describe('FlutterEngineCacheTest', () => {

    it('getInstance', 0, async (done: Function) => {
      console.info("uitest: getInstance begin");
      const getInstance: FlutterEngineCache = FlutterEngineCache.getInstance();
      expect(getInstance).not().assertNull();
      done();
    })

    it('contains', 0, async (done: Function) => {
      console.info("uitest: contains begin");
      const contains: boolean = flutterEngineCache.contains('test');
      expect(contains).not().assertNull();
      done();
    })

    it('get', 0, async (done: Function) => {
      console.info("uitest: contains begin");
      const get: FlutterEngine | null = flutterEngineCache.get('test');
      if(get) {
        expect(get).not().assertNull();
      }
      done();
    })

    it('contains returns false for unknown id', 0, () => {
      const r = flutterEngineCache.contains('non-existent-id-12345');
      expect(r).assertEqual(false);
    });

    it('get returns null for unknown id', 0, () => {
      const r = flutterEngineCache.get('non-existent-id-12345');
      expect(r).assertNull();
    });

    it('getInstance returns same instance on second call', 0, () => {
      const a = FlutterEngineCache.getInstance();
      const b = FlutterEngineCache.getInstance();
      expect(a === b).assertEqual(true);
    });

    it('put stores engine and get returns the same instance', 0, () => {
      const engine = {} as Any as FlutterEngine;
      flutterEngineCache.put('cache-put-id', engine);
      expect(flutterEngineCache.contains('cache-put-id')).assertEqual(true);
      expect(flutterEngineCache.get('cache-put-id') === engine).assertEqual(true);
    });

    it('put with null removes the engine', 0, () => {
      const engine = {} as Any as FlutterEngine;
      flutterEngineCache.put('cache-null-id', engine);
      flutterEngineCache.put('cache-null-id', null);
      expect(flutterEngineCache.contains('cache-null-id')).assertEqual(false);
      expect(flutterEngineCache.get('cache-null-id')).assertNull();
    });

    it('containsEngine finds stored instance and rejects unknown instance', 0, () => {
      const engineA = {} as Any as FlutterEngine;
      const engineB = {} as Any as FlutterEngine;
      const outsider = {} as Any as FlutterEngine;
      flutterEngineCache.put('cache-engine-a', engineA);
      flutterEngineCache.put('cache-engine-b', engineB);
      expect(flutterEngineCache.containsEngine(engineA)).assertEqual(true);
      expect(flutterEngineCache.containsEngine(engineB)).assertEqual(true);
      expect(flutterEngineCache.containsEngine(outsider)).assertEqual(false);
    });

    it('containsEngine on empty cache returns false', 0, () => {
      const localCache = new FlutterEngineCache();
      expect(localCache.containsEngine({} as Any as FlutterEngine)).assertEqual(false);
    });

    it('put overwrites previous engine for same id', 0, () => {
      const first = {} as Any as FlutterEngine;
      const second = {} as Any as FlutterEngine;
      flutterEngineCache.put('cache-overwrite-id', first);
      flutterEngineCache.put('cache-overwrite-id', second);
      expect(flutterEngineCache.get('cache-overwrite-id') === second).assertEqual(true);
      expect(flutterEngineCache.containsEngine(first)).assertEqual(false);
    });

    it('remove deletes engine by id', 0, () => {
      const engine = {} as Any as FlutterEngine;
      flutterEngineCache.put('cache-remove-id', engine);
      flutterEngineCache.remove('cache-remove-id');
      expect(flutterEngineCache.contains('cache-remove-id')).assertEqual(false);
    });

    it('clear empties all cached engines', 0, () => {
      flutterEngineCache.put('cache-clear-1', {} as Any as FlutterEngine);
      flutterEngineCache.put('cache-clear-2', {} as Any as FlutterEngine);
      flutterEngineCache.clear();
      expect(flutterEngineCache.contains('cache-clear-1')).assertEqual(false);
      expect(flutterEngineCache.contains('cache-clear-2')).assertEqual(false);
    });
  })
}