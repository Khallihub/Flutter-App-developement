import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:picstash/domain/constants.dart';

import '../../factory models/post_factory.dart';

class CommentDataProvider {
  static const String _baseUrl = "${Constants.baseUrl}/post";

  Future<Post> addComment(Map<String, String> data) async {
    final http.Response response = await http.post(
      Uri.parse("$_baseUrl/comment"),
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode(
        {
          "id": data["id"],
          "userName": data["userName"],
          "comment": data["comment"],
        },
      ),
    );

    if (response.statusCode == 201) {
      return Post.fromJson(jsonDecode(response.body));
    }
    {
      throw Exception("Failed to comment");
    }
  }

  Future<Post> likeUnlike(Map<String, String> data) async {
    final http.Response response = await http.post(Uri.parse("$_baseUrl/like"),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode({
          "id": data["id"],
          "userName": data["userName"],
        }));

    if (response.statusCode == 201) {
      return Post.fromJson(jsonDecode(response.body));
    }
    {
      throw Exception("Failed to like/unlike");
    }
  }

    Future<Post> dislikeUndislike(Map<String, String> data) async {
    final http.Response response =
        await http.post(Uri.parse("$_baseUrl/dislike"),
            headers: <String, String>{"Content-Type": "application/json"},
            body: jsonEncode({
              "id": data["id"],
              "userName": data["userName"],
            }));

    if (response.statusCode == 201) {
      return Post.fromJson(jsonDecode(response.body));
    }
    {
      throw Exception("Failed to dislike/undislike");
    }
  }

  dynamic fetchComments(Map<String, String> id) async {
    final http.Response response = await http.post(
      Uri.parse("$_baseUrl/getComments"),
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode(
        {
          "id": id["id"],
        },
      ),
    );
    if (response.statusCode == 201) {
      final comments = await jsonDecode(response.body);
      return comments;
    } else {
      throw Exception("Could not fetch comments");
    }
  }

  fetchLikes(Map<String, String> id) async {
    final http.Response response = await http.post(
      Uri.parse("$_baseUrl/getLikes"),
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode(
        {
          "id": id["id"],
        },
      ),
    );
    if (response.statusCode == 201) {
      final likes = await jsonDecode(response.body);
      return likes;
    } else {
      throw Exception("Could not fetch courses");
    }
  }

  fetchDisLikes(Map<String, String> id) async {
    final http.Response response = await http.post(
      Uri.parse("$_baseUrl/getDislikes"),
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode(
        {
          "id": id["id"],
        },
      ),
    );
    if (response.statusCode == 201) {
      final disLikes = await jsonDecode(response.body);
      return disLikes;
    } else {
      throw Exception("Could not fetch courses");
    }
  }

  fetchSingle(Map<String, String> id) async {
    final http.Response response = await http.post(
      Uri.parse("$_baseUrl/getSinglePost"),
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode(
        {
          "id": id["id"],
        },
      ),
    );
    if (response.statusCode == 201) {
      final post = await jsonDecode(response.body);
      return post;
    } else {
      throw Exception("Could not fetch courses");
    }
  }
}
