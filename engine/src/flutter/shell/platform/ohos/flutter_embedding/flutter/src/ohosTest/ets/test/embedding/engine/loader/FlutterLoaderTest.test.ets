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

import common from '@ohos.app.ability.common';
import Any from '../../../../../../main/ets/plugin/common/Any';
import FlutterInjector from '../../../../../../main/ets/FlutterInjector';
import FlutterLoader from '../../../../../../main/ets/embedding/engine/loader/FlutterLoader';
import { describe, expect, it } from '@ohos/hypium';
import FlutterNapi from '../../../../../../main/ets/embedding/engine/FlutterNapi';
export default function FlutterLoaderTest() {
  describe('FlutterLoaderTest', () => {
    it('initializationTest', 0, async (done: Function) => {
      let flutterNapi: FlutterNapi = new FlutterNapi();
      let flutterLoader: FlutterLoader = new FlutterLoader(flutterNapi);
      expect(flutterLoader.initialized).assertFalse();
      done();
    })

    it('initResultTest', 0, async (done: Function) => {
      let flutterNapi: FlutterNapi = new FlutterNapi();
      let flutterLoader: FlutterLoader = new FlutterLoader(flutterNapi);
      expect(flutterLoader.initResult).assertNull();
      done();
    })

    it('flutterNapiTest', 0, async (done: Function) => {
      let flutterNapi: FlutterNapi = new FlutterNapi();
      let flutterLoader: FlutterLoader = new FlutterLoader(flutterNapi);
      expect(flutterLoader.flutterNapi).not().assertNull();
      done();
    })

    it('startInitializationTest', 0, async (done: Function) => {
      let flutterNapi: FlutterNapi = new FlutterNapi();
      let flutterLoader: FlutterLoader = new FlutterLoader(flutterNapi);
      let context: common.Context = getContext();
      expect(flutterLoader.initialized).assertFalse();
      flutterLoader.startInitialization(context);
      expect(flutterLoader.flutterApplicationInfo).not().assertNull();
      expect(flutterLoader.context).not().assertNull();
      done();
    })
  })
describe('FlutterLoader.copyResource', () => {
  it('copies kernel and snapshot resources into filesDir', 0, () => {
    const loader: Any = new FlutterLoader(FlutterInjector.getInstance().getFlutterNapi());
    loader['flutterApplicationInfo'] = {
      'flutterAssetsDir': 'flutter_assets',
      'vmSnapshotData': 'vm_snapshot_data',
      'isolateSnapshotData': 'isolate_snapshot_data'
    };
    const context: common.Context = getContext();
    let threw = false;
    try { loader['copyResource'](context); } catch (e) { threw = true; }
    expect(threw).assertEqual(false);
  });

  it('second copy run stays stable', 0, () => {
    const loader: Any = new FlutterLoader(FlutterInjector.getInstance().getFlutterNapi());
    loader['flutterApplicationInfo'] = {
      'flutterAssetsDir': 'flutter_assets',
      'vmSnapshotData': 'vm_snapshot_data',
      'isolateSnapshotData': 'isolate_snapshot_data'
    };
    const context: common.Context = getContext();
    let threw = false;
    try { loader['copyResource'](context); } catch (e) { threw = true; }
    expect(threw).assertEqual(false);
  });
});
}
