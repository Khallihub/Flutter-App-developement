class Post {
  final id;
  final title;
  final description;
  final author;
  final authorName;
  final authorAvatar;
  final createdAt;
  final likes;
  final comments;
  final dislikes;
  final categories;
  final shareCount;
  final sourceURL;

  Post(
    this.id, {
    required this.title,
    required this.description,
    required this.author,
    required this.authorName,
    required this.authorAvatar,
    required this.createdAt,
    required this.likes,
    required this.comments,
    required this.dislikes,
    required this.categories,
    required this.shareCount,
    required this.sourceURL,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    final post = Post(
      json['_id'],
      title: json['title'],
      description: json['description'],
      author: json['author'],
      authorName: json['authorName'],
      authorAvatar: json['authorAvatar'],
      createdAt: (json['createdAt']),
      likes: json['likes'],
      comments: json['comments'],
      dislikes: json['dislikes'],
      categories: json['categories'],
      shareCount: json['shareCount'],
      sourceURL: json['sourceURL'],
    );
    print('after factory');
    return post;
  }
}
