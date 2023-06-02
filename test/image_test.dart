import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:picstash/presentation/screens/image.dart';

void main() {
  testWidgets(
      'ResponsiveLikeButton displays correct like count and changes state when tapped',
      (WidgetTester tester) async {
    // Build the ResponsiveLikeButton widget
    await tester.pumpWidget(const MaterialApp(home: ResponsiveLikeButton()));

    // Verify that the UI displays the correct widgets and default state
    expect(find.byType(Icon), findsOneWidget);
    expect(find.text('0'), findsOneWidget);
    expect(find.byIcon(Icons.favorite_border), findsOneWidget);
    // expect(find.byIcon(Icons.favorite, color: Colors.red), findsNothing);  ??

    // Tap the like button
    await tester.tap(find.byType(InkResponse));
    await tester.pump();

    // Verify that the state is updated correctly
    expect(find.text('1'), findsOneWidget);
    // expect(find.byIcon(Icons.favorite, color: Colors.red), findsOneWidget); ??

    // Tap the like button again
    await tester.tap(find.byType(InkResponse));
    await tester.pump();

    // Verify that the state is updated correctly again
    expect(find.text('0'), findsOneWidget);
    expect(find.byIcon(Icons.favorite_border), findsOneWidget);
  });
}
