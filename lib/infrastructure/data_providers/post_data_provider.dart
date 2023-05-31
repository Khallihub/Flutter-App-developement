import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:picstash/domain/constants.dart';

import '../factory models/post_factory.dart';

class PostDataProvider {
  static const String _baseUrl = "${Constants.baseUrl}/post";

  Future<Post> create(Post post) async {
    final http.Response response =
        await http.post(Uri.parse("$_baseUrl/createPost"),
            headers: <String, String>{"Content-Type": "application/json"},
            body: jsonEncode({
              "title": post.title,
              "description": post.description,
              "author": post.author,
              "createdAt": post.createdAt,
              "categories": post.categories,
              "sourceURL": post.sourceURL,
            }));

    if (response.statusCode == 201) {
      return Post.fromJson(jsonDecode(response.body));
    }
    {
      throw Exception("Failed to create post");
    }
  }

  Future<Post> update(int id, Post post) async {
    final response = await http.put(Uri.parse("$_baseUrl/updatePost"),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode({
          "id": id,
          "userName": post.author,
          "title": post.title,
          "description": post.description,
          "categories": post.categories,
          "sourceURL": post.sourceURL,
        }));

    if (response.statusCode == 200) {
      return Post.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Could not update the course");
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

  Future<List<Post>> fetchAll() async {
    final response = await http.get(Uri.parse("$_baseUrl/getFeed"));
    if (response.statusCode == 200) {
      final posts = await json.decode(response.body) as List;
      List<Post> post = [];
      for (var i = 0; i < posts.length; i++) {
        post.add(Post.fromJson(posts[i]));
      }
      return post;
    } else {
      throw Exception("Could not fetch courses");
    }
  }

  Future<void> delete(int id) async {
    final response = await http.delete(
      Uri.parse("$_baseUrl/deletePost"),
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode(
        {
          "id": id,
        },
      ),
    );
    if (response.statusCode != 204) {
      throw Exception("Field to delete the course");
    }
  }

  Future<Post> comment(Map<String, String> data) async {
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
      // List<List> comment = [];
      // for (var i = 0; i < comments.length; i++) {
      //   comment.add([comments[i]["userName"], comments[i]["comment"]]);
      // }
      return comments;
    } else {
      throw Exception("Could not fetch courses");
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
      // List<List> comment = [];
      // for (var i = 0; i < comments.length; i++) {
      //   comment.add([comments[i]["userName"], comments[i]["comment"]]);
      // }
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
      final comments = await jsonDecode(response.body);
      // List<List> comment = [];
      // for (var i = 0; i < comments.length; i++) {
      //   comment.add([comments[i]["userName"], comments[i]["comment"]]);
      // }
      return comments;
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
      return [post];
    } else {
      throw Exception("Could not fetch courses");
    }
  }
}
