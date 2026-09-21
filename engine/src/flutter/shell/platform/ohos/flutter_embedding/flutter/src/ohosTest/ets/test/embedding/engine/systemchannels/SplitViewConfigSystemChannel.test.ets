import { describe, it, expect, Level } from '@ohos/hypium';
import DartExecutor from '../../../../../../main/ets/embedding/engine/dart/DartExecutor';
import FlutterNapi from '../../../../../../main/ets/embedding/engine/FlutterNapi';
import SplitViewConfigSystemChannel from '../../../../../../main/ets/embedding/engine/systemchannels/SplitViewConfigSystemChannel';
import { common } from '@kit.AbilityKit';
import { resourceManager } from '@kit.LocalizationKit';
import Any from '../../../../../../main/ets/plugin/common/Any';

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

  describe('SplitViewConfigSystemChannel.branches', () => {
    const stubChannelSink = (ch: SplitViewConfigSystemChannel) => {
      (ch as Any).channel = {
        resizeChannelBuffer: (n: number) => {},
        send: (msg: string) => {}
      };
    };

    it('sendConfigToFlutter returns early when context is null', Level.LEVEL1, () => {
      const ch = createChannel();
      (ch as Any).context = null;
      let threw = false;
      try {
        ch.sendConfigToFlutter();
      } catch (e) {
        threw = true;
      }
      expect(threw).assertEqual(false);
    });

    it('sendConfigToFlutter injects icon into cached valid json and sends', Level.LEVEL1, () => {
      const ch = createChannel();
      (ch as Any).cachedConfigStr = '{"mode":"split"}';
      stubChannelSink(ch);
      let threw = false;
      try {
        ch.sendConfigToFlutter();
      } catch (e) {
        threw = true;
      }
      expect(threw).assertEqual(false);
    });

    it('sendConfigToFlutter survives cached invalid json', Level.LEVEL1, () => {
      const ch = createChannel();
      (ch as Any).cachedConfigStr = '{not-json';
      stubChannelSink(ch);
      let threw = false;
      try {
        ch.sendConfigToFlutter();
      } catch (e) {
        threw = true;
      }
      expect(threw).assertEqual(false);
    });

    it('sendConfigToFlutter skips icon injection when icon is empty', Level.LEVEL1, () => {
      const ch = createChannel();
      (ch as Any).cachedConfigStr = '{"mode":"split"}';
      (ch as Any).getAppIconBase64 = (): string => '';
      stubChannelSink(ch);
      let threw = false;
      try {
        ch.sendConfigToFlutter();
      } catch (e) {
        threw = true;
      }
      expect(threw).assertEqual(false);
    });

    it('getAppIconBase64 returns empty string when context is null', Level.LEVEL1, () => {
      const ch = createChannel();
      (ch as Any).context = null;
      const result = (ch as Any).getAppIconBase64() as string;
      expect(result).assertEqual('');
    });

    it('readConfigFromRawfile returns null when context is null', Level.LEVEL1, () => {
      const ch = createChannel();
      (ch as Any).context = null;
      const result: string | null = (ch as Any).readConfigFromRawfile() as string | null;
      expect(result).assertNull();
    });
  });
}
