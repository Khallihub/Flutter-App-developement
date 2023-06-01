import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picstash/domain/entities/models/chat_model.dart';
import 'package:unicons/unicons.dart';

import '../../application/chat_bloc/blocs.dart';
import '../../domain/entities/models/user_model.dart';
import '../../infrastructure/data_providers/db/db.dart';
import '../components/chat/chat_contacts.dart';
import '../components/chat/chat_message.dart';
import '../components/chat/custom_chat_app_bar.dart';
import '../components/chat/custom_chat_nav_bar.dart';

class ChatListScreen extends StatelessWidget {
  ChatListScreen({Key? key}) : super(key: key);

  late ChatBloc chatBloc;

  Future<User> getUser() async {
    final LoginCredentials loginCredentials = LoginCredentials();
    final login = await loginCredentials.getLoginCredentials();
    final userDetail = login!.localUserModel;
    User user = User(
      id: userDetail.id,
      avatarUrl: userDetail.imageUrl,
      userName: userDetail.imageUrl,
      name: userDetail.username,
    );
    return user;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return FutureBuilder(
      future: getUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(UniconsLine.arrow_left),
                ),
              ),
              body: const CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Scaffold(
            body: Center(child: Text("error")),
          );
        }
        User? user = snapshot.data;
        chatBloc = BlocProvider.of<ChatBloc>(context);
        chatBloc.add(AllChatsLoadEvent(user!.name));

        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary,
              ],
            ),
          ),
          child: BlocBuilder<ChatBloc, ChatState>(
            builder: (context, state) {
              if (state is AllChatsLoadOperationInProgress) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is AllChatsLoadOperationSuccess) {
                final List<ChatModel> chatList = state.chats ;     

                return Scaffold(
                  appBar: CustomAppBar(
                    text: 'Chats',
                    user: user,
                  ),
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ChatContacts(height: height, users: chatList),
                      Expanded(
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            ChatMessages(height: height, chats: chatList),
                            CustomBottomNavBar(width: width),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: Text("Error"),
                );
              }
            },
          ),
        );
      },
    );
  }
}
