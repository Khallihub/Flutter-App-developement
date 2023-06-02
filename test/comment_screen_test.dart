import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picstash/application/comment_bloc/comment_blocs.dart';
import 'package:picstash/application/comment_bloc/comment_event.dart';
import 'package:picstash/application/comment_bloc/comment_state.dart';
import 'package:picstash/infrastructure/repository/comment/comment_repository.dart';
import 'package:picstash/presentation/components/comment_box.dart';
import 'package:picstash/presentation/screens/comment_screen.dart';

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

  group('CommentScreen', () {
    const id = '123';
    const avatarUrl = 'https://example.com/avatar.jpg';
    const username = 'testuser';
    const date = '2022-06-04';
    const imageUrl = 'https://example.com/image.jpg';
    const name = 'Test User';
    const title = 'Test Post';
    const description = 'This is a test post.';

    testWidgets('renders correctly', (tester) async {
      when(() => commentBloc.state).thenReturn(const CommentInitialState());
      when(() => commentBloc.add(any())).thenReturn(null);

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CommentScreen(
              id: id,
              avatarUrl: avatarUrl,
              username: username,
              date: date,
              imageUrl: imageUrl,
              name: name,
              title: title,
              description: description,
            ),
          ),
        ),
      );

      expect(find.text('Comments'), findsOneWidget);
      expect(find.text(name), findsOneWidget);
      expect(find.text(username), findsOneWidget);
      expect(find.text(title), findsOneWidget);
      expect(find.text(description), findsOneWidget);
      expect(find.byType(CircleAvatar), findsNWidgets(2));
      expect(find.byType(Image), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byType(IconButton), findsNWidgets(3));
    });

    testWidgets('displays comments when loaded', (tester) async {
      final comments = [
        ['user1', 'comment 1'],
        ['user2', 'comment 2'],
        ['user3', 'comment 3'],
      ];

      when(() => commentBloc.state).thenReturn(
        const PostCommentLoaded(postDetails: {}),
      );
      when(() => commentBloc.add(any())).thenReturn(null);

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CommentScreen(
              id: id,
              avatarUrl: avatarUrl,
              username: username,
              date: date,
              imageUrl: imageUrl,
              name: name,
              title: title,
              description: description,
            ),
          ),
        ),
      );

      expect(find.byType(CommentBox), findsNWidgets(3));
      for (final comment in comments) {
        expect(find.text(comment[0]), findsOneWidget);
        expect(find.text(comment[1]), findsOneWidget);
      }
    });
  });
}
