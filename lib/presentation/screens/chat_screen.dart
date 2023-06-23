import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../application/chat_bloc/blocs.dart';
import '../../domain/entities/models/user_model.dart';
import '../components/chat/chat_screen_messages.dart';
import '../components/chat/custom_chat_app_bar.dart';
import '../components/chat/custom_container.dart';

class ChatScreen extends StatefulWidget {
  final String user1;
  final String user2;
  final String id;
  final String friendName;
  final String friendImage;
  const ChatScreen({
    Key? key,
    required this.user1,
    required this.user2,
    required this.id,
    required this.friendName,
    required this.friendImage,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ScrollController scrollController = ScrollController();
  TextEditingController textEditingController = TextEditingController();

  late IO.Socket socket;
  late ChatBloc chatBloc;
  late String text;
  String time = "";

  @override
  void initState() {
    connect();
    chatBloc = BlocProvider.of<ChatBloc>(context);
    chatBloc.add(ChatLoadEvent(widget.user1, widget.user2));
    // textEditingController.text = " ";
    super.initState();
  }

  @override
  void dispose() {
    disconnect();
    // chatBloc.add(AllChatsLoadEvent(widget.user1));
    super.dispose();
  }

  void connect() {
    socket = IO.io("http://192.168.57.158:3000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();
    socket.emit("joined", {"sender": widget.user1, "receiver": widget.user2});
    socket.onConnect((data) {
      socket.on("message", (data) {
        chatBloc.add(ChatLoadEvent(widget.user1, widget.user2));
      });
    });
  }

  void disconnect() {
    socket.emit("disconnect", widget.user1);
    socket.disconnect();
  }

  void notifiy() {
    socket.emit("message",
        {"sender": widget.user1, "receiver": widget.user2, "status": "sent"});
  }

  @override
  Widget build(BuildContext context) {
    User friend = User(
        name: widget.friendName,
        avatarUrl: widget.friendImage,
        id: widget.id,
        userName: widget.user2);
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            colors: [
              Theme.of(context).colorScheme.secondary,
              Theme.of(context).colorScheme.primary,
            ],
          ),
        ),
        child: Scaffold(
          appBar: CustomAppBar(
            user: friend,
            text: widget.friendName,
          ),
          backgroundColor: Colors.transparent,
          body: CustomContainer(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocBuilder<ChatBloc, ChatState>(
                  builder: (context, state) {
                    if (state is ChatLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ChatLoadOperationSuccess) {
                      return ChatScreenMessages(
                        chat: state.chats[0],
                        scrollController: scrollController,
                      );
                    } else if (state is ChatMessageDeletedState) {
                      notifiy();
                      return ChatScreenMessages(
                        chat: state.chat,
                        scrollController: scrollController,
                      );
                    } else if (state is ChatMessageUpdatedState) {
                      notifiy();
                      return ChatScreenMessages(
                        chat: state.chat,
                        scrollController: scrollController,
                      );
                    } else if (state is SetParentTextFieldState) {
                      SchedulerBinding.instance.addPostFrameCallback(
                        (_) {
                          textEditingController.value =
                              TextEditingValue(text: state.text);
                          time = state.time;
                        },
                      );
                      return ChatScreenMessages(
                          scrollController: scrollController, chat: state.chat);
                    } else if (state is ChatOperationFailure) {
                      return const Center(child: Text("error"));
                    } else {
                      return Container();
                    }
                  },
                ),
                TextFormField(
                  controller: textEditingController,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor:
                        Theme.of(context).colorScheme.secondary.withAlpha(150),
                    hintText: 'Type here...',
                    hintStyle: Theme.of(context).textTheme.bodyMedium,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(20.0),
                    suffixIcon: _buildIconButton(context),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  IconButton _buildIconButton(BuildContext context) {
    return IconButton(
      icon: Icon(time == "" ? Icons.send : Icons.save),
      color: Theme.of(context).iconTheme.color,
      onPressed: () {
        if (textEditingController.text.trim().isNotEmpty) {
          time == ""
              ? chatBloc.add(ChatMessageSendEvent(widget.user1, widget.user2,
                  widget.user1, textEditingController.text))
              : chatBloc.add(ChatMessageUpdateEvent(widget.user1, widget.user2,
                  widget.user1, textEditingController.text, time));
          textEditingController.clear();
          time = "";
          notifiy();
        }
      },
    );
  }
}
