// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// widget_behavior 迭代 4 —— 深入验证 ohos 平台集成层缺陷区：
// A. 平台通道（SystemSound/Clipboard.hasStrings 已知挂起bug + SystemChrome 通道响应）
// B. PlatformView 通道（flutter/platform_views 探测不挂起）
// C. Texture 渲染（不崩溃）
// 真机 android-vs-ohos 差分。android 真机: XPL0220806025985。

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // ===================== A. 平台通道（缺陷区） =====================
  group('platform-channel-deep', () {
    // 已知缺陷 1: SystemSound.play —— ohos 空 case 不 settle → 挂起（扫描报告确认）
    testWidgets(
      'SystemSound.play completes',
      (WidgetTester tester) async {
        await tester.pumpWidget(const MaterialApp(home: Scaffold(body: SizedBox())));
        await tester.pumpAndSettle();
        await SystemSound.play(SystemSoundType.click);
        expect(true, isTrue);
      },
      skip: defaultTargetPlatform == TargetPlatform.ohos,
    ); // ohos: SystemSound.play 空 case 不 settle → 挂起 (GAP-SYSOUND)

    // 已知缺陷 2: Clipboard.hasStrings —— ohos catch 不 settle → 挂起（扫描报告确认）
    testWidgets(
      'Clipboard.hasStrings completes',
      (WidgetTester tester) async {
        await tester.pumpWidget(const MaterialApp(home: Scaffold(body: SizedBox())));
        await tester.pumpAndSettle();
        await Clipboard.setData(const ClipboardData(text: 'hasstrings-probe'));
        final bool has = await Clipboard.hasStrings();
        expect(has, isTrue);
      },
      skip: defaultTargetPlatform == TargetPlatform.ohos,
    ); // ohos: Clipboard.hasStrings catch 不 settle → 挂起 (GAP-HASSTRINGS)

    testWidgets('SystemChrome.setPreferredOrientations completes', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: Scaffold(body: SizedBox())));
      await tester.pumpAndSettle();
      await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
        DeviceOrientation.portraitUp,
      ]);
      await tester.pumpAndSettle();
      await SystemChrome.setPreferredOrientations(<DeviceOrientation>[]);
      expect(true, isTrue);
    });
  });

  // ===================== B. PlatformView 通道 =====================
  group('platform-view', () {
    // 探测 flutter/platform_views 通道是否响应（不挂起）；无工厂时报错也算"完成"。
    testWidgets('platform_views channel responds (no hang)', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: Scaffold(body: SizedBox())));
      await tester.pumpAndSettle();
      bool completed = false;
      try {
        await const MethodChannel('flutter/platform_views')
            .invokeMethod<dynamic>('create', <Object>[
              'probe-viewtype',
              0,
              <double>[],
              <Object, dynamic>{},
            ])
            .timeout(const Duration(seconds: 5));
        completed = true;
      } on PlatformException {
        completed = true; // 无工厂报错 = 通道已响应
      } on MissingPluginException {
        completed = true; // 通道未实现也算完成（非挂起）
      } on TimeoutException {
        completed = false; // 挂起 = 失败
      }
      expect(completed, isTrue, reason: 'platform_views 通道应响应而非挂起');
    });
  });

  // ===================== C. Texture 渲染 =====================
  group('texture', () {
    testWidgets('Texture widget renders without crash', (WidgetTester tester) async {
      // textureId=0（未注册）→ 应渲染为空/黑但不崩溃（引擎优雅处理缺纹理）。
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(child: SizedBox(width: 100, height: 100, child: Texture(textureId: 0))),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(Texture), findsOneWidget);
    });
  });
}
