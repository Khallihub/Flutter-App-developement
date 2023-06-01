import 'package:equatable/equatable.dart';

abstract class CommentEvent extends Equatable {
  const CommentEvent();
}

class LoadPostCommentEvent extends CommentEvent {
  final String id;

  const LoadPostCommentEvent({required this.id});

  @override
  List<dynamic> get props => [id];
}

class LoadCommentsEvent extends CommentEvent {
  final String id;

  const LoadCommentsEvent(this.id);
  @override
  List<dynamic> get props => [id];
}

class AddCommentEvent extends CommentEvent {
  final String id;
  final String username;
  final String comment;

  const AddCommentEvent(
      {required this.id, required this.username, required this.comment});

  @override
  List<dynamic> get props => [id, username, comment];

  @override
  String toString() => 'Post Comment {post Id: $id}';
}

class AddLike extends CommentEvent {
  final String id;
  final String userName;
  const AddLike({required this.id, required this.userName});

  @override
  List<dynamic> get props => [id, userName];

  @override
  String toString() => 'Post Liked {post Id: $userName}';
}

class AddDisLike extends CommentEvent {
  final String id;
  final String userName;

  const AddDisLike(this.id, this.userName);

  @override
  List<dynamic> get props => [id, userName];

  @override
  String toString() => 'Post Disliked {post Id: $userName}';
}
