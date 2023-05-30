import 'dart:convert';

import 'package:http/http.dart' as http;

import '../factory models/chat_factory.dart';

class ChatDataProvider {
  static const String _baseUrl = "http://127.0.0.1:3000/chat";

  // Future<Post> create(Post post) async {
  //   final http.Response response =
  //       await http.post(Uri.parse("$_baseUrl/createPost"),
  //           headers: <String, String>{"Content-Type": "application/json"},
  //           body: jsonEncode({
  //             "title": post.title,
  //             "description": post.description,
  //             "author": post.author,
  //             "createdAt": post.createdAt,
  //             "categories": post.categories,
  //             "sourceURL": post.sourceURL,
  //           }));

  //   if (response.statusCode == 201) {
  //     return Post.fromJson(jsonDecode(response.body));
  //   }
  //   {
  //     throw Exception("Failed to create post");
  //   }
  // }

  // Future<Post> update(int id, Post post) async {
  //   final response = await http.put(Uri.parse("$_baseUrl/updatePost"),
  //       headers: <String, String>{"Content-Type": "application/json"},
  //       body: jsonEncode({
  //         "id": id,
  //         "userName": post.author,
  //         "title": post.title,
  //         "description": post.description,
  //         "categories": post.categories,
  //         "sourceURL": post.sourceURL,
  //       }));

  //   if (response.statusCode == 200) {
  //     return Post.fromJson(jsonDecode(response.body));
  //   } else {
  //     throw Exception("Could not update the course");
  //   }
  // }

  // Future<Post> likeUnlike(Map<String, String> data) async {
  //   final http.Response response = await http.post(Uri.parse("$_baseUrl/like"),
  //       headers: <String, String>{"Content-Type": "application/json"},
  //       body: jsonEncode({
  //         "id": data["id"],
  //         "userName": data["userName"],
  //       }));

  //   if (response.statusCode == 201) {
  //     return Post.fromJson(jsonDecode(response.body));
  //   }
  //   {
  //     throw Exception("Failed to like/unlike");
  //   }
  // }

  // Future<Post> dislikeUndislike(Map<String, String> data) async {
  //   final http.Response response =
  //       await http.post(Uri.parse("$_baseUrl/dislike"),
  //           headers: <String, String>{"Content-Type": "application/json"},
  //           body: jsonEncode({
  //             "id": data["id"],
  //             "userName": data["userName"],
  //           }));

  //   if (response.statusCode == 201) {
  //     return Post.fromJson(jsonDecode(response.body));
  //   }
  //   {
  //     throw Exception("Failed to dislike/undislike");
  //   }
  // }

  Future<Chat> fetchChat(Map<String, String> data) async {
    final response = await http.post(Uri.parse("$_baseUrl/getChat"),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode({
          "user1": data["user1"],
          "user2": data["user2"],
        }));
    if (response.statusCode == 201) {
      final chat = await json.decode(response.body);
      Chat decodedChat = Chat.fromJson(chat);
      
      return decodedChat;
    } else {
      throw Exception("Could not fetch courses");
    }
  }

  Future<Chat> createChat(Map<String, String> data) async {
    final response = await http.post(Uri.parse("$_baseUrl/createChat"),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode({
          "user1": data["user1"],
          "user2": data["user2"],
        }));
    if (response.statusCode == 201) {
      final chat = await json.decode(response.body);
      Chat decodedChat = Chat.fromJson(chat);
      
      return decodedChat;
    } else {
      throw Exception("Could not fetch courses");
    }

  }

  Future<Chat> renameChat(Map<String, String> data) async {
    final response = await http.put(Uri.parse("$_baseUrl/renameChat"),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode({
          "user1": data["user1"],
          "user2": data["user2"],
          "sender": data["sender"],
          "newName": data["newName"],

        }));
    if (response.statusCode == 201) {
      final chat = await json.decode(response.body);
      Chat decodedChat = Chat.fromJson(chat);
      
      return decodedChat;
    } else {
      throw Exception("Could not fetch courses");
    }
  }

  Future<Chat> deleteChat(Map<String, String> data) async {
    final response = await http.delete(Uri.parse("$_baseUrl/deleteChat"),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode({
          "user1": data["user1"],
          "user2": data["user2"],
        }));
    if (response.statusCode == 201) {
      final chat = await json.decode(response.body);
      Chat decodedChat = Chat.fromJson(chat);
      
      return decodedChat;
    } else {
      throw Exception("Could not fetch courses");
    }

  }

  Future<Chat> updateMessage (Map<String, String> data) async {
    final response = await http.put(Uri.parse("$_baseUrl/updateMessage"),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode({
          "user1": data["user1"],
          "user2": data["user2"],
          "sender": data["sender"],
          "newName": data["newName"],
        }));
    if (response.statusCode == 201) {
      final chat = await json.decode(response.body);
      Chat decodedChat = Chat.fromJson(chat);
      
      return decodedChat;
    } else {
      throw Exception("Could not fetch courses");
    }

  }

  Future<Chat> sendMessage(Map<String, String> data) async {
    final response = await http.post(Uri.parse("$_baseUrl/sendMessage"),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode({
          "user1": data["user1"],
          "user2": data["user2"],
          "sender": data["sender"],
          "message": data["message"],
        }));
    if (response.statusCode == 201) {
      final chat = await json.decode(response.body);
      Chat decodedChat = Chat.fromJson(chat);
      
      return decodedChat;
    } else {
      throw Exception("Could not fetch courses");
    }
  }

  Future<Chat> deleteMessage(Map<String, String> data) async {
    final response = await http.delete(Uri.parse("$_baseUrl/deleteMessage"),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode({
          "user1": data["user1"],
          "user2": data["user2"],
          "time": data["time"],
        }));
    if (response.statusCode == 201) {
      final chat = await json.decode(response.body);
      Chat decodedChat = Chat.fromJson(chat);
      
      return decodedChat;
    } else {
      throw Exception("Could not fetch courses");
    }
  }

  // Future<void> delete(int id) async {
  //   final response = await http.delete(
  //     Uri.parse("$_baseUrl/deletePost"),
  //     headers: <String, String>{"Content-Type": "application/json"},
  //     body: jsonEncode(
  //       {
  //         "id": id,
  //       },
  //     ),
  //   );
  //   if (response.statusCode != 204) {
  //     throw Exception("Field to delete the course");
  //   }
  // }

  // Future<Post> comment(Map<String, String> data) async {
  //   final http.Response response = await http.post(
  //     Uri.parse("$_baseUrl/comment"),
  //     headers: <String, String>{"Content-Type": "application/json"},
  //     body: jsonEncode(
  //       {
  //         "id": data["id"],
  //         "userName": data["userName"],
  //         "comment": data["comment"],
  //       },
  //     ),
  //   );

  //   if (response.statusCode == 201) {
  //     return Post.fromJson(jsonDecode(response.body));
  //   }
  //   {
  //     throw Exception("Failed to comment");
  //   }
  // }

  // dynamic fetchComments(Map<String, String> id) async {
  //   final http.Response response = await http.post(
  //     Uri.parse("$_baseUrl/getComments"),
  //     headers: <String, String>{"Content-Type": "application/json"},
  //     body: jsonEncode(
  //       {
  //         "id": id["id"],
  //       },
  //     ),
  //   );
  //   if (response.statusCode == 201) {
  //     final comments = await jsonDecode(response.body);
  //     // List<List> comment = [];
  //     // for (var i = 0; i < comments.length; i++) {
  //     //   comment.add([comments[i]["userName"], comments[i]["comment"]]);
  //     // }
  //     return comments;
  //   } else {
  //     throw Exception("Could not fetch courses");
  //   }
  // }

  // fetchLikes(Map<String, String> id) async {
  //   final http.Response response = await http.post(
  //     Uri.parse("$_baseUrl/getLikes"),
  //     headers: <String, String>{"Content-Type": "application/json"},
  //     body: jsonEncode(
  //       {
  //         "id": id["id"],
  //       },
  //     ),
  //   );
  //   if (response.statusCode == 201) {
  //     final likes = await jsonDecode(response.body);
  //     // List<List> comment = [];
  //     // for (var i = 0; i < comments.length; i++) {
  //     //   comment.add([comments[i]["userName"], comments[i]["comment"]]);
  //     // }
  //     return likes;
  //   } else {
  //     throw Exception("Could not fetch courses");
  //   }
  // }

  // fetchDisLikes(Map<String, String> id) async {
  //   final http.Response response = await http.post(
  //     Uri.parse("$_baseUrl/getDislikes"),
  //     headers: <String, String>{"Content-Type": "application/json"},
  //     body: jsonEncode(
  //       {
  //         "id": id["id"],
  //       },
  //     ),
  //   );
  //   if (response.statusCode == 201) {
  //     final comments = await jsonDecode(response.body);
  //     // List<List> comment = [];
  //     // for (var i = 0; i < comments.length; i++) {
  //     //   comment.add([comments[i]["userName"], comments[i]["comment"]]);
  //     // }
  //     return comments;
  //   } else {
  //     throw Exception("Could not fetch courses");
  //   }
  // }

  // fetchSingle(Map<String, String> id) async {
  //   final http.Response response = await http.post(
  //     Uri.parse("$_baseUrl/getSinglePost"),
  //     headers: <String, String>{"Content-Type": "application/json"},
  //     body: jsonEncode(
  //       {
  //         "id": id["id"],
  //       },
  //     ),
  //   );
  //   if (response.statusCode == 201) {
  //     final post = await jsonDecode(response.body);
  //     return [post];
  //   } else {
  //     throw Exception("Could not fetch courses");
  //   }
  // }
}
