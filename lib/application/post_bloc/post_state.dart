import 'package:equatable/equatable.dart';

import '../../infrastructure/factory models/post_factory.dart';


abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}
abstract class PostActionState extends PostState {}

class PostLoadingState extends PostState {}

class PostOperationSuccess extends PostState {
  final Iterable<Post> posts;

  const PostOperationSuccess({required this.posts});

  @override
  List<Object> get props => [posts];
}

class   PostOperationFailure extends PostState {
  final Object error;

  const PostOperationFailure (this.error);
  @override
  List<Object> get props => [error];
}


class PostLikedActionState extends PostActionState {}

class PostDislikedActionState extends PostActionState {}

class PostCommentedActionState extends PostActionState {}

class PostSharedActionState extends PostActionState {}

// to do add naviagtion

