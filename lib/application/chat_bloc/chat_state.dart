
import 'package:equatable/equatable.dart';

abstract class ChatState extends Equatable {
  const ChatState();
  
  @override
  List<dynamic> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoadingState extends ChatState {}

class ChatLoadOperationSuccess extends ChatState {
  final Iterable<dynamic> chats;

  const ChatLoadOperationSuccess({required this.chats});

  @override
  List<dynamic> get props => [chats];
}

class ChatOperationFailure extends ChatState {
  final Object error;

  const ChatOperationFailure(this.error);
  @override
  List<dynamic> get props => [error];
}

class ChatCreatedState extends ChatState {

  final dynamic chat;
  
  const ChatCreatedState(this.chat);

  @override
  List<dynamic> get props => [chat];
}

class ChatRenamedState extends ChatState {

  final dynamic chat;

  const ChatRenamedState(this.chat);

  @override
  List<dynamic> get props => [chat];
}

class ChatDeletedState extends ChatState {

  final dynamic chat;

  const ChatDeletedState(this.chat);

  @override
  List<dynamic> get props => [];
}

class ChatMessageUpdatedState extends ChatState {

  final dynamic chat;

  const ChatMessageUpdatedState(this.chat);

  @override
  List<dynamic> get props => [chat];
}

class ChatMessageSentState extends ChatState {

  final dynamic chat;

  const ChatMessageSentState(this.chat);

  @override
  List<dynamic> get props => [chat];
}

class ChatMessageDeletedState extends ChatState {

  final dynamic chat;

  const ChatMessageDeletedState(this.chat);

  @override
  List<dynamic> get props => [chat];
}
