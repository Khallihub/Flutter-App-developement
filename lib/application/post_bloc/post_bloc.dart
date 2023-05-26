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
            .likeUnlike({event.id, event.userName} as Map<String, String>);
        final posts = await postRepository.fetchAll();
        emit(PostOperationSuccess(posts: posts));
      } catch (error) {
        emit(PostOperationFailure(error));
      }
    });

    on<PostDislikedEvent>((event, emit) async {
      try {
        await postRepository.dislikeUndislike(
            {event.id, event.userName} as Map<String, String>);
        final posts = await postRepository.fetchAll();
        emit(PostOperationSuccess(posts: posts));
      } catch (error) {
        emit(PostOperationFailure(error));
      }
    });

    on<PostCommentEvent>((event, emit) async {
      try {
        await postRepository
            .comment({event.id, event.comment} as Map<String, String>);
        final posts = await postRepository.fetchAll();
        emit(PostOperationSuccess(posts: posts));
      } catch (error) {
        emit(PostOperationFailure(error));
      }
    });
  }

  FutureOr<void> postLoadEvent(
      PostLoadEvent event, Emitter<PostState> emit) async {
    emit(PostLoadingState());
    print('PostLoadEvent');
    try {
      final posts = await postRepository.fetchAll();
      emit(PostOperationSuccess(posts: posts));
    } catch (error) {
      emit(PostOperationFailure(error));
    }
  }
}
