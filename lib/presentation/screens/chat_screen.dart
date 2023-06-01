import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/chat_bloc/blocs.dart';
import '../../application/chat_bloc/chat_bloc.dart';
import '../../application/search_bloc/search_blocs.dart';
import '../../domain/entities/models/message_model.dart';
import '../../domain/entities/models/user_model.dart';
import '../components/chat/chat_message.dart';
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
    
              if (state is ChatLoadingState){
                return const Center(child: CircularProgressIndicator());
              } else if (state is ChatLoadOperationSuccess) {
                  print("object"*99);
                  print(state.chats[0].messages);
              } else if (state is ChatOperationFailure) {
                return const Center(child: Text("error"));
              } else {
                return Container();
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ChatMessages(
                    height: 45,
                    chats: [],
                  ),
                  TextFormField(
                    controller: textEditingController,
                    onChanged: (value) {
                      setState(() {
                        text = value;
                      });
                    },
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
        // Message message = Message(
        //   senderId: '1',
        //   recipientId: '2',
        //   text: text,
        //   createdAt: DateTime.now(),
        // );
        // List<Message> messages = List.from(chat.messages!)..add(message);
        // messages.sort((a, b) => b.createdAt.compareTo(a.createdAt));

        // setState(() {
        //   chat = chat.copyWith(messages: messages);
        // });
        // scrollController.animateTo(
        //   scrollController.position.minScrollExtent,
        //   duration: const Duration(milliseconds: 300),
        //   curve: Curves.easeIn,
        // );
        // textEditingController.clear();
      },
    );
  }
}

// class _ChatMessages extends StatelessWidget {
//   const _ChatMessages({
//     Key? key,
//     required this.scrollController,
//     required this.chat,
//   }) : super(key: key);

//   final ScrollController scrollController;
//   final Chat chat;

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: ListView.builder(
//         reverse: true,
//         controller: scrollController,
//         itemCount: chat.messages!.length,
//         itemBuilder: (context, index) {
//           Message message = chat.messages![index];
//           return Align(
//             alignment: (message.senderId == '1')
//                 ? Alignment.centerLeft
//                 : Alignment.centerRight,
//             child: Container(
//               constraints: BoxConstraints(
//                 maxWidth: MediaQuery.of(context).size.width * 0.66,
//               ),
//               padding: const EdgeInsets.all(10.0),
//               margin: const EdgeInsets.symmetric(vertical: 5.0),
//               decoration: BoxDecoration(
//                 color: (message.senderId == '1')
//                     ? Theme.of(context).colorScheme.primary
//                     : Theme.of(context).colorScheme.secondary,
//                 borderRadius: const BorderRadius.all(Radius.circular(10)),
//               ),
//               child: Text(
//                 message.text,
//                 style: Theme.of(context).textTheme.bodyMedium,
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

