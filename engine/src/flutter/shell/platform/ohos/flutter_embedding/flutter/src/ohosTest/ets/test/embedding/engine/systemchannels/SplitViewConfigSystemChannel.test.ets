import { describe, it, expect, Level } from '@ohos/hypium';
import Any from '../../../../../../main/ets/plugin/common/Any';
import FlutterInjector from '../../../../../../main/ets/FlutterInjector';
import DartExecutor from '../../../../../../main/ets/embedding/engine/dart/DartExecutor';
import FlutterNapi from '../../../../../../main/ets/embedding/engine/FlutterNapi';
import SplitViewConfigSystemChannel from '../../../../../../main/ets/embedding/engine/systemchannels/SplitViewConfigSystemChannel';
import { common } from '@kit.AbilityKit';
import { resourceManager } from '@kit.LocalizationKit';

function createChannel(): SplitViewConfigSystemChannel {
  const flutterNapi: FlutterNapi = new FlutterNapi();
  const context: common.Context = getContext();
  const rm: resourceManager.ResourceManager = context.resourceManager;
  const dartExecutor: DartExecutor = new DartExecutor(flutterNapi, rm);
  return new SplitViewConfigSystemChannel(dartExecutor, context);
}

export default function splitViewConfigSystemChannelTest() {
  describe('SplitViewConfigSystemChannel.construct', () => {
    it('constructsWithoutCrash', Level.LEVEL1, () => {
      const channel: SplitViewConfigSystemChannel = createChannel();
      expect(channel).not().assertNull();
    });
  });

  describe('SplitViewConfigSystemChannel.sendConfigToFlutter', () => {
    it('returnsEarlyWhenRawfileNotExist', Level.LEVEL1, () => {
      const channel: SplitViewConfigSystemChannel = createChannel();
      channel.sendConfigToFlutter();
    });

    it('does not throw when called multiple times', Level.LEVEL0, () => {
      const channel: SplitViewConfigSystemChannel = createChannel();
      let threw = false;
      try {
        channel.sendConfigToFlutter();
        channel.sendConfigToFlutter();
      } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });
  });
describe('SplitViewConfigSystemChannel.getAppIconBase64', () => {
  it('returns non-empty base64 for the real app icon', 0, () => {
    const context: Any = getContext();
    const napi = FlutterInjector.getInstance().getFlutterNapi();
    const channel = new SplitViewConfigSystemChannel(new DartExecutor(napi, context.resourceManager), context);
    const ch: Any = channel;
    const icon: string = ch['getAppIconBase64']();
    expect(icon.length > 0).assertTrue();
  });

  it('returns empty string when context is null', 0, () => {
    const napi = FlutterInjector.getInstance().getFlutterNapi();
    const context: Any = getContext();
    const channel = new SplitViewConfigSystemChannel(new DartExecutor(napi, context.resourceManager), null as Any as common.Context);
    const ch: Any = channel;
    expect(ch['getAppIconBase64']()).assertEqual('');
  });
});
describe('SplitViewConfigSystemChannel.configFlow', () => {
  it('sendConfigToFlutter returns early with null context and keeps cache empty', 0, () => {
    const context: Any = getContext();
    const napi = FlutterInjector.getInstance().getFlutterNapi();
    const channel = new SplitViewConfigSystemChannel(new DartExecutor(napi, context.resourceManager), null as Any as common.Context);
    const ch: Any = channel;
    let threw = false;
    try { channel.sendConfigToFlutter(); } catch (e) { threw = true; }
    expect(threw).assertEqual(false);
    expect(ch['cachedConfigStr']).assertEqual('');
  });

  it('readConfigFromRawfile returns null with null context', 0, () => {
    const context: Any = getContext();
    const napi = FlutterInjector.getInstance().getFlutterNapi();
    const channel = new SplitViewConfigSystemChannel(new DartExecutor(napi, context.resourceManager), null as Any as common.Context);
    const ch: Any = channel;
    expect(ch['readConfigFromRawfile']()).assertNull();
  });

  it('readConfigFromRawfile returns null when split config is absent', 0, () => {
    const context: Any = getContext();
    const napi = FlutterInjector.getInstance().getFlutterNapi();
    const channel = new SplitViewConfigSystemChannel(new DartExecutor(napi, context.resourceManager), context);
    const ch: Any = channel;
    // the test HAP rawfile only carries flutter_assets, no split_config.json
    expect(ch['readConfigFromRawfile']()).assertNull();
  });
});
}
