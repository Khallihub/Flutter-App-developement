class Chat {
  final users;
  final messages;

  Chat(
    {
    required this.users,
    required this.messages,
    }   
  );

  factory Chat.fromJson(Map<String, dynamic> json) {
    final post = Chat(
      users: json['users'],
      messages: json['messages'],
    );
    return post;
  }
}
