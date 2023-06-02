// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:picstash/application/post_bloc/post_bloc.dart';
// import 'package:picstash/domain/entities/post_model.dart';
// import 'package:picstash/domain/repositories/post_repository.dart';
// import 'package:picstash/presentation/components/post2.dart';
// import 'package:picstash/presentation/screens/error_page.dart';
// import 'package:picstash/presentation/screens/post_screen.dart';

// import 'user_profile_test.dart';

// class MockPostBloc extends MockBloc implements PostBloc {
//   @override
//   void add(PostEvent event) {
//     // TODO: implement add
//   }

//   @override
//   void addError(Object error, [StackTrace? stackTrace]) {
//     // TODO: implement addError
//   }

//   @override
//   Future<void> close() {
//     // TODO: implement close
//     throw UnimplementedError();
//   }

//   @override
//   void emit(PostState state) {
//     // TODO: implement emit
//   }

//   @override
//   // TODO: implement isClosed
//   bool get isClosed => throw UnimplementedError();

//   @override
//   void on<E extends PostEvent>(EventHandler<E, PostState> handler, {EventTransformer<E>? transformer}) {
//     // TODO: implement on
//   }

//   @override
//   void onChange(Change<PostState> change) {
//     // TODO: implement onChange
//   }

//   @override
//   void onError(Object error, StackTrace stackTrace) {
//     // TODO: implement onError
//   }

//   @override
//   void onEvent(PostEvent event) {
//     // TODO: implement onEvent
//   }

//   @override
//   void onTransition(Transition<PostEvent, PostState> transition) {
//     // TODO: implement onTransition
//   }

//   @override
//   FutureOr<void> postLoadEvent(PostLoadEvent event, Emitter<PostState> emit) {
//     // TODO: implement postLoadEvent
//     throw UnimplementedError();
//   }

//   @override
//   // TODO: implement postRepository
//   PostRepository get postRepository => throw UnimplementedError();

//   @override
//   // TODO: implement state
//   PostState get state => throw UnimplementedError();

//   @override
//   // TODO: implement stream
//   Stream<PostState> get stream => throw UnimplementedError();
// }

// void main() {
//   late PostBloc postBloc;

//   setUp(() {
//     postBloc = MockPostBloc();
//   });

//   testWidgets('PostScreen displays loading indicator when PostLoadingState', (WidgetTester tester) async {
//     when(postBloc.state).thenReturn(PostLoadingState());

//     final postScreen = MaterialApp(
//       home: BlocProvider.value(
//         value: postBloc,
//         child: const PostScreen(),
//       ),
//     );

//     await tester.pumpWidget(postScreen);

//     expect(find.byType(CircularProgressIndicator), findsOneWidget);
//   });

//   testWidgets('PostScreen displays posts when PostOperationSuccess', (WidgetTester tester) async {
//     final mockPosts = [
//       Post(
//         id: '1',
//         authorAvatar: 'https://example.com/avatar.jpg',
//         author: 'John Doe',
//         createdAt: DateTime.now(),
//         sourceURL: 'https://example.com/image.jpg',
//         likes: 10,
//         dislikes: 2,
//         comments: 5,
//         description: 'This is a post',
//         authorName: 'John',
//         title: 'Post Title', location: null, userImage: null,
//       ),
//       Post(
//         id: '2',
//         authorAvatar: 'https://example.com/avatar2.jpg',
//         author: 'Jane Doe',
//         createdAt: DateTime.now(),
//         sourceURL: 'https://example.com/image2.jpg',
//         likes: 20,
//         dislikes: 3,
//         comments: 8,
//         description: 'This is another post',
//         authorName: 'Jane',
//         title: 'Post Title 2', location: null, userImage: null,
//       ),
//     ];
//     when(postBloc.state).thenReturn(PostOperationSuccess(posts: mockPosts));

//     final postScreen = MaterialApp(
//       home: BlocProvider.value(
//         value: postBloc,
//         child: const PostScreen(),
//       ),
//     );

//     await tester.pumpWidget(postScreen);

//     expect(find.byType(PostWidget2), findsNWidgets(mockPosts.length));
//   });

//   testWidgets('PostScreen displays error page when not PostLoadingState or PostOperationSuccess', (WidgetTester tester) async {
//     when(postBloc.state).thenReturn(const ErrorPage() as PostState);

//     final postScreen = MaterialApp(
//       home: BlocProvider.value(
//         value: postBloc,
//         child: const PostScreen(),
//       ),
//     );

//     await tester.pumpWidget(postScreen);

//     expect(find.byType(ErrorPage), findsOneWidget);
//   });
// }

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:picstash/application/post_bloc/post_bloc.dart';
import 'package:picstash/assets/constants/assets.dart';
import 'package:picstash/domain/entities/post_model.dart';
import 'package:picstash/domain/repositories/post_repository.dart';
import 'package:picstash/presentation/components/post2.dart';
import 'package:picstash/presentation/screens/error_page.dart';
import 'package:picstash/presentation/screens/post_screen.dart';

import 'chat_list_test.dart';

class MockPostBloc extends MockBloc implements PostBloc {
  @override
  void add(PostEvent event) {
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
  void emit(PostState state) {
    // TODO: implement emit
  }

  @override
  // TODO: implement isClosed
  bool get isClosed => throw UnimplementedError();

  @override
  void on<E extends PostEvent>(EventHandler<E, PostState> handler,
      {EventTransformer<E>? transformer}) {
    // TODO: implement on
  }

  @override
  void onChange(Change<PostState> change) {
    // TODO: implement onChange
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    // TODO: implement onError
  }

  @override
  void onEvent(PostEvent event) {
    // TODO: implement onEvent
  }

  @override
  void onTransition(Transition<PostEvent, PostState> transition) {
    // TODO: implement onTransition
  }

  @override
  FutureOr<void> postLoadEvent(PostLoadEvent event, Emitter<PostState> emit) {
    // TODO: implement postLoadEvent
    throw UnimplementedError();
  }

  @override
  // TODO: implement postRepository
  PostRepository get postRepository => throw UnimplementedError();

  @override
  // TODO: implement state
  PostState get state => throw UnimplementedError();

  @override
  // TODO: implement stream
  Stream<PostState> get stream => throw UnimplementedError();
}

void main() {
  late PostBloc postBloc;

  setUp(() {
    postBloc = MockPostBloc();
  });

  testWidgets('PostScreen displays loading indicator when PostLoadingState',
      (WidgetTester tester) async {
    when(postBloc.state).thenReturn(PostLoadingState());

    final postScreen = MaterialApp(
      home: BlocProvider.value(
        value: postBloc,
        child: PostScreen(),
      ),
    );

    await tester.pumpWidget(postScreen);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('PostScreen displays posts when PostOperationSuccess',
      (WidgetTester tester) async {
    final mockPosts = [
      Post(
          id: '1',
          author: 'John Milke',
          location: 'Berlin,Germany',
          createdAt: '5m ago',
          userImage: CustomAssets.kUser2,
          description:
              'At vero eos et accusamus et iusto odio dignissimos ducimus qui dolores et quas molestias excepturi sint occaecati cupiditate non provident',
          title: "Educational",
          sourceURL: CustomAssets.kPost1,
          likes: 5.3,
          comments: 10.4),
      Post(
          id: '2',
          author: 'Steve Douglas',
          location: 'New york,USA',
          createdAt: '44m ago',
          userImage: CustomAssets.kUser4,
          description:
              "Blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident",
          title: 'politics',
          sourceURL: CustomAssets.kPost2,
          likes: 5.3,
          comments: 10.4),
    ];
    when(postBloc.state).thenReturn(const ErrorPage() as PostState);

    final postScreen = MaterialApp(
      home: BlocProvider.value(
        value: postBloc,
        child: const PostScreen(),
      ),
    );

    await tester.pumpWidget(postScreen);

    expect(find.byType(PstWidget), findsNWidgets(mockPosts.length));
  });

  testWidgets(
      'PostScreen displays error page when not PostLoadingState or PostOperationSuccess',
      (WidgetTester tester) async {
    when(postBloc.state).thenReturn(const ErrorPage() as PostState);

    final postScreen = MaterialApp(
      home: BlocProvider.value(
        value: postBloc,
        child: PostScreen(),
      ),
    );

    await tester.pumpWidget(postScreen);

    expect(find.byType(ErrorPage), findsOneWidget);
  });
}
