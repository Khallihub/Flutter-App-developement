class Post {
  final id;
  final title;
  final description;
  final author;
  final createdAt;
  final likes;
  final comments;
  final dislikes;
  final categories;
  final shareCount;
  final sourceUrl;

  Post(
    this.id, {
    required this.title,
    required this.description,
    required this.author,
    required this.createdAt,
    required this.likes,
    required this.comments,
    required this.dislikes,
    required this.categories,
    required this.shareCount,
    required this.sourceUrl,
  });
}
