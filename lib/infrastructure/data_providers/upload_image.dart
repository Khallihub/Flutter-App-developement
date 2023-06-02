import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import '../../domain/constants.dart';

class PickedImage {
  final Uint8List? bytes;
  final String? filename;

  PickedImage({this.bytes, this.filename});
}

class UploadImage {
  static Future<PickedImage?> pickImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );

      if (result != null) {
        if (result.files.single.bytes != null) {
          String? filename = result.files.single.name;
          return PickedImage(
              bytes: result.files.single.bytes, filename: filename);
        }
      }
      return null;
    } on PlatformException catch (e) {
      throw Exception("Error while picking the file: $e");
    }
  }

  static Future<String?> uploadImage(PickedImage pickedImage) async {
    String filename = pickedImage.filename!;
    Uint8List file = pickedImage.bytes!;
    Dio dio = Dio();

    FormData formData = FormData.fromMap({
      "key": Constants.apiKey,
      "image": MultipartFile.fromBytes(
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
  }
}
