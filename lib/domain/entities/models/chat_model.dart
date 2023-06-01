class ChatModel {
  final String id;
  final String name;
  final String userName;
  final String image;
  final String createdAt;
  final List<dynamic> users;
  final List<dynamic> lastMessage;

  const ChatModel({
    required this.id,
    required this.name,
    required this.userName,
    required this.createdAt,
    required this.image,
    required this.users,
    required this.lastMessage,
  });

  
}
//   static List<Chat> chats = [
//     Chat(
//       id: '0',
//       users:
//           User.users.where((user) => user.id == '1' || user.id == '2').toList(),
//       messages: Message.messages
//           .where(
//             (message) =>
//                 (message.senderId == '1' || message.senderId == '2') &
//                 (message.recipientId == '1' || message.recipientId == '2'),
//           )
//           .toList(),
//     ),
//     Chat(
//       id: '1',
//       users:
//           User.users.where((user) => user.id == '1' || user.id == '3').toList(),
//       messages: Message.messages
//           .where(
//             (message) =>
//                 (message.senderId == '1' || message.senderId == '3') &
//                 (message.recipientId == '1' || message.recipientId == '3'),
//           )
//           .toList(),
//     ),
//     Chat(
//       id: '2',
//       users:
//           User.users.where((user) => user.id == '1' || user.id == '4').toList(),
//       messages: Message.messages
//           .where(
//             (message) =>
//                 (message.senderId == '1' || message.senderId == '4') &
//                 (message.recipientId == '1' || message.recipientId == '4'),
//           )
//           .toList(),
//     ),
//   ];
// }
