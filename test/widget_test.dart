import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:appium_testing_app/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Pump the InputControlsPage where the counter lives
    await tester.pumpWidget(const MaterialApp(home: InputControlsPage()));

    // Verify counter starts at 0
    expect(find.text('Value: 0'), findsOneWidget);
    expect(find.text('Value: 1'), findsNothing);

    // Tap the increment button
    await tester.tap(find.byKey(const Key('increment_button')));
    await tester.pump();

    // Verify counter incremented to 1
    expect(find.text('Value: 0'), findsNothing);
    expect(find.text('Value: 1'), findsOneWidget);
  });
}
