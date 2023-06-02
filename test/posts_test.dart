import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:picstash/application/post_bloc/post_bloc.dart';
import 'package:picstash/domain/entities/dummy_post.dart';
import 'package:picstash/presentation/components/post2.dart';
import 'package:picstash/presentation/screens/posts.dart';

import 'post_screen_test.dart';

void main() {
  testWidgets('ShowPosts displays loading indicator and posts when loaded',
      (WidgetTester tester) async {
    // Create a mock PostBloc and add a PostOperationSuccess event with some dummy posts
    final postBloc = MockPostBloc();
    when(postBloc.state).thenReturn(const PostOperationSuccess(posts: []));
    whenListen(postBloc, Stream.value(const PostOperationSuccess(posts: [])));

    // Build the ShowPosts widget
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<PostBloc>.value(
          value: postBloc,
          child: const ShowPosts(),
        ),
      ),
    );

    // Verify that the loading indicator is displayed while the posts are loading
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byType(PostWidget2), findsNothing);

    // Wait for the posts to load and the UI to update
    await tester.pumpAndSettle();

    // Verify that the posts are displayed and the loading indicator is hidden
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.byType(PostWidget2), findsNWidgets(dummyPosts.length));
  });
}

void whenListen(MockPostBloc postBloc, Stream<PostOperationSuccess> stream) {}
