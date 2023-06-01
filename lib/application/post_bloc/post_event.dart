import 'package:equatable/equatable.dart';

import '../../infrastructure/factory models/post_factory.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();
}

class UserPostLoadEvent extends PostEvent {
  final String email;

  const UserPostLoadEvent({required this.email});
  @override
  List<dynamic> get props => [];
}

class PostLoadEvent extends PostEvent {
  const PostLoadEvent();

  @override
  List<dynamic> get props => [];
}

class SinglePostLoadedEvent extends PostEvent {
  final String id;

  const SinglePostLoadedEvent(this.id);

  @override
  List<dynamic> get props => [];
}

class PostCreateEvent extends PostEvent {
  final String title;
  final String description;
  final String sourceUrl;
  final String author;
  final String authorName;
  final String authorAvatar;

  const PostCreateEvent(
      {required this.title,
      required this.description,
      required this.sourceUrl,
      required this.author,
      required this.authorName,
      required this.authorAvatar});

  @override
  List<dynamic> get props =>
      [title, description, sourceUrl, author, authorName, authorAvatar];

  @override
  String toString() => 'Post Created {post Id: $sourceUrl}';
}

class PostUpdateEvent extends PostEvent {
  final int id;
  final Post post;

  const PostUpdateEvent(this.id, this.post);

  @override
  List<dynamic> get props => [id, post];

  @override
  String toString() => 'Post Updated {post Id: ${post.id}}';
}

class PostDeleteEvent extends PostEvent {
  final int id;

  const PostDeleteEvent(this.id);

  @override
  List<dynamic> get props => [id];

  @override
  toString() => 'Post Deleted {post Id: $id}';

  @override
  bool? get stringify => true;
}

class PostLikedEvent extends PostEvent {
  final String id;
  final String userName;
  const PostLikedEvent(this.id, this.userName);

  @override
  List<dynamic> get props => [id, userName];

  @override
  String toString() => 'Post Liked {post Id: $userName}';
}

class PostDislikedEvent extends PostEvent {
  final String id;
  final String userName;

  const PostDislikedEvent(this.id, this.userName);

  @override
  List<dynamic> get props => [id, userName];

  @override
  String toString() => 'Post Disliked {post Id: $userName}';
}
