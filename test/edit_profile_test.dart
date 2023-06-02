import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:picstash/presentation/screens/editProfile_screen.dart';

class MockFilePickerResult extends Mock implements FilePickerResult {}

class MockFilePickerPlatform extends Mock implements FilePickerPlatform {
  Future<FilePickerResult?> pickFiles({
    FileType type = FileType.any,
    List<String>? allowedExtensions,
    bool allowMultiple = false,
    bool withData = false,
    String? dialogTitle,
    String? dialogButtonText,
  }) async {
    return MockFilePickerResult();
  }
}

class FilePickerPlatform {}

extension CustomFinders on WidgetTester {
  Finder byTextField({int index = 0}) {
    return find.byWidgetPredicate((widget) {
      return widget is TextField && widget.decoration!.hintText != null;
    }, description: 'TextField at index $index');
  }
}

void main() {
  group('EditProfileScreen', () {
    testWidgets('should display default avatar when no image is selected',
        (tester) async {
      await tester.pumpWidget(const MaterialApp(home: EditProfileScreen()));

      final avatar = find.byType(CircleAvatar);
      expect(avatar, findsOneWidget);

      final icon = find.byIcon(Icons.person);
      expect(icon, findsOneWidget);
    });

    testWidgets('should display selected image as avatar', (tester) async {
      final mockFilePickerResult = MockFilePickerResult();
      when(mockFilePickerResult.files).thenReturn([
        PlatformFile(
          name: 'avatar.jpg',
          size: 1024,
          path: '/path/to/avatar.jpg',
          bytes: Uint8List.fromList([1, 2, 3, 4]),
        )
      ]);

      final mockFilePickerPlatform = MockFilePickerPlatform();
      when(mockFilePickerPlatform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      )).thenAnswer((_) async => mockFilePickerResult);

      FilePicker.platform = mockFilePickerPlatform as FilePicker;

      await tester.pumpWidget(const MaterialApp(home: EditProfileScreen()));

      final avatar = find.byType(CircleAvatar);
      expect(avatar, findsOneWidget);

      await tester.tap(avatar);
      await tester.pumpAndSettle();

      expect(find.byType(ClipOval), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('should update name and bio when text is entered',
        (tester) async {
      await tester.pumpWidget(const MaterialApp(home: EditProfileScreen()));

      final nameField = tester.byTextField(index: 0);
      final bioField = tester.byTextField(index: 1);

      await tester.enterText(nameField, 'John Doe');
      await tester.enterText(bioField, 'I am a software engineer');

      expect(_getTextFieldValue(nameField), 'John Doe');
      expect(_getTextFieldValue(bioField), 'I am a software engineer');
    });

    testWidgets(
        'should navigate back to previous screen when "Save" button is pressed',
        (tester) async {
      final navigatorKey = GlobalKey<NavigatorState>();

      await tester.pumpWidget(MaterialApp(
        navigatorKey: navigatorKey,
        home: const EditProfileScreen(),
      ));

      final saveButton = find.widgetWithText(ElevatedButton, 'Save');
      expect(saveButton, findsOneWidget);

      await tester.tap(saveButton);
      await tester.pumpAndSettle();

      expect(navigatorKey.currentState!.canPop(), isTrue);
    });

    testWidgets('should go back to profile screen when back button is pressed',
        (tester) async {
      final navigatorKey = GlobalKey<NavigatorState>();

      await tester.pumpWidget(MaterialApp(
        navigatorKey: navigatorKey,
        home: const EditProfileScreen(),
      ));

      final backButton = find.byType(BackButton);
      expect(backButton, findsOneWidget);

      await tester.tap(backButton);
      await tester.pumpAndSettle();

      expect(find.byType(ProfileScreen), findsOneWidget);
    });

    testWidgets('should display error message when file selection fails',
        (tester) async {
      final mockFilePickerPlatform = MockFilePickerPlatform();
      when(mockFilePickerPlatform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      )).thenThrow('File selection failed');

      FilePicker.platform = mockFilePickerPlatform as FilePicker;

      await tester.pumpWidget(const MaterialApp(home: EditProfileScreen()));

      final avatar = find.byType(CircleAvatar);
      expect(avatar, findsOneWidget);

      await tester.tap(avatar);
      await tester.pumpAndSettle();

      expect(find.text('File selection failed'), findsOneWidget);
    });
  });
}

class ProfileScreen {}

String _getTextFieldValue(Finder textFieldFinder) {
  final textField = textFieldFinder.evaluate().first.widget as TextField;
  return textField.controller!.text;
}
