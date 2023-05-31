import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/entities/post_model.dart';
import '../components/post_card.dart';
import '../components/post_detail_page.dart';

class ShowPosts extends StatelessWidget {

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
        // Placeholder widget when list length exceeds available items
        //  return Followers(
        //     followers: userFollowers[index],
        //   );

        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemCount: dummyPosts.length);
  }
}
