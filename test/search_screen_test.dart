import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/mockito.dart';
import 'package:picstash/application/chat_bloc/blocs.dart';
import 'package:picstash/application/post_bloc/post_state.dart';
import 'package:picstash/application/search_bloc/search_blocs.dart';
import 'package:picstash/domain/entities/models/user_model.dart';
import 'package:picstash/domain/repositories/chat_repository.dart';
import 'package:picstash/presentation/routes/app_route_constants.dart';
import 'package:picstash/presentation/screens/search_screen.dart';

import 'chat_list_test.dart';
import 'post_screen_test.dart';
import 'posts_test.dart';

class MockSearchBloc extends MockBloc implements SearchBloc {
  @override
  void add(SearchEvent event) {
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
  void emit(SearchState state) {
    // TODO: implement emit
  }

  @override
  // TODO: implement isClosed
  bool get isClosed => throw UnimplementedError();

  @override
  void on<E extends SearchEvent>(EventHandler<E, SearchState> handler,
      {EventTransformer<E>? transformer}) {
    // TODO: implement on
  }

  @override
  void onChange(Change<SearchState> change) {
    // TODO: implement onChange
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    // TODO: implement onError
  }

  @override
  void onEvent(SearchEvent event) {
    // TODO: implement onEvent
  }

  @override
  void onTransition(Transition<SearchEvent, SearchState> transition) {
    // TODO: implement onTransition
  }

  @override
  // TODO: implement state
  SearchState get state => throw UnimplementedError();

  @override
  // TODO: implement stream
  Stream<SearchState> get stream => throw UnimplementedError();
}

class MockChatBloc extends MockBloc implements ChatBloc {
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

void main() {
  late MockSearchBloc searchBloc;
  late MockChatBloc chatBloc;
  const localUser = User(
    id: '1',
    name: 'John Doe',
    userName: 'johndoe',
    avatarUrl: 'https://example.com/avatar.jpg',
  );
  const results = [
    User(
      id: '2',
      name: 'Jane Smith',
      userName: 'janesmith',
      avatarUrl: 'https://example.com/avatar2.jpg',
    ),
    User(
      id: '3',
      name: 'Bob Johnson',
      userName: 'bobjohnson',
      avatarUrl: 'https://example.com/avatar3.jpg',
    ),
  ];

  setUp(() {
    searchBloc = MockSearchBloc();
    chatBloc = MockChatBloc();
  });

  testWidgets(
      'SearchScreen displays initial message when no search query is entered',
      (WidgetTester tester) async {
    when(searchBloc.state).thenReturn(SearchInitial());
    whenListen(searchBloc as MockPostBloc,
        Stream.value(SearchInitial() as PostOperationSuccess));

    await tester.pumpWidget(
      MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider<SearchBloc>.value(value: searchBloc),
            BlocProvider<ChatBloc>.value(value: chatBloc),
          ],
          child: SearchScreen(localUser: localUser),
        ),
      ),
    );

    expect(find.text('Start typing to search.'), findsOneWidget);
    expect(find.byType(ListTile), findsNothing);
    expect(find.text('Error:'), findsNothing);
  });

  testWidgets(
      'SearchScreen displays search results when search query is entered',
      (WidgetTester tester) async {
    when(searchBloc.state).thenReturn(SearchResult(results));
    whenListen(searchBloc as MockPostBloc,
        Stream.value(SearchResult(results) as PostOperationSuccess));

    await tester.pumpWidget(
      MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider<SearchBloc>.value(value: searchBloc),
            BlocProvider<ChatBloc>.value(value: chatBloc),
          ],
          child: SearchScreen(localUser: localUser),
        ),
      ),
    );

    expect(find.text('Start typing to search.'), findsNothing);
    expect(find.byType(ListTile), findsNWidgets(results.length));
    expect(find.text('Error:'), findsNothing);
  });

  testWidgets('SearchScreen displays error message when search fails',
      (WidgetTester tester) async {
    when(searchBloc.state).thenReturn(const SearchError("search failed"));
    whenListen(
        searchBloc as MockPostBloc,
        Stream.value(
            const SearchError("search failed") as PostOperationSuccess));

    await tester.pumpWidget(
      MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider<SearchBloc>.value(value: searchBloc),
            BlocProvider<ChatBloc>.value(value: chatBloc),
          ],
          child: SearchScreen(localUser: localUser),
        ),
      ),
    );

    expect(find.text('Start typing to search.'), findsNothing);
    expect(find.byType(ListTile), findsNothing);
    expect(find.text('Error: Search failed'), findsOneWidget);
  });

  testWidgets(
      'SearchScreen navigates to chat screen when user taps on a search result',
      (WidgetTester tester) async {
    when(searchBloc.state).thenReturn(SearchResult(results));
    whenListen(searchBloc as MockPostBloc,
        Stream.value(SearchResult(results) as PostOperationSuccess));

    await tester.pumpWidget(
      MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider<SearchBloc>.value(value: searchBloc),
            BlocProvider<ChatBloc>.value(value: chatBloc),
          ],
          child: SearchScreen(localUser: localUser),
        ),
      ),
    );

    final tileFinder = find.byType(ListTile).first;
    final tile = tester.widget<ListTile>(tileFinder);
    final chatCreateEvent =
        ChatCreateEvent(localUser as String, tile.subtitle! as String);

    expect(find.text('Start typing to search.'), findsNothing);
    expect(find.byType(ListTile), findsNWidgets(results.length));
    expect(find.text('Error:'), findsNothing);

    await tester.tap(tileFinder);

    verify(chatBloc.add(chatCreateEvent)).called(1);
    verify(GoRouter.of(tester.element(tileFinder)).pushNamed(
      MyAppRouteConstants.chatRouteName,
      pathParameters: {},
    )).called(1);
  });
}
