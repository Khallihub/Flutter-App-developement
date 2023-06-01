import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../domain/constants.dart';
import '../../domain/entities/models/user_model.dart';
import '../factory models/chat_factory.dart';

class ChatDataProvider {


  Future<Chat> fetchChat(Map<String, String> data) async {
    final response =
        await http.post(Uri.parse("${Constants.chatBaseUrl}/getChat"),
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
      throw Exception("Could not fetch chat");
    }
  }

  Future<List<Chat>> fetchChats(Map<String, String> data) async {
    final response =
        await http.post(Uri.parse("${Constants.chatBaseUrl}/getChats"),
            headers: <String, String>{"Content-Type": "application/json"},
            body: jsonEncode({
              "user": data["user"],
            }));

    if (response.statusCode == 201) {
      final chats = await json.decode(response.body) as List;
      List<Chat> decodedChats = [];
      for (var i = 0; i < chats.length; i++) {
        decodedChats.add(Chat.fromJson(chats[i]));
      }
      return decodedChats;
    } else {
      throw Exception("Could not fetch chats");
    }
  }

  Future<Chat> createChat(Map<String, String> data) async {
    final response =
        await http.post(Uri.parse("${Constants.chatBaseUrl}/createChat"),
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
      throw Exception("Could not fetch chat");
    }
  }

  Future<Chat> renameChat(Map<String, String> data) async {
    final response =
        await http.put(Uri.parse("${Constants.chatBaseUrl}/renameChat"),
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
      throw Exception("Could not fetch chat");
    }
  }

  Future<Chat> deleteChat(Map<String, String> data) async {
    final response =
        await http.delete(Uri.parse("${Constants.chatBaseUrl}/deleteChat"),
            headers: <String, String>{"Content-Type": "application/json"},
            body: jsonEncode({
              "user1": data["user1"],
              "user2": data["user2"],
            }));
    if (response.statusCode == 200) {
      final chat = await json.decode(response.body);
      Chat decodedChat = Chat.fromJson(chat);

      return decodedChat;
    } else {
      throw Exception("Could not fetch chat");
    }
  }

  Future<Chat> updateMessage(Map<String, String> data) async {
    final response =
        await http.put(Uri.parse("${Constants.chatBaseUrl}/updateMessage"),
            headers: <String, String>{"Content-Type": "application/json"},
            body: jsonEncode({
              "user1": data["user1"],
              "user2": data["user2"],
              "sender": data["sender"],
              "time": data["time"],
              "message": data["newMessage"],

            }));
    if (response.statusCode == 200) {
      final chat = await json.decode(response.body);
      Chat decodedChat = Chat.fromJson(chat);

      return decodedChat;
    } else {
      throw Exception("Could not fetch chat");
    }
  }

  Future<Chat> sendMessage(Map<String, String> data) async {
    final response =
        await http.put(Uri.parse("${Constants.chatBaseUrl}/sendMessage"),
            headers: <String, String>{"Content-Type": "application/json"},
            body: jsonEncode({
              "user1": data["user1"],
              "user2": data["user2"],
              "sender": data["sender"],
              "message": data["message"],
            }));
    if (response.statusCode == 200) {
      final chat = await json.decode(response.body);
      Chat decodedChat = Chat.fromJson(chat);
      return decodedChat;
    } else {
      throw Exception("Could not fetch chat");
    }
  }

  Future<Chat> deleteMessage(Map<String, String> data) async {
    final response =
        await http.put(Uri.parse("${Constants.chatBaseUrl}/deleteMessage"),
            headers: <String, String>{"Content-Type": "application/json"},
            body: jsonEncode({
              "user1": data["user1"],
              "user2": data["user2"],
              "time": data["time"],
            }));
    if (response.statusCode == 200) {
      final chat = await json.decode(response.body);
      Chat decodedChat = Chat.fromJson(chat);
      return decodedChat;
    } else {
      throw Exception("Could not fetch chat");
    }
  }

  fetchUsers(Map<String, List<String>> map) async {
    List<String>? users = map["users"];
    final response = await http.post(
      Uri.parse("${Constants.usersBaseUrl}/getUsers"),
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode({
        "users": users,
      }),
    );

    if (response.statusCode == 201) {
      final users = await json.decode(response.body) as List;
      List<User> decodedUsers = [];
      for (var i = 0; i < users.length; i++) {
        decodedUsers.add(User.fromJson(users[i]));
      }
      return decodedUsers;
    } else {
      throw Exception("Could not fetch users");
    }
  }
  fetchSearchResults(String query) async {
    final response = await http.post(
      Uri.parse("${Constants.usersBaseUrl}/searchUsers"),
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode({
        "text": query,
      }),
    );

    if (response.statusCode == 201) {
      final users = await json.decode(response.body) as List;
      List<User> decodedUsers = [];
      for (var i = 0; i < users.length; i++) {
        decodedUsers.add(User.fromJson(users[i]));
      }
      return decodedUsers;
    } else {
      throw Exception("Could not fetch users");
    }
  }
}
