import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/models/chat_model.dart';
import '../../domain/entities/models/user_model.dart';
import '../../domain/repositories/chat_repository.dart';
import '../../infrastructure/factory models/chat_factory.dart';
import 'blocs.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository chatRepository;

  ChatBloc({required this.chatRepository}) : super(ChatInitial()) {
    on<ChatLoadEvent>((event, emit) async {
      emit(ChatLoadingState());
      try {
        final chats = await chatRepository
            .fetchChat({"user1": event.user1, "user2": event.user2});
        emit(ChatLoadOperationSuccess(chats: [chats]));
      } catch (error) {
        emit(ChatOperationFailure(error));
      }
    });
    on<AllChatsLoadEvent>((event, emit) async {
      emit(AllChatsLoadOperationInProgress());
      try {
        List<Chat> chats =
            await chatRepository.fetchChats({"user": event.user});
        Set<String> users = {};
        for (var i = 0; i < chats.length; i++) {
          users.add(chats[i].user1);
          users.add(chats[i].user2);
        }
        users.remove(event.user);
        List<String> chatedUsers = users.toList();
        List<User> usersList =
            await chatRepository.fetchUsers({"users": chatedUsers});

        final mapped = [];
        for (var user in usersList) {
          for (var chat in chats) {
            if (user.userName == chat.user1 || user.userName == chat.user2) {
              mapped.add({
                user.userName: [user, chat]
              });
            }
          }
        }
        List<ChatModel> chatsList = [];
        for (var data in mapped) {
          var chat = data.values.toList(growable: false);
          chatsList.add(ChatModel(
            id: chat[0][0].id,
            name: chat[0][0].name,
            userName: chat[0][0].userName,
            createdAt: chat[0][1].lastMessage[0],
            lastMessage: chat[0][1].lastMessage,
            image: chat[0][0].avatarUrl,
            users: chat[0][1].users,
          ));
        }

        emit(AllChatsLoadOperationSuccess(chats: chatsList));
      } catch (error) {
        emit(ChatOperationFailure(error));
      }
    });
    on<ChatCreateEvent>((event, emit) async {
      emit(ChatLoadingState());
      try {
        final chats = await chatRepository
            .createChat({"user1": event.user1, "user2": event.user2});
        emit(ChatLoadOperationSuccess(chats: chats));
      } catch (error) {
        emit(ChatOperationFailure(error));
      }
    });
    on<ChatRenameEvent>((event, emit) async {
      emit(ChatLoadingState());
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
      emit(ChatLoadingState());
      try {
        final rmChat = await chatRepository
            .deleteChat({"user1": event.user1, "user2": event.user2});
      
        emit(ChatDeletedState([rmChat]));
      } catch (error) {
        emit(ChatOperationFailure(error));
      }
    });
    on<ChatMessageUpdateEvent>((event, emit) async {
      emit(ChatLoadingState());
      print("9"*78);
      print(event.user1);
      print(event.user2);
      print(event.sender);
      print(event.newMessage);
      print(event.time);
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
    on<SetParentTextField>(
      (event, emit) {
        emit(SetParentTextFieldState(text: event.text, time: event.time, chat: event.chat));
      },
    );
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
      emit(ChatLoadingState());
      try {
        final Chat chats = await chatRepository.deleteMessage(
            {"user1": event.user1, "user2": event.user2, "time": event.time});
        emit(ChatMessageDeletedState(chats));
      } catch (error) {
        emit(ChatOperationFailure(error));
      }
    });
  }

  FutureOr<void> allChatLoadEvent(
      AllChatsLoadEvent event, Emitter<ChatState> emit) async {
    emit(AllChatsLoadOperationInProgress());
    try {
      List<Chat> chats = await chatRepository.fetchChats({"user": event.user});
      Set<String> users = {};
      for (var i = 0; i < chats.length; i++) {
        users.add(chats[i].user1);
        users.add(chats[i].user2);
      }
      users.remove(event.user);
      List<String> chatedUsers = users.toList();
      List<User> usersList =
          await chatRepository.fetchUsers({"users": chatedUsers});

      final mapped = [];
      for (var user in usersList) {
        for (var chat in chats) {
          if (user.userName == chat.user1 || user.userName == chat.user2) {
            mapped.add({
              user.userName: [user, chat]
            });
          }
        }
      }
      List<ChatModel> chatsList = [];
      for (var data in mapped) {
        var chat = data.values.toList(growable: false);
        chatsList.add(ChatModel(
          id: chat[0][0].id,
          name: chat[0][0].name,
          userName: chat[0][0].userName,
          createdAt: chat[0][1].lastMessage[0],
          lastMessage: chat[0][1].lastMessage,
          image: chat[0][0].avatarUrl,
          users: chat[0][1].users,
        ));
      }

      emit(AllChatsLoadOperationSuccess(chats: chatsList));
    } catch (error) {
      emit(ChatOperationFailure(error));
    }
  }
}
