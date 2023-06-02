import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/entities/dummy_post.dart';
import '../components/post_card.dart';
import '../components/post_detail_page.dart';

class ShowPosts extends StatelessWidget {
  const ShowPosts({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return PostCard(
            onTap: () {
              Get.to(() => PostDetailPage(
                    post: dummyPosts[index],
                  ));
            },
            post: dummyPosts[index],
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemCount: dummyPosts.length);
  }
}
