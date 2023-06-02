import 'package:equatable/equatable.dart';

import '../../infrastructure/factory models/chat_factory.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<dynamic> get props => [];
}

class ChatLoadEvent extends ChatEvent {
  final String user1;
  final String user2;

  const ChatLoadEvent(this.user1, this.user2);

  @override
  List<dynamic> get props => [user1, user2];
}
class AllChatsLoadEvent extends ChatEvent {
  final String user;
   const AllChatsLoadEvent(this.user);

  @override
  List<dynamic> get props => [user];
}

class ChatCreateEvent extends ChatEvent {
  final String user1;
  final String user2;

  const ChatCreateEvent(this.user1, this.user2);

  @override
  List<dynamic> get props => [user1, user2];
}

class ChatRenameEvent extends ChatEvent {
  final String user1;
  final String user2;
  final String sender;
  final String newName;

  const ChatRenameEvent(
    this.user1,
    this.user2,
    this.sender,
    this.newName,
  );

  @override
  List<dynamic> get props => [user1, user2, newName];
}

class ChatDeleteEvent extends ChatEvent {
  final String user1;
  final String user2;

  const ChatDeleteEvent(this.user1, this.user2);

  @override
  List<dynamic> get props => [user1, user2];
}

class ChatMessageUpdateEvent extends ChatEvent {
  final String user1;
  final String user2;
  final String sender;
  final String newMessage;
  final String time;

  const ChatMessageUpdateEvent(
    this.user1,
    this.user2,
    this.sender,
    this.newMessage,
    this.time,
  );

  @override
  List<dynamic> get props => [user1, user2, sender, newMessage, time];
}

class SetParentTextField extends ChatEvent {
  final String text;
  final String time;
  final Chat chat;

  const SetParentTextField({required this.text, required this.time, required this.chat});

  @override 
  List<dynamic> get props => [text, time];

}
class ChatMessageSendEvent extends ChatEvent {
  final String user1;
  final String user2;
  final String sender;
  final String message;

  const ChatMessageSendEvent(
    this.user1,
    this.user2,
    this.sender,
    this.message,
  );

  @override
  List<dynamic> get props => [user1, user2, sender, message,];
}

class ChatMessageDeleteEvent extends ChatEvent {
  final String user1;
  final String user2;
  final String time;

  const ChatMessageDeleteEvent(
    this.user1,
    this.user2,
    this.time,
  );

  @override
  List<dynamic> get props => [user1, user2, time];
}


