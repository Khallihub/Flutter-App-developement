class Chat {
  final user1;
  final user2;
  final lastMessage;
  final users;
  final messages;


  Chat({
    required this.user1,
    required this.user2,
    required this.lastMessage,
    required this.users,
    required this.messages,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    final post = Chat(
      user1: json["user1"],
      user2: json["user2"],
      lastMessage: json["lastMessage"],
      users: json['usersName'],
      messages: json['messages'],
    );
    return post;
  }
}
