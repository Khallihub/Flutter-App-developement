// import 'dart:convert';
// import 'dart:io';

// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:http/http.dart' as http;
// import 'package:mockito/mockito.dart';
// import 'package:picstash/presentation/screens/temp.dart';
// import 'edit_profile_test.dart';

// void main() {
//   group('ImageUploader widget test', () {
//     testWidgets('selects image file from file picker',
//         (WidgetTester tester) async {
//       provideMockedNetworkImages(() async {
//         final imageFile = File('test/assets/test_image.jpg');
//         final filePickerResult = FilePickerResult(files: [
//           PlatformFile(
//             name: 'test_image.jpg',
//             size: 1234,
//             path: imageFile.path,
//           ),
//         ]);
//         FilePicker.platform =
//             MockFilePickerPlatform(result: filePickerResult) as FilePicker;

//         await tester.pumpWidget(
//           const MaterialApp(
//             home: ImageUploader(),
//           ),
//         );

//         expect(find.byType(Image), findsNothing);
//         expect(find.byType(ElevatedButton), findsNWidgets(2));

//         await tester.tap(find.byType(ElevatedButton).first);
//         await tester.pumpAndSettle();

//         expect(find.byType(Image), findsOneWidget);
//         expect(find.byType(ElevatedButton), findsNWidgets(2));

//         final imageWidget = tester.widget<Image>(find.byType(Image));
//         expect(imageWidget.image, NetworkImage('file://${imageFile.path}'));
//       });
//     });

//     testWidgets('uploads selected image file to Imgur API',
//         (WidgetTester tester) async {
//       const clientId = 'YOUR_CLIENT_ID';
//       const apiUrl = 'https://api.imgur.com/3/image';

//       final imageFile = File('test/assets/test_image.jpg');
//       final bytes = await imageFile.readAsBytes();
//       final base64Image = base64Encode(bytes);
//       const imageUrl = 'https://i.imgur.com/test.jpg';

//       final mockClient = MockClient((request) async {
//         expect(request.url, Uri.parse(apiUrl));
//         expect(request.headers['Authorization'], 'Client-ID $clientId');
//         expect(request.bodyFields, {'image': base64Image});

//         return http.Response(
//           jsonEncode({
//             'data': {'link': imageUrl}
//           }),
//           200,
//         );
//       });

//       await tester.pumpWidget(
//         const MaterialApp(
//           home: ImageUploader(),
//         ),
//       );

//       expect(find.byType(Image), findsNothing);
//       expect(find.byType(ElevatedButton), findsNWidgets(2));

//       await tester.tap(find.byType(ElevatedButton).first);
//       await tester.pumpAndSettle();

//       expect(find.byType(Image), findsOneWidget);
//       expect(find.byType(ElevatedButton), findsNWidgets(2));

//       final uploadButton = find.byType(ElevatedButton).last;
//       await tester.tap(uploadButton);
//       await tester.pumpAndSettle();

//       expect(find.byType(Image), findsOneWidget);
//       expect(find.byType(ElevatedButton), findsNWidgets(2));

//       final imageWidget = tester.widget<Image>(find.byType(Image));
//       expect(imageWidget.image, NetworkImage(imageUrl));

//       mockClient.close();
//     });
//   });
// }

// void provideMockedNetworkImages(Future<Null> Function() param0) {}

// class MockFilePickerPlatform extends Fake implements FilePickerPlatform {
//   MockFilePickerPlatform({required this.result});

//   final FilePickerResult result;

//   Future<FilePickerResult?> pickFiles({FileType? type}) async {
//     return result;
//   }
// }

// class MockClient extends Mock implements http.Client {
//   MockClient(Future<http.Response> Function(dynamic request) param0);
// }
