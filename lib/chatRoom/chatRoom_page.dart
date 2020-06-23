import 'package:flutter/material.dart';
import 'package:flutterchatdemo/chatRoom/index.dart';
import 'package:flutterchatdemo/constants/constants.dart';

class ChatRoomPage extends StatefulWidget {
  static const String routeName = '/chatRoom';

  @override
  _ChatRoomPageState createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  final _chatRoomBloc = ChatRoomBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ChatRoom'),
        backgroundColor: tPrimaryColor,
      ),
      body: ChatRoomScreen(chatRoomBloc: _chatRoomBloc),
    );
  }
}
