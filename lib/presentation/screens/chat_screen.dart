import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/chat_bloc/blocs.dart';

class ChatScreen extends StatefulWidget {
  final String user1;
  final String user2;

  const ChatScreen({super.key, required this.user1, required this.user2});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late ChatBloc chatBloc;
  @override
  void initState() {
    chatBloc = BlocProvider.of<ChatBloc>(context);
    chatBloc.add(ChatLoadEvent(widget.user1, widget.user2));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("chat"),
      ),
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          print(state.props);
          return SingleChildScrollView(
              child: Container(
            child: Center(child: Text("test")),
          ));
        },
      ),
    );
  }
}
