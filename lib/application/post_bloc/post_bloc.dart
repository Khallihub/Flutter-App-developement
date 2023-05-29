import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/post_repository.dart';
import 'blocs.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;

  PostBloc({required this.postRepository}) : super(PostLoadingState()) {
    on<PostLoadEvent>(postLoadEvent);
    on<PostCreateEvent>((event, emit) async {
      try {
        await postRepository.create(event.post);
        final posts = await postRepository.fetchAll();
        emit(PostOperationSuccess(posts: posts));
      } catch (error) {
        emit(PostOperationFailure(error));
      }
    });
    on<SinglePostLoadedEvent>((event, emit) async {
      try {
        final post = await postRepository.fetchSingle({"id": event.id});
        print("kkk" * 20);
        print(post.runtimeType);
        // print(post[0]);
        final likes = post[0]["likes"];
        final dislikes = post[0]["dislikes"];
        final comments = post[0]["comments"];
        final modifiedpost = [
          likes,
          dislikes,
          comments,
        ];
        emit(SinglePostLoadedState(posts: modifiedpost));
      } catch (error) {
        emit(PostOperationFailure(error));
      }
    });
    on<PostUpdateEvent>((event, emit) async {
      try {
        await postRepository.update(event.id, event.post);
        final posts = await postRepository.fetchAll();
        emit(PostOperationSuccess(posts: posts));
      } catch (error) {
        emit(PostOperationFailure(error));
      }
    });

    on<PostDeleteEvent>((event, emit) async {
      try {
        await postRepository.delete(event.id);
        final posts = await postRepository.fetchAll();
        emit(PostOperationSuccess(posts: posts));
      } catch (error) {
        emit(PostOperationFailure(error));
      }
    });

    on<PostLikedEvent>((event, emit) async {
      try {
        await postRepository
            .likeUnlike({"id": event.id, "userName": event.userName});
        final posts = await postRepository.fetchAll();
        emit(PostOperationSuccess(posts: posts));
      } catch (error) {
        emit(PostOperationFailure(error));
      }
    });
    on<PostCommentLikedEvent>((event, emit) async {
      try {
        await postRepository
            .likeUnlike({"id": event.id, "userName": event.userName});
        final like = await postRepository.fetchLikes({"id": event.id});
        final likes = [];
        for (int i = 0; i < like.length; i += 1) {
          likes.add(like[i]);
        }
        // emit(PostCommentLikesLoadedState(likes: likes));
      } catch (error) {
        emit(PostOperationFailure(error));
      }
    });

    on<PostDislikedEvent>((event, emit) async {
      try {
        await postRepository
            .dislikeUndislike({"id": event.id, "userName": event.userName});
        final posts = await postRepository.fetchAll();
        emit(PostOperationSuccess(posts: posts));
      } catch (error) {
        emit(PostOperationFailure(error));
      }
    });
    on<PostCommentDislikedEvent>((event, emit) async {
      try {
        await postRepository
            .dislikeUndislike({"id": event.id, "userName": event.userName});
        final dislike = await postRepository.fetchDisLikes({"id": event.id});
        final dislikes = [];
        for (int i = 0; i < dislike.length; i += 1) {
          dislikes.add(dislike[i]);
        }
        // emit(PostCommentsDislikedLoadedState(dislikes: dislikes));
      } catch (error) {
        emit(PostOperationFailure(error));
      }
    });

    on<PostCommentedEvent>((event, emit) async {
      try {
        await postRepository.comment({
          "id": event.id,
          "userName": event.username,
          "comment": event.comment
        });
        // final posts = await postRepository.fetchAll();
        // emit(PostOperationSuccess(posts: posts));
      } catch (error) {
        emit(PostOperationFailure(error));
      }
    });

    on<PostCommentLoadedEvent>((event, emit) async {
      try {
        final comments = await postRepository.fetchComments({"id": event.id});
        final comment = [];
        for (int i = 0; i < comments.length; i += 1) {
          comment.add(comments[i]);
        }
        emit(PostCommentsLoadedState(comments: comment));
      } catch (error) {
        emit(PostOperationFailure(error));
      }
    });
  }

  FutureOr<void> postLoadEvent(
      PostLoadEvent event, Emitter<PostState> emit) async {
    emit(PostLoadingState());
    try {
      final posts = await postRepository.fetchAll();
      emit(PostOperationSuccess(posts: posts));
    } catch (error) {
      emit(PostOperationFailure(error));
    }
  }
}
