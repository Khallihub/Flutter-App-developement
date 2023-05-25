import 'package:equatable/equatable.dart';

import '../../infrastructure/factory models/post_factory.dart';


abstract class PostEvent extends Equatable {
  const PostEvent();
}

class PostLoadEvent extends PostEvent {
  const PostLoadEvent(
  );

  @override
  List<Object> get props => [];
}

class PostCreateEvent extends PostEvent {
  final Post post;

  const PostCreateEvent(this.post);

  @override
  List<Object> get props => [post];

  @override
  String toString() => 'Post Created {post Id: ${post.id}}';
}

class PostUpdateEvent extends PostEvent {
  final int id;
  final Post post;

  const PostUpdateEvent(this.id, this.post);

  @override
  List<Object> get props => [id, post];

  @override
  String toString() => 'Post Updated {post Id: ${post.id}}';
}

class PostDeleteEvent extends PostEvent {
  final int id;

  const PostDeleteEvent(this.id);

  @override
  List<Object> get props => [id];

  @override
  toString() => 'Post Deleted {post Id: $id}';

  @override
  bool? get stringify => true;
}

class PostCommentEvent extends PostEvent {
  final int id;
  final String comment;

  const PostCommentEvent(this.id, this.comment);

  @override
  List<Object> get props => [id, comment];

  @override
  String toString() => 'Post Comment {post Id: $comment}';
}

class PostLikedEvent extends PostEvent {
  final int id;
  final Post post;

  const PostLikedEvent(this.id, this.post);

  @override
  List<Object> get props => [id, post];

  @override
  String toString() => 'Post Liked {post Id: ${post.id}}';
}

class PostDislikedEvent extends PostEvent {
  final int id;
  final Post post;

  const PostDislikedEvent(this.id, this.post);

  @override
  List<Object> get props => [id, post];

  @override
  String toString() => 'Post Disliked {post Id: ${post.id}}';
}