import 'package:equatable/equatable.dart';

abstract class CommentState extends Equatable {
  const CommentState();

  @override
  List<dynamic> get props => [];
}

class CommentInitialState extends CommentState {
  const CommentInitialState();

  @override
  List<dynamic> get props => [];
}

class PostCommentLoading extends CommentState {
  const PostCommentLoading();

  @override
  List<dynamic> get props => [];
}

class PostCommentLoaded extends CommentState {
  final Map<String, dynamic> postDetails;
  const PostCommentLoaded({required this.postDetails});

  @override
  List<dynamic> get props => [postDetails];
}

class CommentLoadingState extends CommentState {
  const CommentLoadingState();

  @override
  List<dynamic> get props => [];
}

class SinglePostLoadedState extends CommentState {
  final dynamic posts;

  const SinglePostLoadedState({required this.posts});

  @override
  List<dynamic> get props => [posts];
}

class LoadedPostComments extends CommentState {
  final dynamic comments;

  const LoadedPostComments({required this.comments});

  @override
  List<dynamic> get props => [comments];
}

class CommentLikedSuccess extends CommentState {
  final List<dynamic> likes;
  final List<dynamic> dislikes;

  const CommentLikedSuccess({required this.likes, required this.dislikes});
  @override
  List<dynamic> get props => [likes, dislikes];
}

class CommentDisLikeSuccess extends CommentState {
  final List<dynamic> likes;
  final List<dynamic> dislikes;

  const CommentDisLikeSuccess({required this.dislikes, required this.likes});

  @override
  List<dynamic> get props => [likes, dislikes];
}

class CommentedSuccess extends CommentState {
  final dynamic comments;

  const CommentedSuccess({required this.comments});

  @override
  List<dynamic> get props => [comments];
}

class CommentFailure extends CommentState {
  final Object error;

  const CommentFailure({required this.error});

  @override
  List<Object> get props => [error];
}
