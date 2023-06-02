import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picstash/application/comment_bloc/comment_blocs.dart';
import 'package:picstash/application/comment_bloc/comment_event.dart';
import 'package:picstash/application/comment_bloc/comment_state.dart';
import 'package:picstash/infrastructure/repository/comment/comment_repository.dart';
import 'package:picstash/presentation/screens/comment_screen2.dart';

import 'chat_list_test.dart';

class MockCommentBloc extends MockBloc implements CommentBloc {
  @override
  void add(CommentEvent event) {
    // TODO: implement add
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    // TODO: implement addError
  }

  @override
  Future<void> close() {
    // TODO: implement close
    throw UnimplementedError();
  }

  @override
  // TODO: implement commentRepository
  CommentRepository get commentRepository => throw UnimplementedError();

  @override
  void emit(CommentState state) {
    // TODO: implement emit
  }

  @override
  // TODO: implement isClosed
  bool get isClosed => throw UnimplementedError();

  @override
  void on<E extends CommentEvent>(EventHandler<E, CommentState> handler,
      {EventTransformer<E>? transformer}) {
    // TODO: implement on
  }

  @override
  void onChange(Change<CommentState> change) {
    // TODO: implement onChange
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    // TODO: implement onError
  }

  @override
  void onEvent(CommentEvent event) {
    // TODO: implement onEvent
  }

  @override
  void onTransition(Transition<CommentEvent, CommentState> transition) {
    // TODO: implement onTransition
  }

  @override
  // TODO: implement state
  CommentState get state => throw UnimplementedError();

  @override
  // TODO: implement stream
  Stream<CommentState> get stream => throw UnimplementedError();
}

void main() {
  late CommentBloc commentBloc;

  setUp(() {
    commentBloc = MockCommentBloc();
  });

  tearDown(() {
    commentBloc.close();
  });

  testWidgets('CommentScreen2 displays loading indicator on initial state',
      (WidgetTester tester) async {
    when(() => commentBloc.state).thenReturn(CommentInitialState());

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<CommentBloc>.value(
          value: commentBloc,
          child: const CommentScreen2(
            id: '1',
            avatarUrl: 'https://example.com/avatar.jpg',
            username: 'johndoe',
            date: '1622822400',
            imageUrl: 'https://example.com/image.jpg',
            name: 'John Doe',
            title: 'Post Title',
            description: 'Post Description',
          ),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('CommentScreen2 displays post details on loaded state',
      (WidgetTester tester) async {
    when(() => commentBloc.state)
        .thenReturn(const PostCommentLoaded(postDetails: {}));

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<CommentBloc>.value(
          value: commentBloc,
          child: const CommentScreen2(
            id: '1',
            avatarUrl: 'https://example.com/avatar.jpg',
            username: 'johndoe',
            date: '1622822400',
            imageUrl: 'https://example.com/image.jpg',
            name: 'John Doe',
            title: 'Post Title',
            description: 'Post Description',
          ),
        ),
      ),
    );

    expect(find.text('Post Title'), findsOneWidget);
    expect(find.text('Post Description'), findsOneWidget);
    expect(find.text('John Doe'), findsOneWidget);
    expect(find.text('johndoe •  2021 - 6 - 5'), findsOneWidget);
    expect(find.text('This is a comment.'), findsOneWidget);
    expect(find.text('This is another comment.'), findsOneWidget);
  });
}
