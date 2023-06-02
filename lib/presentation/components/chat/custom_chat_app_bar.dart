import 'package:flutter/material.dart';

import '../../../domain/entities/models/user_model.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final User user;
  const CustomAppBar({
    Key? key,
    required this.user,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(
            text,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
        ],
      ),
      elevation: 0,
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 10.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(user.avatarUrl),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
