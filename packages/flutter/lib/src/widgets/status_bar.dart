/*
* Copyright (c) 2025 Huawei Device Co., Ltd. All rights reserved.
* Use of this source code is governed by a BSD-style license that can be
* found in the LICENSE_HW file.
*/
import 'dart:async';
import 'package:flutter/services.dart';

/// Handles status bar click events from the OHOS platform.
class ChannelMessageHandler {
  static const MethodChannel _channel = MethodChannel('flutter/statusBarClick');

  /// Whether [init] has been called.
  static bool isInit = false;

  /// Timestamp of the last forwarded event, used by [throttle].
  static DateTime? lastCallTime;

  static final StreamController<dynamic> _streamController = StreamController<dynamic>.broadcast();

  /// init Channel
  static void init() {
    if (isInit) {
      return;
    }
    isInit = true;
    _channel.setMethodCallHandler((MethodCall call) async {
      throttle(() {
        _streamController.add(<String, dynamic>{
          'method': call.method,
          'arguments': call.arguments,
        });
      }, const Duration(milliseconds: 1000));
    });
  }

  /// Runs [callback] only if [duration] has elapsed since the last run.
  static void throttle(void Function() callback, Duration duration) {
    final DateTime now = DateTime.now();
    if (lastCallTime == null || now.difference(lastCallTime!) >= duration) {
      lastCallTime = now;
      callback();
    }
  }

  /// Stream of forwarded status bar click events.
  static Stream<dynamic> get messageStream => _streamController.stream;

  /// close
  static void dispose() {
    _streamController.close();
  }
}
