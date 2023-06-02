import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:picstash/presentation/screens/edit_profile_screen.dart';

// Create a mock FilePickerResult for testing
class MockFilePickerResult extends Mock implements FilePickerResult {}

void main() {
  testWidgets('EditProfileScreen displays profile data',
      (WidgetTester tester) async {
    // Build the EditProfileScreen widget
    await tester.pumpWidget(const MaterialApp(home: EditProfileScreen()));

    // Verify that the UI displays the correct widgets
    expect(find.byType(CircleAvatar), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Name'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Bio'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Save'), findsOneWidget);
  });

  testWidgets('EditProfileScreen updates profile data',
      (WidgetTester tester) async {
    // Create a mock FilePickerResult with sample image data
    final mockFilePickerResult = MockFilePickerResult();
    when(mockFilePickerResult.files)
        .thenReturn([PlatformFile(path: 'test.png', name: 'Amir', size: 0)]);

    // Build the EditProfileScreen widget
    await tester.pumpWidget(const MaterialApp(home: EditProfileScreen()));

    // Tap the "Add Image" button
    await tester.tap(find.byType(CircleAvatar));
    await tester.pump();

    // Mock the FilePicker to return the mock FilePickerResult
    when(FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    )).thenAnswer((_) => Future.value(mockFilePickerResult));

    // Verify that the profile image is updated
    expect(find.byType(CircleAvatar), findsOneWidget);
    expect(find.byType(Icon), findsOneWidget);
    expect(find.byType(Image), findsNothing);

    // Enter new values in the name and bio fields
    await tester.enterText(find.widgetWithText(TextField, 'Name'), 'New Name');
    await tester.enterText(find.widgetWithText(TextField, 'Bio'), 'New Bio');

    // Tap the "Save" button
    await tester.tap(find.widgetWithText(ElevatedButton, 'Save'));
    await tester.pump();

    // Verify that the screen is popped and the changes are saved
    expect(find.byType(EditProfileScreen), findsNothing);
  });
}
