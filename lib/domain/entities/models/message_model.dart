class Message {
  final String sender;
  final String text;
  final DateTime createdAt;

  const Message({ required this.sender,
    required this.text,
    required this.createdAt,
  });
}
