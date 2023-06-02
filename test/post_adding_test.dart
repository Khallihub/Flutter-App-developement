import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('AddPostWidget test', (WidgetTester tester) async {
    // Build the widget
    // await tester.pumpWidget(const MaterialApp(
    //   home: AddPostWidget(),
    // ));

    // Verify that the title and description text fields are empty
    expect(find.widgetWithText(TextField, 'Title'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Description'), findsOneWidget);
    expect(
        (tester.widget(find.widgetWithText(TextField, 'Title')) as TextField)
            .controller!
            .text,
        '');
    expect(
        (tester.widget(find.widgetWithText(TextField, 'Description'))
                as TextField)
            .controller!
            .text,
        '');

    // Enter text into the title and description text fields
    await tester.enterText(
        find.widgetWithText(TextField, 'Title'), 'Test Title');
    await tester.enterText(
        find.widgetWithText(TextField, 'Description'), 'Test Description');

    // Tap the upload image button
    await tester.tap(find.widgetWithText(ElevatedButton, 'Upload Image'));
    await tester.pump();

    // Verify that the post button is disabled
    expect(find.widgetWithText(ElevatedButton, 'Post'), findsOneWidget);
    expect(
        (tester.widget(find.widgetWithText(ElevatedButton, 'Post'))
                as ElevatedButton)
            .enabled,
        isFalse);

    // Tap the post button
    await tester.tap(find.widgetWithText(ElevatedButton, 'Post'));
    await tester.pump();

    // Verify that the post was submitted
    // (This would depend on your app's implementation)
  });
}
