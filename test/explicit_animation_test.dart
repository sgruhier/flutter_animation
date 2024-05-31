import 'package:flutter/material.dart';
import 'package:flutter_animation/explicit_animation_demo.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Animated container changes width over time', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: Center(
          child: AnimatedContainerWidget(),
        ),
      ),
    ));

    final containerFinder = find.byType(Container);
    expect(containerFinder, findsOneWidget);

    // Initial width should be 50
    var container = tester.widget<Container>(containerFinder);
    expect(container.constraints?.maxWidth, equals(50));

    // Advance the animation by 1 second
    await tester.pump(const Duration(seconds: 1));
    container = tester.widget<Container>(containerFinder);
    expect(container.constraints?.maxWidth, greaterThan(50));

    // Advance the animation to the end
    await tester.pump(const Duration(seconds: 1));
    container = tester.widget<Container>(containerFinder);
    expect(container.constraints?.maxWidth, equals(200));
  });
}
