import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:color_change_app/src/home_screen.dart';

void main() {
  testWidgets('HomeScreen widget test', (WidgetTester tester) async {
    // Build the HomeScreen widget
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

    // Verify that the initial background color is not null
    final container =
        tester.widget<AnimatedContainer>(find.byType(AnimatedContainer));
    expect((container.decoration as BoxDecoration).color, isNotNull);

    // Tap the screen and verify that the background color changes
    await tester.tap(find.byType(AnimatedContainer));
    await tester.pumpAndSettle();
    final newContainer =
        tester.widget<AnimatedContainer>(find.byType(AnimatedContainer));
    expect((newContainer.decoration as BoxDecoration).color,
        isNot(equals((container.decoration as BoxDecoration).color)));

    // Open the drawer and verify that it contains a list tile with 'Color History' text
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    expect(find.byType(Drawer), findsOneWidget);
    expect(find.text('Color History'), findsOneWidget);

    // Close the drawer
    await tester.tap(find.byType(Drawer));
    await tester.pumpAndSettle();
  });
}
