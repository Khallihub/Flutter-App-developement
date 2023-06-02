import 'package:flutter/material.dart';

class ChatContacts extends StatelessWidget {
  const ChatContacts({
    Key? key,
    required this.height,
    required this.users,
  }) : super(key: key);

  final double height;
  final List<dynamic> users;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: height * 0.155,
        margin: const EdgeInsets.only(
          left: 20.0,
          top: 20.0,
        ),
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: users.length,
          itemBuilder: (context, index) {
            // User user = users[index];
            return Container(
              margin: const EdgeInsets.only(right: 10),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage(users[index].image),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    users[index].name,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
