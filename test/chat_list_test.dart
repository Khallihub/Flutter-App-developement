import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:picstash/application/chat_bloc/blocs.dart';
import 'package:picstash/domain/entities/models/chat_model.dart';
import 'package:picstash/domain/repositories/chat_repository.dart';
import 'package:picstash/infrastructure/data_providers/db/db.dart';
import 'package:picstash/presentation/components/chat/chat_contacts.dart';
import 'package:picstash/presentation/components/chat/chat_home_screen_message.dart';
import 'package:picstash/presentation/screens/chat_list_screen.dart';

class MockChatBloc extends MockBloc implements ChatBloc {
  void main() {
    late ChatBloc chatBloc;

    setUp(() {
      chatBloc = MockChatBloc();
    });

    testWidgets('ChatListScreen shows loading indicator when waiting for user',
        (WidgetTester tester) async {
      final chatListScreen = MaterialApp(
        home: BlocProvider.value(
          value: chatBloc,
          child: const ChatListScreen(),
        ),
      );

      when(LoginCredentials().getLoginCredentials())
          .thenAnswer((_) => Future.value(null));

      await tester.pumpWidget(chatListScreen);

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets(
        'ChatListScreen shows error message when error occurs during user retrieval',
        (WidgetTester tester) async {
      final chatListScreen = MaterialApp(
        home: BlocProvider.value(
          value: chatBloc,
          child: const ChatListScreen(),
        ),
      );

      when(LoginCredentials().getLoginCredentials()).thenThrow(Error());

      await tester.pumpWidget(chatListScreen);

      expect(find.text('error'), findsOneWidget);
    });

    testWidgets('ChatListScreen shows chats when AllChatsLoadOperationSuccess',
        (WidgetTester tester) async {
      final mockChats = [
        const ChatModel(
          id: '1',
          name: 'John Doe',
          createdAt: '',
          image: '',
          userName: '',
          users: [],
          lastMessage: [],
        ),
        const ChatModel(
          id: '2',
          name: 'John Doe',
          createdAt: '',
          image: '',
          userName: '',
          users: [],
          lastMessage: [],
        ),
      ];
      // const mockUser = User(
      //   id: '123',
      //   avatarUrl: 'https://example.com/avatar.jpg',
      //   userName: 'johndoe',
      //   name: 'John Doe',
      //   bio: '',
      //   email: '',
      // );
      when(chatBloc.state)
          .thenReturn(AllChatsLoadOperationSuccess(chats: mockChats));
      when(LoginCredentials().getLoginCredentials())
          .thenAnswer((_) => Future.value());

      final chatListScreen = MaterialApp(
        home: BlocProvider.value(
          value: chatBloc,
          child: const ChatListScreen(),
        ),
      );

      await tester.pumpWidget(chatListScreen);

      expect(find.text('Chats'), findsOneWidget);
      expect(find.byType(ChatContacts), findsOneWidget);
      expect(find.byType(ChatMessages), findsOneWidget);
    });
    testWidgets(
        'ChatListScreen shows error message when not AllChatsLoadOperationSuccess',
        (WidgetTester tester) async {
      final chatListScreen = MaterialApp(
        home: BlocProvider.value(
          value: chatBloc,
          child: const ChatListScreen(),
        ),
      );

      // when(chatBloc.state).thenReturn(const ChatOperationFailure(error: 'Error'));

      await tester.pumpWidget(chatListScreen);

      expect(find.text('Error'), findsOneWidget);
    });
  }

  @override
  void add(ChatEvent event) {
    // TODO: implement add
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    // TODO: implement addError
  }

  @override
  FutureOr<void> allChatLoadEvent(
      AllChatsLoadEvent event, Emitter<ChatState> emit) {
    // TODO: implement allChatLoadEvent
    throw UnimplementedError();
  }

  @override
  // TODO: implement chatRepository
  ChatRepository get chatRepository => throw UnimplementedError();

  @override
  Future<void> close() {
    // TODO: implement close
    throw UnimplementedError();
  }

  @override
  void emit(ChatState state) {
    // TODO: implement emit
  }

  @override
  // TODO: implement isClosed
  bool get isClosed => throw UnimplementedError();

  @override
  void on<E extends ChatEvent>(EventHandler<E, ChatState> handler,
      {EventTransformer<E>? transformer}) {
    // TODO: implement on
  }

  @override
  void onChange(Change<ChatState> change) {
    // TODO: implement onChange
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    // TODO: implement onError
  }

  @override
  void onEvent(ChatEvent event) {
    // TODO: implement onEvent
  }

  @override
  void onTransition(Transition<ChatEvent, ChatState> transition) {
    // TODO: implement onTransition
  }

  @override
  // TODO: implement state
  ChatState get state => throw UnimplementedError();

  @override
  // TODO: implement stream
  Stream<ChatState> get stream => throw UnimplementedError();
}

class MockBloc {}
