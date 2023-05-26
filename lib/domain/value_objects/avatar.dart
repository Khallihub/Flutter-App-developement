import 'package:equatable/equatable.dart';

class AvatarModel extends Equatable {
  final String imageUrl;

  const AvatarModel._({required this.imageUrl});

  static AvatarModel create(String imageUrl) {
    if (!_isValidImageUrl(imageUrl)) {
      throw Exception("bad image url");
    }
    return AvatarModel._(imageUrl: imageUrl);
  }

  static bool _isValidImageUrl(String imageUrl) {
    Uri? uri = Uri.tryParse(imageUrl);
    if (uri == null || uri.scheme.isEmpty || uri.host.isEmpty) {
      return false;
    }

    return true;
  }

  @override
  String toString() => imageUrl;

  @override
  List<Object?> get props => [imageUrl];
}
