import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:picstash/application/chat_bloc/chat_bloc.dart';
import 'package:picstash/application/chat_bloc/chat_event.dart';
import 'package:picstash/application/chat_bloc/chat_state.dart';
import 'package:picstash/domain/repositories/chat_repository.dart';
import 'package:picstash/presentation/screens/chat_screen.dart';

void main() {
  group('ChatScreen widget', () {
    late ChatBloc chatBloc;

    setUp(() {
      chatBloc = MockChatBloc();
    });

    testWidgets('should display chat messages', (WidgetTester tester) async {
      // const chat = ChatModel(
      //   id: '1',
      //   name: 'user1',
      //   userName: 'user2',
      //   createdAt: '',
      //   image: '',
      //   lastMessage: [],
      //   users: [],
      // );
      const user1 = 'user1';
      const user2 = 'user2';
      const id = '1';
      const friendName = 'Friend';
      const friendImage = 'http://example.com/avatar.jpg';

      when(chatBloc.state)
          .thenReturn(const ChatLoadOperationSuccess(chats: []));

      await tester.pumpWidget(
        BlocProvider.value(
          value: chatBloc,
          child: const MaterialApp(
            home: ChatScreen(
              user1: user1,
              user2: user2,
              id: id,
              friendName: friendName,
              friendImage: friendImage,
            ),
          ),
        ),
      );

      expect(find.text('Hello'), findsOneWidget);
      expect(find.text('Hi'), findsOneWidget);
    });

    testWidgets('should display loading indicator',
        (WidgetTester tester) async {
      const user1 = 'user1';
      const user2 = 'user2';
      const id = '1';
      const friendName = 'Friend';
      const friendImage = 'http://example.com/avatar.jpg';

      when(chatBloc.state).thenReturn(ChatLoadingState());

      await tester.pumpWidget(
        BlocProvider.value(
          value: chatBloc,
          child: const MaterialApp(
            home: ChatScreen(
              user1: user1,
              user2: user2,
              id: id,
              friendName: friendName,
              friendImage: friendImage,
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should display error message', (WidgetTester tester) async {
      const user1 = 'user1';
      const user2 = 'user2';
      const id = '1';
      const friendName = 'Friend';
      const friendImage = 'http://example.com/avatar.jpg';

      when(chatBloc.state).thenReturn(const ChatOperationFailure(Object));

      await tester.pumpWidget(
        BlocProvider.value(
          value: chatBloc,
          child: const MaterialApp(
            home: ChatScreen(
              user1: user1,
              user2: user2,
              id: id,
              friendName: friendName,
              friendImage: friendImage,
            ),
          ),
        ),
      );

      expect(find.text('Error'), findsOneWidget);
    });
  });
}

class ChatMessageModel {}

class MockChatBloc extends MockBloc<ChatEvent, ChatState> implements ChatBloc {
  @override
  void add(ChatEvent event) {
    // TODO: implement add
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    // TODO: implement addError
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

class MockBloc<E, S> extends Mock implements Bloc<E, S> {}
