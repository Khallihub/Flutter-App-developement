import 'package:picstash/infrastructure/data_providers/comment/comment_data_provider.dart';
import 'package:picstash/infrastructure/factory%20models/post_factory.dart';

class CommentRepository {
  final CommentDataProvider commentDataProvider;
  CommentRepository({required this.commentDataProvider});

  dynamic addComment(Map<String, String> data) async {
    return await commentDataProvider.addComment(data);
  }

  Future<Post> addLike(Map<String, String> data) async {
    return await commentDataProvider.likeUnlike(data);
  }

  Future<Post> addDisLike(Map<String, String> data) async {
    return await commentDataProvider.dislikeUndislike(data);
  }

  dynamic fetchComments(Map<String, String> id) async {
    return await commentDataProvider.fetchComments(id);
  }

  dynamic fetchLikes(Map<String, String> id) async {
    return await commentDataProvider.fetchLikes(id);
  }

  dynamic fetchDisLikes(Map<String, String> id) async {
    return await commentDataProvider.fetchDisLikes(id);
  }

  dynamic fetchSingle(String id) async {
    return await commentDataProvider.fetchSingle(id);
  }
}
