import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/chat_repository.dart';
import 'blocs.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository chatRepository;

  ChatBloc({required this.chatRepository}) : super(ChatInitial()) {
    on<ChatLoadEvent>((event, emit) async {
      try {
        final chats = await chatRepository
            .fetchChat({"user1": event.user1, "user2": event.user2});
        emit(ChatLoadOperationSuccess(chats: [chats]));
      } catch (error) {
        emit(ChatOperationFailure(error));
      }
    });
    on<ChatCreateEvent>((event, emit) async {
      try {
        final chats = await chatRepository
            .createChat({"user1": event.user1, "user2": event.user2});
        emit(ChatLoadOperationSuccess(chats: [chats]));
      } catch (error) {
        emit(ChatOperationFailure(error));
      }
    });
    on<ChatRenameEvent>((event, emit) async {
      try {
        final chats = await chatRepository.renameChat({
          "user1": event.user1,
          "user2": event.user2,
          "sender": event.sender,
          "newName": event.newName
        });
        emit(ChatLoadOperationSuccess(chats: [chats]));
      } catch (error) {
        emit(ChatOperationFailure(error));
      }
    });
    on<ChatDeleteEvent>((event, emit) async {
      try {
        final chats = await chatRepository
            .deleteChat({"user1": event.user1, "user2": event.user2});
        emit(ChatLoadOperationSuccess(chats: [chats]));
      } catch (error) {
        emit(ChatOperationFailure(error));
      }
    });
    on<ChatMessageUpdateEvent>((event, emit) async {
      try {
        final chats = await chatRepository.updateMessage({
          "user1": event.user1,
          "user2": event.user2,
          "sender": event.sender,
          "newMessage": event.newMessage,
          "time": event.time,
        });
        emit(ChatLoadOperationSuccess(chats: [chats]));
      } catch (error) {
        emit(ChatOperationFailure(error));
      }
    });
    on<ChatMessageSendEvent>((event, emit) async {
      try {
        final chats = await chatRepository.sendMessage({
          "user1": event.user1,
          "user2": event.user2,
          "sender": event.sender,
          "message": event.message
        });
        emit(ChatLoadOperationSuccess(chats: [chats]));
      } catch (error) {
        emit(ChatOperationFailure(error));
      }
    });
    on<ChatMessageDeleteEvent>((event, emit) async {
      try {
        final chats = await chatRepository.deleteMessage(
            {"user1": event.user1, "user2": event.user2, "time": event.time});
        emit(ChatLoadOperationSuccess(chats: [chats]));
      } catch (error) {
        emit(ChatOperationFailure(error));
      }
    });
  }
}
