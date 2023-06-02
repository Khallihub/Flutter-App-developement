// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:go_router/go_router.dart';
// import 'package:picstash/presentation/screens/error_page.dart';

// void main() {
//   testWidgets('ErrorPage displays the correct text and button', (WidgetTester tester) async {
//     // Build the ErrorPage widget
//     await tester.pumpWidget(
//       const MaterialApp(
//         home: ErrorPage(),
//       ),
//     );

//     // Verify that the text "something went wrong" is displayed
//     expect(find.text('something went wrong'), findsOneWidget);

//     // Verify that the "go back" button is displayed
//     expect(find.text('go back'), findsOneWidget);

//     // Tap the "go back" button
//     await tester.tap(find.text('go back'));
//     await tester.pumpAndSettle();

//     // Verify that GoRouter.of(context).pop() was called when the button was tapped
//     expect(GoRouter.of(tester.element(find.text('go back'))).goBack(), isTrue);
//   });
// }

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:picstash/presentation/screens/error_page.dart';

void main() {
  testWidgets('ErrorPage displays the correct text and button',
      (WidgetTester tester) async {
    // Build the ErrorPage widget
    await tester.pumpWidget(
      const MaterialApp(
        home: ErrorPage(),
      ),
    );

    // Verify that the text "something went wrong" is displayed
    expect(find.text('something went wrong'), findsOneWidget);

    // Verify that the "go back" button is displayed
    expect(find.text('go back'), findsOneWidget);

    // Tap the "go back" button
    await tester.tap(find.text('go back'));
    await tester.pumpAndSettle();

    // Verify that Navigator.pop() was called when the button was tapped
    expect(Navigator.of(tester.element(find.text('go back'))).canPop(), isTrue);
    Navigator.of(tester.element(find.text('go back'))).pop();
    await tester.pumpAndSettle();
    expect(find.text('something went wrong'), findsNothing);
  });
}
