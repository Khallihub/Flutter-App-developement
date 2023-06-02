import '../../assets/constants/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../domain/entities/dummy_post.dart';

class PostDetailPage extends StatefulWidget {
  final Post post;
  const PostDetailPage({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        children: [
          Hero(
            tag: widget.post.id,
            child: Container(
              height: 400,
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: AssetImage(widget.post.sourceURL),
                      fit: BoxFit.cover)),
            ),
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                        image: AssetImage(widget.post.userImage),
                        fit: BoxFit.cover)),
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
              const Icon(Icons.more_vert)
            ],
          ),
          const SizedBox(height: 10),
          Text(widget.post.description),
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
          ),
          const SizedBox(height: 20),
          const Text(
            "All Comments",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                    image: AssetImage(CustomAssets.kUser4),
                                    fit: BoxFit.cover)),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            "Steve John • ",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          const Text("5m ago")
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(widget.post.description),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          SvgPicture.asset(CustomAssets.kHeart),
                          const SizedBox(width: 2),
                          Text('${widget.post.likes.toString()}k'),
                        ],
                      )
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemCount: 2)
        ],
      ),
    );
  }
}
