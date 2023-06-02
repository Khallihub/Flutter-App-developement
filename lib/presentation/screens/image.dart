import 'package:flutter/material.dart';

class ResponsiveLikeButton extends StatefulWidget {
  const ResponsiveLikeButton({Key? key}) : super(key: key);

  @override
  State<ResponsiveLikeButton> createState() => _ResponsiveLikeButtonState();
}

class _ResponsiveLikeButtonState extends State<ResponsiveLikeButton> {
  bool _isLiked = false;
  int _likeCount = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkResponse(
          onTap: () {
            setState(() {
              _isLiked = !_isLiked;
              if (_isLiked) {
                _likeCount++;
              } else {
                _likeCount--;
              }
            });
          },
          child: Row(
            children: [
              Icon(
                _isLiked ? Icons.favorite : Icons.favorite_border,
                color: _isLiked ? Colors.red : null,
              ),
              const SizedBox(width: 8),
              Text('$_likeCount'),
            ],
          ),
        ),
      ],
    );
  }
}
