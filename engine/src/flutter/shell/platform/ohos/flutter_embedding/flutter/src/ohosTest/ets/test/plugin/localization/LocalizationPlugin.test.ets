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
import { beforeEach, describe, expect, it } from '@ohos/hypium';
import LocalizationPlugin from '../../../../../main/ets/plugin/localization/LocalizationPlugin';
import common from '@ohos.app.ability.common';
import LocalizationChannel from '../../../../../main/ets/embedding/engine/systemchannels/LocalizationChannel';
import intl from '@ohos.intl';
import DartExecutor from '../../../../../main/ets/embedding/engine/dart/DartExecutor';
import FlutterInjector from '../../../../../main/ets/FlutterInjector';
import Any from '../../../../../main/ets/plugin/common/Any';
import MethodCall from '../../../../../main/ets/plugin/common/MethodCall';
import { MethodResult } from '../../../../../main/ets/plugin/common/MethodChannel';

class LocResourceResult implements MethodResult {
  successCalls: number = 0;
  successValue: Any = undefined;
  errorCalls: number = 0;
  notImplCalls: number = 0;
  success(result: Any): void {
    this.successCalls++;
    this.successValue = result;
  }
  error(_c: string, _m: string, _d: Any): void {
    this.errorCalls++;
  }
  notImplemented(): void {
    this.notImplCalls++;
  }
}

class LocPluginFixture {
  public plugin: Any;
  constructor() {
    const context: Any = getContext();
    const channel = new LocalizationChannel(
      new DartExecutor(FlutterInjector.getInstance().getFlutterNapi(), context.resourceManager));
    this.plugin = new LocalizationPlugin(context, channel);
  }
}

export default function LocalizationPluginTest() {
  describe('LocalizationPluginTest', () => {
    let localizationChannel: LocalizationChannel;
    let localizationPlugin: LocalizationPlugin;
    let dartExecutor: DartExecutor;

    beforeEach(() => {
      let context: common.Context = getContext();
      const assetManager = context.resourceManager;
      const flutterNapi = FlutterInjector.getInstance().getFlutterNapi();
      dartExecutor = new DartExecutor(flutterNapi, assetManager);
      localizationChannel = new LocalizationChannel(dartExecutor); // 初始化LocalizationChannel
      localizationPlugin = new LocalizationPlugin(context, localizationChannel);
    });
    it('test_localeFromString', 0, () => {
      let localeString = "zh_CN";
      let expectedLocale = new intl.Locale("zh_CN");
      let actualLocale = localizationPlugin.localeFromString(localeString);

      expect(actualLocale.language).assertEqual(expectedLocale.language);
      expect(actualLocale.region).assertEqual(expectedLocale.region);
      expect(actualLocale.script).assertEqual(expectedLocale.script);
    })
    it('testSendLocaleToFlutter', 0, () => {
      let mockSystemLocale = 'zh-Hans-CN';
      (localizationChannel as Any).sendLocales = (locales:Any) => {
        expect(locales).assertContain(mockSystemLocale);
      };
      localizationPlugin.sendLocaleToFlutter();
    })
  })
describe('LocalizationPlugin.localeFromString', () => {
  it('parses language script and country', 0, () => {
    const fx = new LocPluginFixture();
    const plugin: Any = fx.plugin;
    const locale: Any = plugin['localeFromString']('zh-Hans-CN');
    expect(locale.language).assertEqual('zh');
    expect(locale.script).assertEqual('Hans');
    expect(locale.region).assertEqual('CN');
  });

    it('parses language and country without script', 0, () => {
    const fx = new LocPluginFixture();
    const plugin: Any = fx.plugin;
    const locale: Any = plugin['localeFromString']('zh_CN');
    expect(locale.language).assertEqual('zh');
    expect(locale.region).assertEqual('CN');
  });

  it('skips country when part length is 1', 0, () => {
    const fx = new LocPluginFixture();
    const plugin: Any = fx.plugin;
    let threw = false;
    try {
      const locale: Any = plugin['localeFromString']('en-X');
      expect(locale).not().assertNull();
    } catch (e) { threw = true; }
    expect(threw).assertEqual(false);
  });
});

describe('LocalizationPlugin.getStringResource.via.channel', () => {
  it('missing key returns without throwing', 0, () => {
    const context: common.Context = getContext();
    const napi = FlutterInjector.getInstance().getFlutterNapi();
    const dartExecutor = new DartExecutor(napi, context.resourceManager);
    const channel = new LocalizationChannel(dartExecutor);
    const plugin = new LocalizationPlugin(context, channel);
    expect(plugin).not().assertNull();
    const args: Map<string, string> = new Map();
    args.set('key', 'missing_key_for_coverage_xyz');
    const result: LocResourceResult = new LocResourceResult();
    channel.onMethodCall(new MethodCall('Localization.getStringResource', args), result);
    expect(result.successCalls).assertEqual(1);
    expect(result.successValue).assertNull();
    expect(result.errorCalls).assertEqual(0);
  });

  it('locale override path does not throw', 0, () => {
    const context: common.Context = getContext();
    const napi = FlutterInjector.getInstance().getFlutterNapi();
    const dartExecutor = new DartExecutor(napi, context.resourceManager);
    const channel = new LocalizationChannel(dartExecutor);
    const plugin = new LocalizationPlugin(context, channel);
    expect(plugin).not().assertNull();
    const args: Map<string, string> = new Map();
    args.set('key', 'missing_key_for_coverage_xyz');
    args.set('locale', 'zh-CN');
    const result: LocResourceResult = new LocResourceResult();
    channel.onMethodCall(new MethodCall('Localization.getStringResource', args), result);
    expect(result.successCalls).assertEqual(1);
    expect(result.successValue).assertNull();
    expect(result.errorCalls).assertEqual(0);
  });
});
}
