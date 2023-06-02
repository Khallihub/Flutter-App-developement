import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picstash/presentation/components/chat/chat_screen_messages.dart';

import '../../application/chat_bloc/blocs.dart';
import '../../domain/entities/models/user_model.dart';
import '../components/chat/chat_home_screen_message.dart';
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

  late ChatBloc chatBloc;
  // final User user = const User(id: "1", name: "khlaid", imageUrl: "imageUrl");
  late String text;
  // late Chat chat = Chat();
  @override
  void initState() {
    chatBloc = BlocProvider.of<ChatBloc>(context);
    chatBloc.add(ChatLoadEvent(widget.user1, widget.user2));
    super.initState();
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
          child: BlocBuilder<ChatBloc, ChatState>(
            builder: (context, state) {
              print("state is $state");

              if (state is ChatLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ChatLoadOperationSuccess) {
                print("object" * 99);
                print(state.chats[0].messages);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ChatScreenMessages(
                      chat: state.chats[0],
                      scrollController: scrollController,
                    ),
                    TextFormField(
                      controller: textEditingController,
                      
                      // onChanged: (value) {
                      //   setState(() {
                      //     text = value;
                      //   });
                      // },
                      style: Theme.of(context).textTheme.bodyMedium,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withAlpha(150),
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
                );
              } else if (state is ChatOperationFailure) {
                return const Center(child: Text("error"));
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  IconButton _buildIconButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.send),
      color: Theme.of(context).iconTheme.color,
      onPressed: () {
        chatBloc.add(ChatMessageSendEvent(
            widget.user1, widget.user2, widget.user1, textEditingController.text));
      },
    );
  }
}
