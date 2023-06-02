import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:picstash/presentation/routes/app_route_constants.dart';

import '../../../domain/entities/models/chat_model.dart';
import 'custom_container.dart';

class ChattedUsers extends StatelessWidget {
  const ChattedUsers({
    Key? key,
    required this.height,
    required this.chats,
  }) : super(key: key);

  final double height;
  final List<ChatModel> chats;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      height: height * 0.7,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: chats.length,
        itemBuilder: (context, index) {
          // Message lastMessage = chats[index].messages!.first;

          return Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).dividerColor,
                ),
              ),
            ),
            child: ListTile(
              onTap: () {
                GoRouter.of(context).pushNamed(
                  MyAppRouteConstants.chatRouteName,
                  pathParameters: {
                    "id": chats[index].id,
                    "user1": chats[index].users[0] == chats[index].userName
                        ? chats[index].users[1]
                        : chats[index].users[0],
                    "user2": chats[index].userName,
                    "friendImage": chats[index].image,
                    "friendName": chats[index].name,
                  },
                );
              },
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(chats[index].image),
              ),
              title: Text(
                chats[index].name,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                chats[index].lastMessage[2],
                maxLines: 1,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              trailing: Text(
                DateTime.fromMillisecondsSinceEpoch(
                        int.parse(chats[index].lastMessage[0]))
                    .toString(),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          );
        },
      ),
    );
  }
}
