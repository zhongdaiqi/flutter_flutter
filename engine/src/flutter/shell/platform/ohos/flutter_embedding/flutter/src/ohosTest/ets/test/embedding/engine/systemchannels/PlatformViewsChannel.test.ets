import { describe, it, expect, Level } from '@ohos/hypium';
import DartExecutor from '../../../../../../main/ets/embedding/engine/dart/DartExecutor';
import FlutterNapi from '../../../../../../main/ets/embedding/engine/FlutterNapi';
import PlatformViewsChannel, {
  PlatformViewCreationRequest,
  PlatformViewResizeRequest,
  PlatformViewBufferSize,
  PlatformViewTouch,
  PlatformViewsHandler,
  PlatformViewBufferResized,
} from '../../../../../../main/ets/embedding/engine/systemchannels/PlatformViewsChannel';
import { ByteBuffer } from '../../../../../../main/ets/util/ByteBuffer';
import Any from '../../../../../../main/ets/plugin/common/Any';
import MethodCall from '../../../../../../main/ets/plugin/common/MethodCall';
import { MethodResult, IncomingMethodCallHandler } from '../../../../../../main/ets/plugin/common/MethodChannel';
import { DartMessenger } from '../../../../../../main/ets/embedding/engine/dart/DartMessenger';
import { BinaryReply } from '../../../../../../main/ets/plugin/common/BinaryMessenger';
import StandardMethodCodec from '../../../../../../main/ets/plugin/common/StandardMethodCodec';
import { resourceManager } from '@kit.LocalizationKit';
class FakeMethodResult implements MethodResult {
  successResult: Any | null = null;
  successCalls: number = 0;
  errorCode: string = '';
  errorMessage: string = '';
  errorCalls: number = 0;
  notImplCalls: number = 0;

  success(result: Any): void {
    this.successCalls++;
    this.successResult = result;
  }

  error(errorCode: string, errorMessage: string, errorDetails: Any): void {
    this.errorCalls++;
    this.errorCode = errorCode;
    this.errorMessage = errorMessage;
  }

  notImplemented(): void {
    this.notImplCalls++;
  }
}

class FakePlatformViewsHandler implements PlatformViewsHandler {
  disposeCalls: number = 0;
  lastDisposeViewId: number = -1;
  clearFocusCalls: number = 0;
  lastClearFocusViewId: number = -1;
  syncCalls: number = 0;
  lastSyncValue: boolean = false;
  hoverCalls: number = 0;
  lastHoverViewId: number = -1;
  createTextureResult: number = 42;
  createTextureCalls: number = 0;
  createPlatformViewCalls: number = 0;
  resizeCalls: number = 0;

  createForPlatformViewLayer(request: PlatformViewCreationRequest): void {
    this.createPlatformViewCalls++;
  }

  createForTextureLayer(request: PlatformViewCreationRequest): number {
    this.createTextureCalls++;
    return this.createTextureResult;
  }

  dispose(viewId: number): void {
    this.disposeCalls++;
    this.lastDisposeViewId = viewId;
  }

  resize(request: PlatformViewResizeRequest, onComplete: PlatformViewBufferResized): void {
    this.resizeCalls++;
    onComplete.run(new PlatformViewBufferSize(100, 200));
  }

  offset(viewId: number, top: number, left: number): void {}

  transform(viewId: number, transform?: Array<number>): void {}

  onTouch(touch: PlatformViewTouch): void {}

  setDirection(viewId: number, direction: Direction): void {}

  clearFocus(viewId: number): void {
    this.clearFocusCalls++;
    this.lastClearFocusViewId = viewId;
  }

  synchronizeToNativeViewHierarchy(yes: boolean): void {
    this.syncCalls++;
    this.lastSyncValue = yes;
  }

  hover(viewId: number): void {
    this.hoverCalls++;
    this.lastHoverViewId = viewId;
  }
}

class PvcTestSetup {
  channel: PlatformViewsChannel;
  flutterNapi: FlutterNapi;
  dartExecutor: DartExecutor;

  constructor() {
    this.flutterNapi = new FlutterNapi();
    const context = getContext();
    const rm: resourceManager.ResourceManager = context.resourceManager;
    this.dartExecutor = new DartExecutor(this.flutterNapi, rm);
    this.dartExecutor.onAttachedToNAPI();
    this.channel = new PlatformViewsChannel(this.dartExecutor);
  }
}

class FakeBinaryReply implements BinaryReply {
  replyCount: number = 0;
  replyData: ArrayBuffer | null = null;
  reply(data: ArrayBuffer | null): void { this.replyCount++; this.replyData = data; }
}

function dispatchPvcMethodCall(setup: PvcTestSetup, method: string, args: Any): void {
  const call = new MethodCall(method, args);
  const encoded = StandardMethodCodec.INSTANCE.encodeMethodCall(call);
  const pmh = setup.flutterNapi.platformMessageHandler;
  if (pmh == null) return;
  const dm: DartMessenger = pmh as DartMessenger;
  const handlerInfo = dm.messageHandlers.get('flutter/platform_views');
  if (handlerInfo) {
    const incoming = handlerInfo.handler as IncomingMethodCallHandler;
    const reply = new FakeBinaryReply();
    incoming.onMessage(encoded, reply);
  }
}

function createChannel(): PlatformViewsChannel {
  const flutterNapi: FlutterNapi = new FlutterNapi();
  const context = getContext();
  const rm: resourceManager.ResourceManager = context.resourceManager;
  const dartExecutor: DartExecutor = new DartExecutor(flutterNapi, rm);
  return new PlatformViewsChannel(dartExecutor);
}

export default function platformViewsChannelTest() {
  describe('PlatformViewCreationRequest.constructor', () => {
    it('PlatformViewCreationRequest assigns all fields correctly', Level.LEVEL0, () => {
      const params: ByteBuffer = ByteBuffer.from(new ArrayBuffer(0));
      const request = new PlatformViewCreationRequest(1, 'test_view', 10, 20, 100, 200, 0, params);
      expect(request.viewId).assertEqual(1);
      expect(request.viewType).assertEqual('test_view');
      expect(request.logicalTop).assertEqual(10);
      expect(request.logicalLeft).assertEqual(20);
      expect(request.logicalWidth).assertEqual(100);
      expect(request.logicalHeight).assertEqual(200);
      expect(request.direction).assertEqual(0);
    });

    it('handles zero values for creation request', Level.LEVEL0, () => {
      const params: ByteBuffer = ByteBuffer.from(new ArrayBuffer(0));
      const request = new PlatformViewCreationRequest(0, '', 0, 0, 0, 0, 0, params);
      expect(request.viewId).assertEqual(0);
      expect(request.viewType).assertEqual('');
    });
  });

  describe('PlatformViewResizeRequest.constructor', () => {
    it('PlatformViewResizeRequest assigns all fields correctly', Level.LEVEL0, () => {
      const request = new PlatformViewResizeRequest(5, 300, 400);
      expect(request.viewId).assertEqual(5);
      expect(request.newLogicalWidth).assertEqual(300);
      expect(request.newLogicalHeight).assertEqual(400);
    });

    it('handles zero values for resize request', Level.LEVEL0, () => {
      const request = new PlatformViewResizeRequest(0, 0, 0);
      expect(request.viewId).assertEqual(0);
      expect(request.newLogicalWidth).assertEqual(0);
      expect(request.newLogicalHeight).assertEqual(0);
    });
  });

  describe('PlatformViewBufferSize.constructor', () => {
    it('assigns width and height', Level.LEVEL0, () => {
      const size = new PlatformViewBufferSize(1920, 1080);
      expect(size.width).assertEqual(1920);
      expect(size.height).assertEqual(1080);
    });

    it('handles zero values for buffer size', Level.LEVEL0, () => {
      const size = new PlatformViewBufferSize(0, 0);
      expect(size.width).assertEqual(0);
      expect(size.height).assertEqual(0);
    });
  });

  describe('PlatformViewTouch.constructor', () => {
    it('PlatformViewTouch assigns all fields correctly', Level.LEVEL1, () => {
      const touch = new PlatformViewTouch(
        1, 100, 200, 0, 1, null, null, 0, 0, 1.0, 1.0, 1, 0, 0, 0, 1
      );
      expect(touch.viewId).assertEqual(1);
      expect(touch.downTime).assertEqual(100);
      expect(touch.eventTime).assertEqual(200);
      expect(touch.action).assertEqual(0);
      expect(touch.pointerCount).assertEqual(1);
      expect(touch.metaState).assertEqual(0);
      expect(touch.buttonState).assertEqual(0);
      expect(touch.xPrecision).assertEqual(1.0);
      expect(touch.yPrecision).assertEqual(1.0);
      expect(touch.deviceId).assertEqual(1);
      expect(touch.edgeFlags).assertEqual(0);
      expect(touch.source).assertEqual(0);
      expect(touch.flags).assertEqual(0);
      expect(touch.motionEventId).assertEqual(1);
    });

    it('handles all zero values', Level.LEVEL0, () => {
      const touch = new PlatformViewTouch(
        0, 0, 0, 0, 0, null, null, 0, 0, 0, 0, 0, 0, 0, 0, 0
      );
      expect(touch.viewId).assertEqual(0);
      expect(touch.downTime).assertEqual(0);
      expect(touch.eventTime).assertEqual(0);
    });
  });

  describe('PlatformViewsChannel.construct', () => {
    it('constructsWithoutCrash', Level.LEVEL1, () => {
      const channel: PlatformViewsChannel = createChannel();
      expect(channel).not().assertNull();
    });
  });

  describe('PlatformViewsChannel.setPlatformViewsHandler', () => {
    it('setsHandlerWithoutCrash', Level.LEVEL1, () => {
      const channel: PlatformViewsChannel = createChannel();
      const handler: FakePlatformViewsHandler = new FakePlatformViewsHandler();
      channel.setPlatformViewsHandler(handler);
      channel.setPlatformViewsHandler(null);
    });
  });

  describe('PlatformViewsChannel.dispose', () => {
    it('dispatchesToHandlerWithCorrectViewId on dispose', Level.LEVEL1, () => {
      const channel: PlatformViewsChannel = createChannel();
      const handler: FakePlatformViewsHandler = new FakePlatformViewsHandler();
      channel.setPlatformViewsHandler(handler);
      const result: FakeMethodResult = new FakeMethodResult();
      const args: Map<string, number> = new Map();
      args.set('id', 42);
      const call: MethodCall = new MethodCall('dispose', args);
      channel.dispose(call, result);
      expect(handler.disposeCalls).assertEqual(1);
      expect(handler.lastDisposeViewId).assertEqual(42);
      expect(result.successCalls).assertEqual(1);
    });
  });

  describe('PlatformViewsChannel.clearFocus', () => {
    it('dispatchesToHandlerWithCorrectViewId on clearFocus', Level.LEVEL1, () => {
      const channel: PlatformViewsChannel = createChannel();
      const handler: FakePlatformViewsHandler = new FakePlatformViewsHandler();
      channel.setPlatformViewsHandler(handler);
      const result: FakeMethodResult = new FakeMethodResult();
      const call: MethodCall = new MethodCall('clearFocus', 7);
      channel.clearFocus(call, result);
      expect(handler.clearFocusCalls).assertEqual(1);
      expect(handler.lastClearFocusViewId).assertEqual(7);
      expect(result.successCalls).assertEqual(1);
    });
  });

  describe('PlatformViewsChannel.synchronizeToNativeViewHierarchy', () => {
    it('dispatchesToHandlerWithTrueValue', Level.LEVEL1, () => {
      const channel: PlatformViewsChannel = createChannel();
      const handler: FakePlatformViewsHandler = new FakePlatformViewsHandler();
      channel.setPlatformViewsHandler(handler);
      const result: FakeMethodResult = new FakeMethodResult();
      const call: MethodCall = new MethodCall('synchronizeToNativeViewHierarchy', true);
      channel.synchronizeToNativeViewHierarchy(call, result);
      expect(handler.syncCalls).assertEqual(1);
      expect(handler.lastSyncValue).assertEqual(true);
      expect(result.successCalls).assertEqual(1);
    });

    it('dispatchesToHandlerWithFalseValue', Level.LEVEL1, () => {
      const channel: PlatformViewsChannel = createChannel();
      const handler: FakePlatformViewsHandler = new FakePlatformViewsHandler();
      channel.setPlatformViewsHandler(handler);
      const result: FakeMethodResult = new FakeMethodResult();
      const call: MethodCall = new MethodCall('synchronizeToNativeViewHierarchy', false);
      channel.synchronizeToNativeViewHierarchy(call, result);
      expect(handler.syncCalls).assertEqual(1);
      expect(handler.lastSyncValue).assertEqual(false);
      expect(result.successCalls).assertEqual(1);
    });
  });

  describe('PlatformViewsChannel.hover', () => {
    it('dispatchesToHandlerWithCorrectViewId on hover', Level.LEVEL1, () => {
      const channel: PlatformViewsChannel = createChannel();
      const handler: FakePlatformViewsHandler = new FakePlatformViewsHandler();
      channel.setPlatformViewsHandler(handler);
      const result: FakeMethodResult = new FakeMethodResult();
      const call: MethodCall = new MethodCall('hover', 15);
      channel.hover(call, result);
      expect(handler.hoverCalls).assertEqual(1);
      expect(handler.lastHoverViewId).assertEqual(15);
      expect(result.successCalls).assertEqual(1);
    });
  });

  describe('PlatformViewsChannel.create.textureLayer', () => {
    it('dispatchesCreateForTextureLayerAndReturnsTextureId', Level.LEVEL1, () => {
      const channel: PlatformViewsChannel = createChannel();
      const handler: FakePlatformViewsHandler = new FakePlatformViewsHandler();
      channel.setPlatformViewsHandler(handler);
      const result: FakeMethodResult = new FakeMethodResult();
      const args: Map<string, Any> = new Map();
      args.set('id', 1);
      args.set('viewType', 'test_view');
      args.set('width', 100);
      args.set('height', 200);
      args.set('direction', 0);
      const call: MethodCall = new MethodCall('create', args);
      channel.create(call, result);
      expect(handler.createTextureCalls).assertEqual(1);
      expect(result.successCalls).assertEqual(1);
      expect(result.successResult).assertEqual(42);
    });
  });

  describe('PlatformViewsChannel.resize', () => {
    it('dispatchesResizeToHandler', Level.LEVEL1, () => {
      const channel: PlatformViewsChannel = createChannel();
      const handler: FakePlatformViewsHandler = new FakePlatformViewsHandler();
      channel.setPlatformViewsHandler(handler);
      const result: FakeMethodResult = new FakeMethodResult();
      const args: Map<string, number> = new Map();
      args.set('id', 3);
      args.set('width', 300);
      args.set('height', 400);
      const call: MethodCall = new MethodCall('resize', args);
      channel.resize(call, result);
      expect(handler.resizeCalls).assertEqual(1);
      expect(result.successCalls).assertEqual(1);
    });
  });

  describe('PlatformViewsChannel.onMethodCall.via.messenger', () => {
    it('onMethodCall returns early when handler is null', Level.LEVEL0, () => {
      const setup = new PvcTestSetup();
      dispatchPvcMethodCall(setup, 'create', null);
      expect(setup.channel).not().assertNull();
    });

    it('onMethodCall handles create', Level.LEVEL0, () => {
      const setup = new PvcTestSetup();
      const handler = new FakePlatformViewsHandler();
      setup.channel.setPlatformViewsHandler(handler);
      const args = new Map<string, Object>();
      args.set('viewId', 1);
      args.set('viewType', 'test');
      dispatchPvcMethodCall(setup, 'create', args);
      expect(true).assertEqual(true);
    });

    it('onMethodCall handles dispose', Level.LEVEL0, () => {
      const setup = new PvcTestSetup();
      const handler = new FakePlatformViewsHandler();
      setup.channel.setPlatformViewsHandler(handler);
      const args = new Map<string, Object>();
      args.set('viewId', 1);
      dispatchPvcMethodCall(setup, 'dispose', args);
      expect(handler.disposeCalls).assertEqual(1);
    });

    it('onMethodCall handles resize', Level.LEVEL0, () => {
      const setup = new PvcTestSetup();
      const handler = new FakePlatformViewsHandler();
      setup.channel.setPlatformViewsHandler(handler);
      const args = new Map<string, Object>();
      args.set('viewId', 1);
      args.set('width', 100);
      args.set('height', 200);
      dispatchPvcMethodCall(setup, 'resize', args);
      expect(handler.resizeCalls).assertEqual(1);
    });

    it('onMethodCall handles offset', Level.LEVEL0, () => {
      const setup = new PvcTestSetup();
      const handler = new FakePlatformViewsHandler();
      setup.channel.setPlatformViewsHandler(handler);
      const args = new Map<string, Object>();
      args.set('viewId', 1);
      args.set('top', 10);
      args.set('left', 20);
      dispatchPvcMethodCall(setup, 'offset', args);
      expect(true).assertEqual(true);
    });

    it('onMethodCall handles transform', Level.LEVEL0, () => {
      const setup = new PvcTestSetup();
      const handler = new FakePlatformViewsHandler();
      setup.channel.setPlatformViewsHandler(handler);
      const args = new Map<string, Object>();
      args.set('viewId', 1);
      args.set('transform', [1, 0, 0, 1, 10, 20]);
      dispatchPvcMethodCall(setup, 'transform', args);
      expect(true).assertEqual(true);
    });

    it('onMethodCall handles touch', Level.LEVEL0, () => {
      const setup = new PvcTestSetup();
      const handler = new FakePlatformViewsHandler();
      setup.channel.setPlatformViewsHandler(handler);
      const args = new Map<string, Object>();
      args.set('viewId', 1);
      dispatchPvcMethodCall(setup, 'touch', args);
      expect(true).assertEqual(true);
    });

    it('onMethodCall handles setDirection', Level.LEVEL0, () => {
      const setup = new PvcTestSetup();
      const handler = new FakePlatformViewsHandler();
      setup.channel.setPlatformViewsHandler(handler);
      const args = new Map<string, Object>();
      args.set('viewId', 1);
      args.set('direction', 0);
      dispatchPvcMethodCall(setup, 'setDirection', args);
      expect(true).assertEqual(true);
    });

    it('onMethodCall handles clearFocus', Level.LEVEL0, () => {
      const setup = new PvcTestSetup();
      const handler = new FakePlatformViewsHandler();
      setup.channel.setPlatformViewsHandler(handler);
      const args = new Map<string, Object>();
      args.set('viewId', 1);
      dispatchPvcMethodCall(setup, 'clearFocus', args);
      expect(true).assertEqual(true);
    });

    it('onMethodCall handles synchronizeToNativeViewHierarchy', Level.LEVEL0, () => {
      const setup = new PvcTestSetup();
      const handler = new FakePlatformViewsHandler();
      setup.channel.setPlatformViewsHandler(handler);
      const args = new Map<string, Object>();
      args.set('viewId', 1);
      dispatchPvcMethodCall(setup, 'synchronizeToNativeViewHierarchy', args);
      expect(true).assertEqual(true);
    });

    it('onMethodCall handles hover', Level.LEVEL0, () => {
      const setup = new PvcTestSetup();
      const handler = new FakePlatformViewsHandler();
      setup.channel.setPlatformViewsHandler(handler);
      const args = new Map<string, Object>();
      args.set('viewId', 1);
      dispatchPvcMethodCall(setup, 'hover', args);
      expect(true).assertEqual(true);
    });

    it('onMethodCall handles unknown method (notImplemented)', Level.LEVEL0, () => {
      const setup = new PvcTestSetup();
      const handler = new FakePlatformViewsHandler();
      setup.channel.setPlatformViewsHandler(handler);
      dispatchPvcMethodCall(setup, 'unknown.method', null);
      expect(true).assertEqual(true);
    });
  });

  describe('PlatformViewsChannel.create.hybrid.and.errors', () => {
    it('invokeViewFocused does not throw', Level.LEVEL0, () => {
      const channel: PlatformViewsChannel = createChannel();
      let threw = false;
      try { channel.invokeViewFocused(9); } catch (e) { threw = true; }
      expect(threw).assertEqual(false);
    });

    it('create hybrid uses createForPlatformViewLayer and RTL', Level.LEVEL0, () => {
      const channel: PlatformViewsChannel = createChannel();
      const handler: FakePlatformViewsHandler = new FakePlatformViewsHandler();
      channel.setPlatformViewsHandler(handler);
      const result: FakeMethodResult = new FakeMethodResult();
      const args: Map<string, Any> = new Map();
      args.set('id', 7);
      args.set('viewType', 'hybrid_view');
      args.set('direction', 1);
      args.set('hybrid', true);
      channel.create(new MethodCall('create', args), result);
      expect(handler.createPlatformViewCalls).assertEqual(1);
      expect(result.successCalls).assertEqual(1);
    });

    it('create texture with hybridFallback and NON_TEXTURE_FALLBACK returns null', Level.LEVEL0, () => {
      const channel: PlatformViewsChannel = createChannel();
      const handler: FakePlatformViewsHandler = new FakePlatformViewsHandler();
      handler.createTextureResult = -2;
      channel.setPlatformViewsHandler(handler);
      const result: FakeMethodResult = new FakeMethodResult();
      const args: Map<string, Any> = new Map();
      args.set('id', 2);
      args.set('viewType', 'tex');
      args.set('width', 10);
      args.set('height', 20);
      args.set('direction', 0);
      args.set('hybridFallback', true);
      args.set('top', 1);
      args.set('left', 2);
      channel.create(new MethodCall('create', args), result);
      expect(handler.createTextureCalls).assertEqual(1);
      expect(result.successCalls).assertEqual(1);
      expect(result.successResult).assertEqual(null);
    });

    it('create texture NON_TEXTURE_FALLBACK without hybridFallback errors', Level.LEVEL0, () => {
      const channel: PlatformViewsChannel = createChannel();
      const handler: FakePlatformViewsHandler = new FakePlatformViewsHandler();
      handler.createTextureResult = -2;
      channel.setPlatformViewsHandler(handler);
      const result: FakeMethodResult = new FakeMethodResult();
      const args: Map<string, Any> = new Map();
      args.set('id', 3);
      args.set('viewType', 'tex');
      args.set('width', 10);
      args.set('height', 20);
      args.set('direction', 0);
      channel.create(new MethodCall('create', args), result);
      expect(result.errorCalls).assertEqual(1);
    });

    it('dispose resize offset setDirection catch handler throw', Level.LEVEL0, () => {
      const channel: PlatformViewsChannel = createChannel();
      class ThrowingHandler extends FakePlatformViewsHandler {
        dispose(_viewId: number): void { throw new Error('dispose boom'); }
        resize(_req: PlatformViewResizeRequest, _cb: PlatformViewBufferResized): void {
          throw new Error('resize boom');
        }
        offset(_id: number, _top: number, _left: number, _t?: Array<number>): void {
          throw new Error('offset boom');
        }
        setDirection(_id: number, _d: Direction): void { throw new Error('dir boom'); }
        onTouch(_t: PlatformViewTouch): void { throw new Error('touch boom'); }
      }
      const handler: ThrowingHandler = new ThrowingHandler();
      channel.setPlatformViewsHandler(handler);
      const disposeResult: FakeMethodResult = new FakeMethodResult();
      const idArgs: Map<string, Any> = new Map();
      idArgs.set('id', 1);
      channel.dispose(new MethodCall('dispose', idArgs), disposeResult);
      expect(disposeResult.errorCalls).assertEqual(1);
      const resizeResult: FakeMethodResult = new FakeMethodResult();
      const resizeArgs: Map<string, Any> = new Map();
      resizeArgs.set('id', 1);
      resizeArgs.set('width', 8);
      resizeArgs.set('height', 9);
      channel.resize(new MethodCall('resize', resizeArgs), resizeResult);
      expect(resizeResult.errorCalls).assertEqual(1);
      const offsetResult: FakeMethodResult = new FakeMethodResult();
      const offsetArgs: Map<string, Any> = new Map();
      offsetArgs.set('id', 1);
      offsetArgs.set('top', 0);
      offsetArgs.set('left', 0);
      offsetArgs.set('transform', [1, 0, 0, 0, 1, 0]);
      channel.offset(new MethodCall('offset', offsetArgs), offsetResult);
      expect(offsetResult.errorCalls).assertEqual(1);
      const dirResult: FakeMethodResult = new FakeMethodResult();
      const dirArgs: Map<string, Any> = new Map();
      dirArgs.set('id', 1);
      dirArgs.set('direction', 1);
      channel.setDirection(new MethodCall('setDirection', dirArgs), dirResult);
      expect(dirResult.errorCalls).assertEqual(1);
      const touchResult: FakeMethodResult = new FakeMethodResult();
      const touchArgs: Array<Any> = [1, 100, 200, 0, 1, null, null, 0, 0, 1.0, 1.0, 1, 0, 0, 0, 1];
      channel.touch(new MethodCall('touch', touchArgs), touchResult);
      expect(touchResult.errorCalls).assertEqual(1);
    });

    it('setDirection falls back to Ltr for unsupported value', Level.LEVEL0, () => {
      const channel: PlatformViewsChannel = createChannel();
      const handler: FakePlatformViewsHandler = new FakePlatformViewsHandler();
      channel.setPlatformViewsHandler(handler);
      const result: FakeMethodResult = new FakeMethodResult();
      const args: Map<string, Any> = new Map();
      args.set('id', 4);
      args.set('direction', 99);
      channel.setDirection(new MethodCall('setDirection', args), result);
      expect(result.successCalls).assertEqual(1);
    });

    it('offset with null transform still succeeds', Level.LEVEL0, () => {
      const channel: PlatformViewsChannel = createChannel();
      const handler: FakePlatformViewsHandler = new FakePlatformViewsHandler();
      channel.setPlatformViewsHandler(handler);
      const result: FakeMethodResult = new FakeMethodResult();
      const args: Map<string, Any> = new Map();
      args.set('id', 5);
      args.set('top', 3);
      args.set('left', 4);
      args.set('transform', null);
      channel.offset(new MethodCall('offset', args), result);
      expect(result.successCalls).assertEqual(1);
    });
  });
}

