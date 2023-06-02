import 'package:flutter/material.dart';

import '../../../application/chat_bloc/blocs.dart';
import '../../../domain/entities/models/message_model.dart';
import '../../../infrastructure/factory models/chat_factory.dart';

class ChatScreenMessages extends StatefulWidget {
  const ChatScreenMessages({
    Key? key,
    required this.scrollController,
    required this.chat,
  }) : super(key: key);

  final ScrollController scrollController;
  final Chat chat;

  @override
  State<ChatScreenMessages> createState() => _ChatScreenMessagesState();
}

class _ChatScreenMessagesState extends State<ChatScreenMessages> {
  Offset _tapPostion = Offset.zero;
  void _getTapPostion(TapDownDetails tapPostion) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    setState(() {
      _tapPostion = renderBox.globalToLocal(tapPostion.globalPosition);
    });
  }

  late ChatBloc chatBloc;
  Future<void> _showContextMenu(context, Message message) async {
    final RenderObject? overlay =
        Overlay.of(context).context.findRenderObject();
    final RelativeRect position = RelativeRect.fromRect(
        Rect.fromLTWH(_tapPostion.dx, _tapPostion.dy, 10, 10),
        Rect.fromLTWH(
          0,
          0,
          overlay!.paintBounds.size.width,
          overlay.paintBounds.size.height,
        ));
    final result = await showMenu(
      context: context,
      position: position,
      items: [
         PopupMenuItem(
          value: 'edit',
          child: Row(children: [
            const TextField(
              decoration: InputDecoration(
                hintText: "Edit Message",
              ),
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.edit))
          ]),
        ),
        const PopupMenuItem(
          value: 'delete',
          child: Text('Delete'),
        ),
      ],
    );
    switch (result) {
      case "edit":
      case "delete":
        chatBloc.add(ChatMessageDeleteEvent(
            widget.chat.user1, widget.chat.user2, message.createdAt));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        reverse: true,
        controller: widget.scrollController,
        itemCount: widget.chat.messages!.length,
        itemBuilder: (context, index) {
          Message message = Message(
            sender: widget
                .chat.messages[widget.chat.messages.length - index - 1][1],
            createdAt: widget
                .chat.messages[widget.chat.messages.length - index - 1][0],
            text: widget.chat.messages[widget.chat.messages.length - index - 1]
                [2],
          );

          return Align(
            alignment: (message.sender == widget.chat.user1)
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.66,
              ),
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.symmetric(vertical: 5.0),
              decoration: BoxDecoration(
                color: (message.sender == widget.chat.user2)
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.secondary,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: GestureDetector(
                onTapDown: (postion) {
                  _getTapPostion(postion);
                },
                onLongPress: () {
                  _showContextMenu(context, message);
                },
                onDoubleTap: () {
                  _showContextMenu(context, message);
                },
                child: Text(
                  message.text,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
