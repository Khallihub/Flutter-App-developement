import '../../infrastructure/data_providers/post_data_provider.dart';
import '../../infrastructure/factory models/post_factory.dart';

class PostRepository {
  final PostDataProvider dataProvider;
  PostRepository(this.dataProvider);

  Future<Post> create(Post post) async {
    return dataProvider.create(post);
  }

  Future<Post> update(int id, Post post) async {
    return dataProvider.update(id, post);
  }

  Future<Post> comment(Map<String, String> data) async {
    return dataProvider.comment(data);
  }

  Future<Post> likeUnlike(Map<String, String> data) async {
    return dataProvider.likeUnlike(data);
  }

  Future<Post> dislikeUndislike(Map<String, String> data) async {
    return dataProvider.dislikeUndislike(data);
  }

  Future<List<Post>> fetchAll() async {
    return dataProvider.fetchAll();
  }

  Future<void> delete(int id) async {
    dataProvider.delete(id);
  }
}
