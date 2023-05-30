import 'package:equatable/equatable.dart';

import '../../infrastructure/factory models/post_factory.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<dynamic> get props => [];
}

abstract class PostActionState extends PostState {}

class PostLoadingState extends PostState {}

class PostOperationSuccess extends PostState {
  final Iterable<Post> posts;

  const PostOperationSuccess({required this.posts});

  @override
  List<dynamic> get props => [posts];
}
class SinglePostLoadedState extends PostState {
  final dynamic posts;

  const SinglePostLoadedState({required this.posts});

  @override
  List<dynamic> get props => [posts];
}

class PostOperationFailure extends PostState {
  final Object error;

  const PostOperationFailure(this.error);
  @override
  List<dynamic> get props => [error];
}


class PostLikedActionState extends PostActionState {}

class PostCommentLikesLoadedState extends PostActionState {
  final dynamic likes;

  PostCommentLikesLoadedState({this.likes});
  @override
  List<dynamic> get props => [likes];
}

class PostDislikedActionState extends PostActionState {}

class PostCommentsDislikedLoadedState extends PostActionState {
    final dynamic dislikes;

  PostCommentsDislikedLoadedState({this.dislikes});

  @override
  List<dynamic> get props => [dislikes];
}

class PostCommentedActionState extends PostActionState {}

class PostCommentsLoadedState extends PostActionState {
  final dynamic comments;

  PostCommentsLoadedState({required this.comments});

  @override
  List<dynamic> get props => [comments];
}

class PostSharedActionState extends PostActionState {}

// to do add naviagtion
