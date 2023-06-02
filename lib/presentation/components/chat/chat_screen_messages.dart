import 'package:flutter/material.dart';

import '../../../domain/entities/models/message_model.dart';
import '../../../infrastructure/factory models/chat_factory.dart';

class ChatScreenMessages extends StatelessWidget {
  const ChatScreenMessages({
    Key? key,
    required this.scrollController,
    required this.chat,
  }) : super(key: key);

  final ScrollController scrollController;
  final Chat chat;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        reverse: true,
        controller: scrollController,
        itemCount: chat.messages!.length,
        itemBuilder: (context, index) {
          Message message;
          message = Message(
            sender: chat.messages[chat.messages.length - 1 - index ][1],
            text: chat.messages[chat.messages.length - 1 - index ][2],
            createdAt: chat.messages[chat.messages.length - 1 - index ][0],
          );
          chat.messages![index];

          return Align(
            alignment: (message.sender == chat.user1)
                ? Alignment.centerLeft
                : Alignment.centerRight,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.66,
              ),
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.symmetric(vertical: 5.0),
              decoration: BoxDecoration(
                color: (message.sender == chat.user2)
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.secondary,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Text(
                message.text,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          );
        },
      ),
    );
  }
}
