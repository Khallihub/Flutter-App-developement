// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:http/http.dart' as http;
// import 'package:picstash/domain/constants.dart';

// const String apiKey = Constants.apiKey;
// const String apiUrl = 'https://api.imgbb.com/1/upload';

// class ImageUploader extends StatefulWidget {
//   @override
//   _ImageUploaderState createState() => _ImageUploaderState();
// }

// class _ImageUploaderState extends State<ImageUploader> {
//   File? _imageFile;

//   Future<void> _pickImage() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.image,
//     );
//     if (result != null) {
//       setState(() {
//         _imageFile = File(result.files.single.path!);
//       });
//     }
//   }

//   Future<void> _uploadImage() async {
//     if (_imageFile == null) {
//       return;
//     }
//     print("object");
//     final bytes = await _imageFile!.readAsBytes();
//     final base64Image = base64Encode(bytes);
//     final response = await http.post(
//       Uri.parse(apiUrl),
//       body: {
//         'key': apiKey,
//         'image': base64Image,
//         'name': _imageFile!.path.split('/').last,
//         'expiration': '3600', // optional, in seconds
//       },
//     );
//     // Handle the response here
//     print(response.body);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Image Uploader'),
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               if (_imageFile != null)
//                 Image.file(
//                   _imageFile!,
//                   height: 300,
//                 ),
//               ElevatedButton(
//                 onPressed: _pickImage,
//                 child: Text('Pick Image'),
//               ),
//               ElevatedButton(
//                 onPressed: _uploadImage,
//                 child: Text('Upload Image'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

import '../../domain/constants.dart';

class ImageUploader extends StatefulWidget {
  const ImageUploader({super.key});

  @override
  State<ImageUploader> createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {
  File? _imageFile;

  Future<void> _pickImage() async {
    FilePickerResult? result;
    try {
      result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );
    } catch (e) {
      throw Exception(e);
    }

    if (result != null) {
      Uint8List? uploadfile = result.files.single.bytes;
      String filename = basename(result.files.single.name);
      uploadImage(uploadfile, filename);
    }
  }

  Future<String?> uploadImage(Uint8List? file, String filename) async {
    if (file != null) {
      Dio dio = Dio();

      FormData formData = FormData.fromMap({
        "key": Constants.apiKey,
        "image": await MultipartFile.fromBytes(
          file,
          filename: filename,
        ),
        "name": filename,
      });
      var response = await dio.post(
        "https://api.imgbb.com/1/upload",
        data: formData,
        onSendProgress: ((count, total) {
          stdout.write("$count , $total");
        }),
      );
      String avatarUrl = response.data["data"]["url"];
      return avatarUrl;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Uploader'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_imageFile != null)
                Image.file(
                  _imageFile!,
                  height: 300,
                ),
              // ElevatedButton(
              //   onPressed: _pickImage,
              //   child: const Text('Pick Image'),
              // ),
              ElevatedButton(
                onPressed: () async {
                  await _pickImage();
                },
                child: const Text('Upload Image'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
