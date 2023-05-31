import '../../assets/constants/assets.dart';
class Post {
  final id;
  final title;
  final userImage;
  final description;
  final author;
  final createdAt;
  final likes;
  final comments;
  final dislikes;
  final categories;
  final shareCount;
  final sourceURL;
  final location;

  Post({
    this.id, 
    required this.location,
    required this.userImage,
    required this.title,
    required this.description,
    required this.author,
    required this.createdAt,
    required this.likes,
    required this.comments,
     this.dislikes,
     this.categories,
    this.shareCount,
    required this.sourceURL,
  });
}
List<Post> dummyPosts = [
  Post(
      id: '1',
      author: 'John Milke',
      location: 'Berlin,Germany',
      createdAt: '5m ago',
      userImage: CustomAssets.kUser2,
      description:
          'At vero eos et accusamus et iusto odio dignissimos ducimus qui dolores et quas molestias excepturi sint occaecati cupiditate non provident',
      title: "Educational",
      sourceURL: CustomAssets.kPost1,
      likes: 5.3,
      comments: 10.4),
  Post(
      id: '2',
      author: 'Steve Douglas',
      location: 'New york,USA',
      createdAt: '44m ago',
      userImage: CustomAssets.kUser4,
      description:
          "Blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident",
      title: 'politics',
      sourceURL: CustomAssets.kPost2,
      likes: 5.3,
      comments: 10.4),
];

