import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterchatdemo/chatRoom/index.dart';
import 'package:flutterchatdemo/constants/constants.dart';

class ChatRoomScreen extends StatefulWidget {
  ChatRoomScreen({
    Key key,
    @required ChatRoomBloc chatRoomBloc,
  })  : _chatRoomBloc = chatRoomBloc,
        super(key: key);

  ChatRoomBloc _chatRoomBloc;

  @override
  ChatRoomScreenState createState() {
    return ChatRoomScreenState();
  }
}

class ChatRoomScreenState extends State<ChatRoomScreen> {
  ChatRoomScreenState();
  //Stream chatMsgStream;
  TextEditingController msgController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      child: Stack(
        children: <Widget>[
          BlocListener<ChatRoomBloc, ChatRoomState>(
            bloc: widget._chatRoomBloc,
            listener: (context, state) {},
            child: BlocBuilder<ChatRoomBloc, ChatRoomState>(
                bloc: widget._chatRoomBloc,
                builder: (
                  BuildContext context,
                  ChatRoomState currentState,
                ) {
                  if (currentState is ChatRoomMsgLoadingState) {
                    widget._chatRoomBloc.add(ChatRoomMsgLoadingEvent());
                    return Text("Loading Msg");
                  }
                  if (currentState is ChatRoomMsgLoadedSucsessState) {
                    return chatMsgStreamMethod(currentState.chatMsgStream);
                  }
                  if (currentState is ChatRoomMsgSendState) {
                    return Container();
                  }
                }),
          ),
          Container(
            width: double.infinity,
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              color: Colors.grey[400],
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: msgController,
                      decoration: InputDecoration(
                          hintText: "message", border: InputBorder.none),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      sendBtnMethod(widget._chatRoomBloc, msgController.text);
                      msgController.clear();
                      print("sendClicked");
                    },
                    child: Icon(
                      Icons.send,
                      color: tPrimaryColor,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void sendBtnMethod(ChatRoomBloc chatBloc, msg) {
    chatBloc.add(ChatRoomSendBtnEvent(msg: msg));
  }

  Widget chatMsgStreamMethod(Stream chatMsgStream) {
    //print("chatMsgStreamMethod");
    //print(chatMsgStream);
    return StreamBuilder(
      stream: chatMsgStream,
      builder: (context, snapshots) {
        //print(snapshots);
        return snapshots.hasData
            ? ListView.builder(
                itemCount: snapshots.data.documents.length,
                itemBuilder: (context, index) {
                  return MessageTile(
                    msg: snapshots.data.documents[index].data["message"],
                    iSendByMe: snapshots.data.documents[index].data["sendBy"] ==
                        myName,
                  );
                },
              )
            : Text("No Msg Found");
      },
    );
  }
}

class MessageTile extends StatelessWidget {
  final String msg;
  final bool iSendByMe;
  const MessageTile({Key key, this.msg, this.iSendByMe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: EdgeInsets.symmetric(horizontal: 10),
      alignment: iSendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: iSendByMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20))
                : BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
            color: iSendByMe ? tPrimaryColor : Colors.grey,
          ),
          child: Text(msg)),
    );
  }
}
