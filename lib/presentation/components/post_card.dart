import '../../assets/constants/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../domain/entities/post_model.dart';

class PostCard extends StatefulWidget {
  final Post post;
  final VoidCallback onTap;
  const PostCard({super.key, required this.post, required this.onTap});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                          image: AssetImage(widget.post.userImage), fit: BoxFit.cover)),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.post.author,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${widget.post.location} • ${widget.post.createdAt}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    )
                  ],
                ),
                const Spacer(),
                Container(
                  height: 25,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.grey.withOpacity(0.1)),
                  child: Text(
                    widget.post.title,
                    style: const TextStyle(fontSize: 14, color: Colors.blue),
                  ),
                ),
                const SizedBox(width: 5),
                
              ],
            ),
            const SizedBox(height: 10),
            Text(widget.post.description),
            const SizedBox(height: 5),
            Hero(
              tag: widget.post.id,
              child: Container(
                height: 140,
                width: double.maxFinite,
                alignment: Alignment.topRight,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: AssetImage(widget.post.sourceURL), fit: BoxFit.cover)),
                child: Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black.withOpacity(0.05),
                  ),
                  child: const Icon(Icons.attachment, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                SvgPicture.asset(CustomAssets.kHeart),
                const SizedBox(width: 2),
                Text('${widget.post.likes.toString()}k'),
                const SizedBox(width: 10),
                SvgPicture.asset(CustomAssets.kChat, height: 25),
                const SizedBox(width: 2),
                Text('${widget.post.comments.toString()}k'),
                const Spacer(),
                SvgPicture.asset(CustomAssets.kShare),
                const SizedBox(width: 5),
                SvgPicture.asset(CustomAssets.kSaved),
              ],
            )
          ],
        ),
      ),
    );
  }
}
