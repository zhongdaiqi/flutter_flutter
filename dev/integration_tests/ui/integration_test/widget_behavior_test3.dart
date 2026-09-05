// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// widget_behavior 迭代 3 —— 深扩边缘场景：
// A. 渲染边缘（ShaderMask/BackdropFilter/ColorFiltered/Transform/SelectableText/CustomPaint）
// B. 手势边缘（冲突手势/可滚动 fling）
// C. IME 边缘（选区控制）
// D. 平台集成通道（剪贴板/触觉反馈，预期暴露 ohos gap）
// 真机 android-vs-ohos 差分。

import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // ===================== A. 渲染边缘 =====================
  group('rendering-edge', () {
    testWidgets('ShaderMask renders', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: ShaderMask(
                key: const ValueKey<String>('shader-mask'),
                shaderCallback: (Rect bounds) => const LinearGradient(
                  colors: <Color>[Colors.red, Colors.blue],
                ).createShader(bounds),
                child: const SizedBox(
                  width: 100,
                  height: 100,
                  child: ColoredBox(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey<String>('shader-mask')), findsOneWidget);
    });

    testWidgets('BackdropFilter blur renders', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: BackdropFilter(
                key: const ValueKey<String>('backdrop'),
                filter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: const SizedBox(
                  width: 100,
                  height: 100,
                  child: ColoredBox(color: Colors.green),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey<String>('backdrop')), findsOneWidget);
    });

    testWidgets('ColorFiltered renders', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: ColorFiltered(
                key: ValueKey<String>('color-filter'),
                colorFilter: ColorFilter.mode(Colors.red, BlendMode.srcIn),
                child: SizedBox(width: 80, height: 80, child: ColoredBox(color: Colors.grey)),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey<String>('color-filter')), findsOneWidget);
    });

    testWidgets('Transform rotate renders', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: Transform.rotate(
                key: const ValueKey<String>('transform'),
                angle: 0.5,
                child: const SizedBox(width: 80, height: 80, child: ColoredBox(color: Colors.teal)),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      final Transform t = tester.widget<Transform>(find.byKey(const ValueKey<String>('transform')));
      expect(t.transform, isNotNull);
    });

    testWidgets('SelectableText renders', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(child: SelectableText('select me', key: ValueKey<String>('selectable'))),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey<String>('selectable')), findsOneWidget);
      expect(find.byType(SelectableText), findsOneWidget);
    });

    testWidgets('CustomPaint renders', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: CustomPaint(
                key: ValueKey<String>('custom-paint'),
                painter: _DotPainter(),
                child: SizedBox(width: 100, height: 100),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey<String>('custom-paint')), findsOneWidget);
    });
  });

  // ===================== B. 手势边缘 =====================
  group('gesture-edge', () {
    testWidgets('conflicting tap vs long press', (WidgetTester tester) async {
      bool tapped = false;
      bool longPressed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: GestureDetector(
                key: const ValueKey<String>('conflict-target'),
                onTap: () => tapped = true,
                onLongPress: () => longPressed = true,
                child: const SizedBox(
                  width: 100,
                  height: 100,
                  child: ColoredBox(color: Colors.indigo),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const ValueKey<String>('conflict-target')));
      await tester.pumpAndSettle();
      expect(tapped, isTrue);
      expect(longPressed, isFalse);

      await tester.longPress(find.byKey(const ValueKey<String>('conflict-target')));
      await tester.pumpAndSettle();
      expect(longPressed, isTrue);
    });

    testWidgets('scrollable list fling changes offset', (WidgetTester tester) async {
      final ScrollController controller = ScrollController();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 200,
              child: ListView.builder(
                key: const ValueKey<String>('scroll-list'),
                controller: controller,
                itemCount: 50,
                itemBuilder: (BuildContext context, int index) =>
                    ListTile(key: ValueKey<String>('item-$index'), title: Text('item $index')),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      final double initialOffset = controller.offset;

      await tester.fling(
        find.byKey(const ValueKey<String>('scroll-list')),
        const Offset(0, -300),
        800,
      );
      await tester.pumpAndSettle();
      expect(controller.offset, greaterThan(initialOffset));
    });
  });

  // ===================== C. IME 边缘 =====================
  group('IME-edge', () {
    testWidgets('controller selection control', (WidgetTester tester) async {
      final TextEditingController controller = TextEditingController(text: 'hello ohos');
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: TextField(key: const ValueKey<String>('ime-select'), controller: controller),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      controller.selection = const TextSelection(baseOffset: 0, extentOffset: 5);
      await tester.pump();
      expect(controller.selection.baseOffset, 0);
      expect(controller.selection.extentOffset, 5);
    });
  });

  // ===================== D. 平台集成通道（预期暴露 ohos gap） =====================
  group('platform-channel', () {
    testWidgets('clipboard set/get round-trip', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: Scaffold(body: SizedBox())));
      await tester.pumpAndSettle();
      await Clipboard.setData(const ClipboardData(text: 'ohos-clip-roundtrip'));
      final ClipboardData? data = await Clipboard.getData('text/plain');
      // android 应能取回；ohos 若剪贴板通道未实现则 data 为 null → ohos 缺陷。
      expect(data?.text, 'ohos-clip-roundtrip');
    });

    testWidgets('haptic feedback does not throw', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: Scaffold(body: SizedBox())));
      await tester.pumpAndSettle();
      // 触觉反馈通道若未实现应不抛异常（返回 void）；ohos 可能无反馈但不抛。
      await HapticFeedback.lightImpact();
      expect(true, isTrue);
    });
  });
}

class _DotPainter extends CustomPainter {
  const _DotPainter();

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    final ui.Paint circlePaint = ui.Paint()..color = Colors.deepOrange;
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 20, circlePaint);
  }

  @override
  bool shouldRepaint(covariant _DotPainter oldDelegate) => false;
}
