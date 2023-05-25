import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/post_repository.dart';
import 'blocs.dart';


class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;

  PostBloc({required this.postRepository}) : super(PostLoadingState()) {
    on<PostLoadEvent>((event, emit) async {
      emit(PostLoadingState());
      try {
        if (kDebugMode) {
          print('PostLoadEvent');
        }
        final posts = await postRepository.fetchAll();
        print(posts);
        emit(PostOperationSuccess(posts));
      } catch (error) {
        emit(PostOperationFailure(error));
      }
    });

    on<PostCreateEvent>((event, emit) async {
      try {
        await postRepository.create(event.post);
        final post = await postRepository.fetchAll();
        emit(PostOperationSuccess(post));
      } catch (error) {
        emit(PostOperationFailure(error));
      }
    });

    on<PostUpdateEvent>((event, emit) async {
      try {
        await postRepository.update(event.id, event.post);
        final post = await postRepository.fetchAll();
        emit(PostOperationSuccess(post));
      } catch (error) {
        emit(PostOperationFailure(error));
      }
    });

    on<PostDeleteEvent>((event, emit) async {
      try {
        await postRepository.delete(event.id);
        final courses = await postRepository.fetchAll();
        emit(PostOperationSuccess(courses));
      } catch (error) {
        emit(PostOperationFailure(error));
      }
    });
    on<PostLikedEvent>((event, emit) async {
      try {
        await postRepository.likeUnlike({event.id, event.post.author} as Map<String, String>);
        final courses = await postRepository.fetchAll();
        emit(PostOperationSuccess(courses));
      } catch (error) {
        emit(PostOperationFailure(error));
      }
    });
    on<PostDislikedEvent>((event, emit) async {
      try {
        await postRepository.dislikeUndislike({event.id, event.post.author} as Map<String, String>);
        final courses = await postRepository.fetchAll();
        emit(PostOperationSuccess(courses));
      } catch (error) {
        emit(PostOperationFailure(error));
      }
    });
    on<PostCommentEvent>((event, emit) async {
      try {
        await postRepository.comment({event.id, event.comment} as Map<String, String>);
        final courses = await postRepository.fetchAll();
        emit(PostOperationSuccess(courses));
      } catch (error) {
        emit(PostOperationFailure(error));
      }
    });
  }
}
