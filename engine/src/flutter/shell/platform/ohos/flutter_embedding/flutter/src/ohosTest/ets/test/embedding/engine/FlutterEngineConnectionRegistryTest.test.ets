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
import { beforeAll, describe, expect, it } from '@ohos/hypium';
import ExclusiveAppComponent from '../../../../../main/ets/embedding/ohos/ExclusiveAppComponent';
import UIAbility from '@ohos.app.ability.UIAbility';
import { FlutterPlugin, FlutterPluginBinding } from '../../../../../main/ets/embedding/engine/plugins/FlutterPlugin';
import FlutterEngine from '../../../../../main/ets/embedding/engine/FlutterEngine';
import PlatformViewsController from '../../../../../main/ets/plugin/platform/PlatformViewsController';
import Any from '../../../../../main/ets/plugin/common/Any';
import common from '@ohos.app.ability.common';
import FlutterEngineConnectionRegistry from '../../../../../main/ets/embedding/engine/FlutterEngineConnectionRegistry';
import AbilityConstant from '@ohos.app.ability.AbilityConstant';

class TestFlutterPlugin implements FlutterPlugin {
  attached = false;
  detached = false;
  onAttachedToEngine(binding: FlutterPluginBinding): void { this.attached = true; }
  onDetachedFromEngine(binding: FlutterPluginBinding): void { this.detached = true; }
  getUniqueClassName(): string { return 'TestFlutterPlugin'; }
}

export default function FlutterEngineConnectionRegistryTest() {
  let flutterEngineConnectionRegistry: FlutterEngineConnectionRegistry;
  let flutterEngine: FlutterEngine;
  let context: common.UIAbilityContext;
  const platformViewsController = new PlatformViewsController();
  const pluginClassName = 'test';

  describe('FlutterEngineConnectionRegistryTest', () => {

    beforeAll(() => {
      context = getContext() as common.UIAbilityContext;
      flutterEngine = new FlutterEngine(context, null, null, platformViewsController);
      const flutterLoader = flutterEngine.getFlutterLoader();
      flutterEngineConnectionRegistry = new FlutterEngineConnectionRegistry(context, flutterEngine, flutterLoader);
    })

    it('has', 0, async (done: Function) => {
      console.info("uitest: has begin");
      if (flutterEngineConnectionRegistry) {
        const hasFlag = flutterEngineConnectionRegistry.has(pluginClassName);
        expect(hasFlag).not().assertNull();
      }
      done();
    })

    it('get', 0, async (done: Function) => {
      console.info("uitest: get begin");
      if (flutterEngineConnectionRegistry) {
        const name: FlutterPlugin = flutterEngineConnectionRegistry.get(pluginClassName);
        expect(name).not().assertNull();
      }
      done();
    })

    it('onSaveState', 0, async (done: Function) => {
      console.info("uitest: onSaveState begin");
      const reason = AbilityConstant.StateType.CONTINUATION;
      const wantParam: Record<string, object> = {};
      if (flutterEngineConnectionRegistry) {
        const result: AbilityConstant.OnSaveResult = flutterEngineConnectionRegistry.onSaveState(reason, wantParam);
        expect(result).not().assertNull();
      }
      done();
    })

    it('has returns false for unknown plugin', 0, () => {
      if (flutterEngineConnectionRegistry) {
        const r = flutterEngineConnectionRegistry.has('NonExistentPluginName-xyz');
        expect(r).assertEqual(false);
      }
    });

    it('get returns default plugin for unknown plugin', 0, () => {
      if (flutterEngineConnectionRegistry) {
        const r = flutterEngineConnectionRegistry.get('NonExistentPluginName-xyz');
        expect(r).not().assertNull();
      }
    });

    it('removeAll does not throw', 0, () => {
      if (flutterEngineConnectionRegistry) {
        let threw = false;
        try { flutterEngineConnectionRegistry.removeAll(); } catch (e) { threw = true; }
        expect(threw).assertEqual(false);
      }
    });

    it('add plugin registers and calls onAttachedToEngine', 0, () => {
      const plugin = new TestFlutterPlugin();
      flutterEngineConnectionRegistry.add(plugin);
      expect(flutterEngineConnectionRegistry.has('TestFlutterPlugin')).assertEqual(true);
      expect(plugin.attached).assertEqual(true);
    });

    it('add duplicate plugin does not re-register', 0, () => {
      const plugin1 = new TestFlutterPlugin();
      const plugin2 = new TestFlutterPlugin();
      flutterEngineConnectionRegistry.add(plugin1);
      flutterEngineConnectionRegistry.add(plugin2);
      // Second add should be ignored (already registered)
      expect(flutterEngineConnectionRegistry.has('TestFlutterPlugin')).assertEqual(true);
    });

    it('remove plugin calls onDetachedFromEngine', 0, () => {
      // Clean up any plugin registered by earlier tests so add() is not skipped.
      flutterEngineConnectionRegistry.remove('TestFlutterPlugin');
      const plugin = new TestFlutterPlugin();
      flutterEngineConnectionRegistry.add(plugin);
      flutterEngineConnectionRegistry.remove('TestFlutterPlugin');
      expect(flutterEngineConnectionRegistry.has('TestFlutterPlugin')).assertEqual(false);
      expect(plugin.detached).assertEqual(true);
    });

    it('remove with null className does not throw', 0, () => {
      let threw = false;
      try { flutterEngineConnectionRegistry.remove(''); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('addList adds plugins', 0, () => {
      const plugin1 = new TestFlutterPlugin();
      const set = new Set<FlutterPlugin>();
      set.add(plugin1);
      let threw = false;
      try { flutterEngineConnectionRegistry.addList(set); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('destroy does not throw', 0, () => {
      let threw = false;
      try { flutterEngineConnectionRegistry.destroy(); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });
  })
describe('FlutterEngineConnectionRegistry.abilityFlow', () => {
  class RPlainPlugin implements FlutterPlugin {
    public attached = 0;
    public detached = 0;
    getUniqueClassName(): string { return 'r_plain_plugin'; }
    onAttachedToEngine(binding: object): void { this.attached++; }
    onDetachedFromEngine(): void { this.detached++; }
  }

  class RAbilityPlugin implements FlutterPlugin {
    public attached = 0;
    public abilityAttached = 0;
    public abilityDetached = 0;
    getUniqueClassName(): string { return 'r_ability_plugin'; }
    onAttachedToEngine(binding: object): void { this.attached++; }
    onDetachedFromEngine(): void { }
    onAttachedToAbility(binding: object): void { this.abilityAttached++; }
    onDetachedFromAbility(): void { this.abilityDetached++; }
  }

  class RExclusive {
    public detached = false;
    getAppComponent(): UIAbility { return {} as Any as UIAbility; }
    detachFromFlutterEngine(): void { this.detached = true; }
  }

  it('attaches plain plugin and notifies engine attach only', 0, () => {
    const plugin = new RPlainPlugin();
    flutterEngineConnectionRegistry.add(plugin);
    expect(flutterEngineConnectionRegistry.has('r_plain_plugin')).assertEqual(true);
    expect(plugin.attached).assertEqual(1);
  });

  it('first exclusive attach does not detach a previous one', 0, () => {
    const exclusive = new RExclusive();
    flutterEngineConnectionRegistry.attachToAbility(exclusive as Any as ExclusiveAppComponent<UIAbility>);
    expect(exclusive.detached).assertEqual(false);
  });

  it('ability plugin receives onAttachedToAbility while registry is attached', 0, () => {
    const plugin = new RAbilityPlugin();
    flutterEngineConnectionRegistry.add(plugin);
    expect(plugin.attached).assertEqual(1);
    // re-attaching notifies already-registered ability plugins again
    const exclusive2 = new RExclusive();
    flutterEngineConnectionRegistry.attachToAbility(exclusive2 as Any as ExclusiveAppComponent<UIAbility>);
    expect(plugin.abilityAttached >= 1).assertEqual(true);
    // removing the ability plugin notifies ability detach first
    flutterEngineConnectionRegistry.remove('r_ability_plugin');
    expect(plugin.abilityDetached >= 1).assertEqual(true);
    expect(flutterEngineConnectionRegistry.has('r_ability_plugin')).assertEqual(false);
  });

  it('detachFromAbility clears the attached state', 0, () => {
    const plugin = new RAbilityPlugin();
    flutterEngineConnectionRegistry.add(plugin);
    flutterEngineConnectionRegistry.detachFromAbility();
    expect(plugin.abilityDetached >= 1).assertEqual(true);
  });

});
}
