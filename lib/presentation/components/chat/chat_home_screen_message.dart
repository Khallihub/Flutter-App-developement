import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:picstash/presentation/routes/app_route_constants.dart';

import '../../../application/chat_bloc/blocs.dart';
import '../../../domain/entities/models/chat_model.dart';
import 'custom_container.dart';

class ChatMessages extends StatefulWidget {
  const ChatMessages({
    Key? key,
    required this.height,
    required this.chats,
  }) : super(key: key);
  final double height;
  final List<ChatModel> chats;

  @override
  State<ChatMessages> createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages> {
  late ChatBloc chatBloc;

  @override
  Widget build(BuildContext context) {
    chatBloc = BlocProvider.of<ChatBloc>(context);

    return CustomContainer(
      height: widget.height * 0.7,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: widget.chats.length,
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
            child: Dismissible(
              key: Key(widget.chats[index].id),
              confirmDismiss: (DismissDirection direction) async {
                if (direction == DismissDirection.endToStart) {
                  return await showDialog<bool>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Confirmation'),
                        content: const Text(
                            'Are you sure you want to delete this chat?'),
                        actions: [
                          TextButton(
                            child: const Text('Cancel'),
                            onPressed: () {
                              // Cancel the dismiss action
                              Navigator.of(context).pop(false);
                            },
                          ),
                          TextButton(
                            child: const Text(
                              'Delete',
                              style: TextStyle(color: Colors.red),
                            ),
                            onPressed: () {
                              chatBloc.add(ChatDeleteEvent(
                                  widget.chats[index].users[0],
                                  widget.chats[index].users[1]));
                              Navigator.of(context).pop(true);
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
                return false; // Do not dismiss by default
              },
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(
                    horizontal: 16), // Customize the background color or widget
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
              // secondaryBackground: Container(
              //   color: Colors.green,
              //   alignment: Alignment.centerRight,
              //   padding: const EdgeInsets.symmetric(
              //       horizontal:
              //           16), // Customize the secondary background color or widget
              //   child: const Icon(
              //     Icons.archive,
              //     color: Colors.white,
              //   ),
              // ),
              child: ListTile(
                onTap: () {
                  GoRouter.of(context).pushNamed(
                    MyAppRouteConstants.chatRouteName,
                    pathParameters: {
                      "id": widget.chats[index].id,
                      "user1": widget.chats[index].users[0] ==
                              widget.chats[index].userName
                          ? widget.chats[index].users[1]
                          : widget.chats[index].users[0],
                      "user2": widget.chats[index].userName,
                      "friendImage": widget.chats[index].image,
                      "friendName": widget.chats[index].name,
                    },
                  );
                },
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(widget.chats[index].image),
                ),
                title: Text(
                  widget.chats[index].name,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  widget.chats[index].lastMessage[2],
                  maxLines: 1,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                trailing: Text(DateTime.fromMillisecondsSinceEpoch(
                            int.parse(widget.chats[index].lastMessage[0]))
                        .isAfter(
                  DateTime.now().add(
                    const Duration(days: 1),
                  ),
                )
                    ? DateFormat('MMM d').format(
                        DateTime.fromMillisecondsSinceEpoch(
                            int.parse(widget.chats[index].lastMessage[0])),
                      )
                    : DateFormat('HH:mm').format(
                        DateTime.fromMillisecondsSinceEpoch(
                            int.parse(widget.chats[index].lastMessage[0])),
                      )),
              ),
            ),
          );
        },
      ),
    );
  }
}
