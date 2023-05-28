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
            .likeUnlike({"id": event.id, "userName" : event.userName});
        final posts = await postRepository.fetchAll();
        emit(PostOperationSuccess(posts: posts));
      } catch (error) {
        emit(PostOperationFailure(error));
      }
    });

    on<PostDislikedEvent>((event, emit) async {
      try {
        await postRepository.dislikeUndislike(
            {"id": event.id, "userName" : event.userName});
        final posts = await postRepository.fetchAll();
        emit(PostOperationSuccess(posts: posts));
      } catch (error) {
        emit(PostOperationFailure(error));
      }
    });

    on<PostCommentedEvent>((event, emit) async {
      print("PostCommentedEvent");
      try {
        await postRepository.comment({
          "id": event.id,
          "userName": event.username,
          "comment": event.comment
        });
        final posts = await postRepository.fetchAll();
        emit(PostOperationSuccess(posts: posts));
      } catch (error) {
        emit(PostOperationFailure(error));
      }
    });

    on<PostCommentLoadedEvent> ((event, emit) async {
      try {
        print('PostCommentLoadedEvent');
        final comments = await postRepository.fetchComments({"id": event.id});
        print("comments on ${comments}");
        final comment = [];
        for  (int i = 0; i < comments.length; i+=1) {
          comment.add(comments[i]);
        }
        print(comment);
        // final posts = await postRepository.fetchAll();
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
