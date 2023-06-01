import '../../infrastructure/data_providers/post_data_provider.dart';
import '../../infrastructure/factory models/post_factory.dart';

class PostRepository {
  final PostDataProvider dataProvider;
  PostRepository(this.dataProvider);

  Future<Post> create(
      {required title,
      required description,
      required sourceUrl,
      required author,
      required authorName,
      required authorAvatar}) async {
    return dataProvider.create(
        title: title,
        description: description,
        sourceUrl: sourceUrl,
        author: author,
        authorName: authorName,
        authorAvatar: authorAvatar);
  }

  Future<Post> update(int id, Post post) async {
    return dataProvider.update(id, post);
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
