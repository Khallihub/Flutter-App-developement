import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UploadImage {
  static Future<String> uploadImage(File imageFile) async {
    String apiKey = "6d207e02198a847aa98d0a2a901485a5";
    const url = 'https://freeimage.host/api/1/upload';
    final request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields['key'] = apiKey;
    request.fields['format'] = 'json';
    request.fields['action'] = 'upload';
    request.files
        .add(await http.MultipartFile.fromPath('source', imageFile.path));

    final response = await request.send();
    final responseJson = json.decode(await response.stream.bytesToString());

    if (response.statusCode == 200 && responseJson['status'] == 'success') {
      return responseJson['image']['url'];
    } else {
      throw Exception('Failed to upload image');
    }
  }
}
