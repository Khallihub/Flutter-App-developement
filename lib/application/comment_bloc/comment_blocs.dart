import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picstash/application/comment_bloc/comment_state.dart';
import 'package:picstash/infrastructure/factory%20models/post_factory.dart';
import 'package:picstash/infrastructure/repository/comment/comment_repository.dart';

import 'comment_event.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final CommentRepository commentRepository;

  CommentBloc({required this.commentRepository})
      : super(const CommentInitialState()) {
    on<LoadPostCommentEvent>(
      (event, emit) async {
        if (state is PostCommentLoading) return;
        emit(const PostCommentLoading());
        try {
          final post = await commentRepository.fetchSingle(event.id);
          final likes = post["likes"];
          final dislikes = post["dislikes"];
          final comments = post["comments"];
          final modifiedpost = {
            "likes": likes,
            "dislikes": dislikes,
            "comments": comments,
          };
          emit(PostCommentLoaded(postDetails: modifiedpost));
        } catch (error) {
          emit(CommentFailure(error: error));
        }
      },
    );

    on<LoadCommentsEvent>(
      (event, emit) async {
        if (state is CommentLoadingState) return;
        emit(const CommentLoadingState());
        try {
          List<dynamic> comments =
              await commentRepository.fetchComments({"id": event.id});
          emit(LoadedPostComments(comments: comments));
        } catch (error) {
          emit(CommentFailure(error: error));
        }
      },
    );

    on<AddCommentEvent>(
      (event, emit) async {
        try {
          Post post = await commentRepository.addComment({
            "id": event.id,
            "userName": event.username,
            "comment": event.comment
          });
          emit(CommentedSuccess(comments: post.comments));
        } catch (error) {
          emit(CommentFailure(error: error));
        }
      },
    );

    on<AddLike>(
      (event, emit) async {
        try {
          Post post = await commentRepository
              .addLike({"id": event.id, "userName": event.userName});
          emit(CommentLikedSuccess(likes: post.likes, dislikes: post.dislikes));
        } catch (error) {
          emit(CommentFailure(error: error));
        }
      },
    );

    on<AddDisLike>(
      (event, emit) async {
        try {
          Post post = await commentRepository
              .addDisLike({"id": event.id, "userName": event.userName});
          emit(CommentDisLikeSuccess(
              likes: post.likes, dislikes: post.dislikes));
        } catch (error) {
          emit(CommentFailure(error: error));
        }
      },
    );
  }
}
