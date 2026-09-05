// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// widget_behavior 迭代 2 —— 深入扩展：
// A. 平台集成层（截图等已知 ohos 缺陷，平台条件 skip）
// B. IME 深化（退格/焦点切换/富文本）
// C. 手势高级（双指缩放/惯性 fling）
// D. 无障碍深化（合并语义/选中状态语义）
// E. 渲染深化（阴影/渐变/ClipPath/透明度合成）
// 真机 android-vs-ohos 差分。

import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  final IntegrationTestWidgetsFlutterBinding binding =
      IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // ===================== A. 平台集成层（已知 ohos 缺陷） =====================
  group('platform-integration', () {
    // ohos 已知缺陷：flutter/screenshot 通道未实现。ohos 跳过，android 仍跑作基线。
    testWidgets('screenshot capture returns non-empty', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(width: 50, height: 50, child: ColoredBox(color: Colors.blue)),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      // android 需先将 Flutter surface 转为 image 才能截图；ohos 该测试已 skip（通道未实现）。
      await binding.convertFlutterSurfaceToImage();
      await tester.pumpAndSettle();
      final List<int> png = await binding.takeScreenshot('pi-screenshot');
      expect(png.isNotEmpty, isTrue);
    }, skip: defaultTargetPlatform == TargetPlatform.ohos);

    testWidgets('safe area inset is valid (non-negative)', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: SafeArea(child: SizedBox(width: 10, height: 10))),
        ),
      );
      await tester.pumpAndSettle();
      final MediaQueryData data = tester.firstWidget<MediaQuery>(find.byType(MediaQuery)).data;
      expect(data.padding.top, greaterThanOrEqualTo(0));
      expect(data.padding.left, greaterThanOrEqualTo(0));
    });
  });

  // ===================== B. IME 深化 =====================
  group('IME-deep', () {
    testWidgets('text replacement via IME', (WidgetTester tester) async {
      final TextEditingController controller = TextEditingController();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: TextField(key: const ValueKey<String>('ime-replace'), controller: controller),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey<String>('ime-replace')));
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(const ValueKey<String>('ime-replace')), 'abc');
      await tester.pumpAndSettle();
      expect(controller.text, 'abc');
      // 再次输入会替换选中内容。
      await tester.enterText(find.byKey(const ValueKey<String>('ime-replace')), 'xyz');
      await tester.pumpAndSettle();
      expect(controller.text, 'xyz');
    });

    testWidgets('focus moves between fields', (WidgetTester tester) async {
      final FocusNode node1 = FocusNode();
      final FocusNode node2 = FocusNode();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: <Widget>[
                TextField(key: const ValueKey<String>('ime-f1'), focusNode: node1, autofocus: true),
                TextField(key: const ValueKey<String>('ime-f2'), focusNode: node2),
              ],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(node1.hasFocus, isTrue);

      await tester.tap(find.byKey(const ValueKey<String>('ime-f2')));
      await tester.pumpAndSettle();
      expect(node2.hasFocus, isTrue);
      expect(node1.hasFocus, isFalse);
    });

    testWidgets('rich text (Text.rich) renders', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: Text.rich(
                TextSpan(
                  text: 'ohos',
                  style: TextStyle(color: Colors.red),
                  children: <InlineSpan>[
                    TextSpan(
                      text: 'parity',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
                key: ValueKey<String>('ime-richtext'),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey<String>('ime-richtext')), findsOneWidget);
    });
  });

  // ===================== C. 手势高级 =====================
  group('gesture-advanced', () {
    testWidgets('scale (two-finger pinch out)', (WidgetTester tester) async {
      double scale = 1.0;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: GestureDetector(
                key: const ValueKey<String>('scale-target'),
                onScaleUpdate: (ScaleUpdateDetails d) => scale = d.scale,
                child: const SizedBox(
                  width: 200,
                  height: 200,
                  child: ColoredBox(color: Colors.amber),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      final Offset center = tester.getCenter(find.byKey(const ValueKey<String>('scale-target')));
      final TestGesture g1 = await tester.startGesture(center + const Offset(-30, 0));
      final TestGesture g2 = await tester.startGesture(center + const Offset(30, 0));
      // 双指向外拉开 → scale > 1。
      await g1.moveTo(center + const Offset(-80, 0));
      await g2.moveTo(center + const Offset(80, 0));
      await tester.pump();
      await g1.up();
      await g2.up();
      await tester.pumpAndSettle();
      expect(scale, greaterThan(1.0));
    });

    testWidgets('fling with inertia settles', (WidgetTester tester) async {
      double offset = 0;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: GestureDetector(
                key: const ValueKey<String>('fling-target'),
                onHorizontalDragUpdate: (DragUpdateDetails d) => offset += d.delta.dx,
                child: const SizedBox(
                  width: 200,
                  height: 200,
                  child: ColoredBox(color: Colors.cyan),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.fling(
        find.byKey(const ValueKey<String>('fling-target')),
        const Offset(80, 0),
        800,
      );
      await tester.pumpAndSettle();
      expect(offset, greaterThan(50));
    });
  });

  // ===================== D. 无障碍深化 =====================
  group('accessibility-deep', () {
    testWidgets('merged semantics combines labels', (WidgetTester tester) async {
      final SemanticsHandle handle = tester.ensureSemantics();
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: MergeSemantics(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('A', key: ValueKey<String>('a1')),
                    Text('B', key: ValueKey<String>('a2')),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      final SemanticsNode node = tester.getSemantics(find.byKey(const ValueKey<String>('a1')));
      expect(node.getSemanticsData().label, contains('A'));
      handle.dispose();
    });

    testWidgets('checkbox selected state in semantics', (WidgetTester tester) async {
      final SemanticsHandle handle = tester.ensureSemantics();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: Checkbox(
                key: const ValueKey<String>('a11y-checkbox'),
                value: true,
                onChanged: (bool? v) {},
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      final SemanticsNode node = tester.getSemantics(
        find.byKey(const ValueKey<String>('a11y-checkbox')),
      );
      expect(node.getSemanticsData().hasFlag(SemanticsFlag.isChecked), isTrue);
      handle.dispose();
    });
  });

  // ===================== E. 渲染深化 =====================
  group('rendering-deep', () {
    testWidgets('box shadow renders without crash', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: Container(
                key: const ValueKey<String>('shadow'),
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: <BoxShadow>[BoxShadow(blurRadius: 8, offset: Offset(2, 2))],
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey<String>('shadow')), findsOneWidget);
    });

    testWidgets('linear gradient renders', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: Container(
                key: const ValueKey<String>('gradient'),
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: <Color>[Colors.red, Colors.blue]),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey<String>('gradient')), findsOneWidget);
      final Container c = tester.widget<Container>(find.byKey(const ValueKey<String>('gradient')));
      expect(c.decoration, isA<BoxDecoration>());
    });

    testWidgets('clip path renders', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: ClipPath(
                key: const ValueKey<String>('clip'),
                clipper: _HalfClipper(),
                child: const SizedBox(
                  width: 100,
                  height: 100,
                  child: ColoredBox(color: Colors.deepPurple),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey<String>('clip')), findsOneWidget);
    });

    testWidgets('opacity compositing renders', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: Opacity(
                key: ValueKey<String>('opacity'),
                opacity: 0.5,
                child: SizedBox(width: 60, height: 60, child: ColoredBox(color: Colors.pink)),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      final Opacity op = tester.widget<Opacity>(find.byKey(const ValueKey<String>('opacity')));
      expect(op.opacity, 0.5);
    });
  });
}

class _HalfClipper extends CustomClipper<ui.Path> {
  @override
  ui.Path getClip(ui.Size size) {
    final ui.Path path = ui.Path()..addRect(ui.Rect.fromLTWH(0, 0, size.width, size.height / 2));
    return path;
  }

  @override
  bool shouldReclip(covariant _HalfClipper oldClipper) => false;
}
