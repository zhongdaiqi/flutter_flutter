// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// 设备相关 widget 行为集成测试 —— 触摸/手势、IME、无障碍、渲染。
// 真机 android-vs-ohos 差分：android 基线 vs ohos 被测，差分出 ohos 平台缺陷。
// 每个测试 pump 自己的场景，不依赖 app main。

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // ===================== 触摸 / 手势 =====================
  group('touch/gesture', () {
    testWidgets('tap increments counter', (WidgetTester tester) async {
      int count = 0;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: GestureDetector(
                key: const ValueKey<String>('tap-target'),
                onTap: () => count++,
                child: const SizedBox(
                  width: 100,
                  height: 100,
                  child: ColoredBox(color: Colors.blue),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const ValueKey<String>('tap-target')));
      await tester.pumpAndSettle();
      expect(count, 1);

      await tester.tap(find.byKey(const ValueKey<String>('tap-target')));
      await tester.pumpAndSettle();
      expect(count, 2);
    });

    testWidgets('long press triggers', (WidgetTester tester) async {
      bool longPressed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: GestureDetector(
                key: const ValueKey<String>('longpress-target'),
                onLongPress: () => longPressed = true,
                child: const SizedBox(
                  width: 100,
                  height: 100,
                  child: ColoredBox(color: Colors.red),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.longPress(find.byKey(const ValueKey<String>('longpress-target')));
      await tester.pumpAndSettle();
      expect(longPressed, isTrue);
    });

    testWidgets('horizontal drag updates position', (WidgetTester tester) async {
      double dx = 0;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: GestureDetector(
                key: const ValueKey<String>('drag-target'),
                onHorizontalDragUpdate: (DragUpdateDetails d) => dx += d.delta.dx,
                child: const SizedBox(
                  width: 120,
                  height: 120,
                  child: ColoredBox(color: Colors.green),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.drag(find.byKey(const ValueKey<String>('drag-target')), const Offset(50, 0));
      await tester.pumpAndSettle();
      expect(dx, greaterThan(40));
    });

    testWidgets('double tap recognized', (WidgetTester tester) async {
      int doubleTapCount = 0;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: GestureDetector(
                key: const ValueKey<String>('doubletap-target'),
                onDoubleTap: () => doubleTapCount++,
                child: const SizedBox(
                  width: 100,
                  height: 100,
                  child: ColoredBox(color: Colors.orange),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const ValueKey<String>('doubletap-target')));
      await tester.pump(const Duration(milliseconds: 50));
      await tester.tap(find.byKey(const ValueKey<String>('doubletap-target')));
      await tester.pumpAndSettle();
      expect(doubleTapCount, 1);
    });
  });

  // ===================== IME =====================
  group('IME', () {
    testWidgets('text field accepts input', (WidgetTester tester) async {
      final TextEditingController controller = TextEditingController();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: TextField(
                key: const ValueKey<String>('ime-field'),
                controller: controller,
                decoration: const InputDecoration(labelText: '输入'),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const ValueKey<String>('ime-field')));
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(const ValueKey<String>('ime-field')), 'hello ohos');
      await tester.pumpAndSettle();
      expect(controller.text, 'hello ohos');
    });

    testWidgets('obscured text field masks input', (WidgetTester tester) async {
      final TextEditingController controller = TextEditingController();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: TextField(
                key: const ValueKey<String>('ime-obscured'),
                controller: controller,
                obscureText: true,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const ValueKey<String>('ime-obscured')));
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(const ValueKey<String>('ime-obscured')), 'secret123');
      await tester.pumpAndSettle();
      expect(controller.text, 'secret123');

      final EditableText editable = tester.widget<EditableText>(find.byType(EditableText).at(0));
      expect(editable.obscureText, isTrue);
    });

    testWidgets('max length enforces limit', (WidgetTester tester) async {
      final TextEditingController controller = TextEditingController();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: TextField(
                key: const ValueKey<String>('ime-maxlen'),
                controller: controller,
                maxLength: 5,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const ValueKey<String>('ime-maxlen')));
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(const ValueKey<String>('ime-maxlen')), '123456789');
      await tester.pumpAndSettle();
      expect(controller.text.length, lessThanOrEqualTo(5));
    });
  });

  // ===================== 无障碍 =====================
  group('accessibility', () {
    testWidgets('semantics label exposed', (WidgetTester tester) async {
      final SemanticsHandle handle = tester.ensureSemantics();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: Semantics(
                label: '通知开关',
                child: const SizedBox(
                  key: ValueKey<String>('a11y-label'),
                  width: 50,
                  height: 50,
                  child: ColoredBox(color: Colors.purple),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final SemanticsNode sem = tester.getSemantics(
        find.byKey(const ValueKey<String>('a11y-label')),
      );
      expect(sem.getSemanticsData().label, '通知开关');
      handle.dispose();
    });

    testWidgets('button semantics has tap action', (WidgetTester tester) async {
      final SemanticsHandle handle = tester.ensureSemantics();
      int taps = 0;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: ElevatedButton(
                key: const ValueKey<String>('a11y-button'),
                onPressed: () => taps++,
                child: const Text('提交'),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final SemanticsNode sem = tester.getSemantics(
        find.byKey(const ValueKey<String>('a11y-button')),
      );
      final SemanticsData data = sem.getSemanticsData();
      expect(data.hasAction(SemanticsAction.tap), isTrue);
      expect(data.label, '提交');
      handle.dispose();
    });
  });

  // ===================== 渲染表现 =====================
  group('rendering', () {
    testWidgets('widget renders at expected size', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                key: ValueKey<String>('render-size'),
                width: 200,
                height: 100,
                child: ColoredBox(color: Colors.teal),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final Size box = tester.getSize(find.byKey(const ValueKey<String>('render-size')));
      expect(box.width, 200);
      expect(box.height, 100);
    });

    testWidgets('text renders correct content', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: Text(
                'ohos parity',
                key: ValueKey<String>('render-text'),
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final Text text = tester.widget<Text>(find.byKey(const ValueKey<String>('render-text')));
      expect(text.data, 'ohos parity');
    });

    testWidgets('container background color applied', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: Container(
                key: const ValueKey<String>('render-color'),
                width: 80,
                height: 80,
                decoration: const BoxDecoration(color: Colors.indigo),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final Container container = tester.widget<Container>(
        find.byKey(const ValueKey<String>('render-color')),
      );
      final Decoration? decoration = container.decoration;
      expect(decoration, isA<BoxDecoration>());
      expect((decoration! as BoxDecoration).color, Colors.indigo);
    });
  });
}
