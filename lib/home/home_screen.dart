import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterchatdemo/chatRoom/index.dart';
import 'package:flutterchatdemo/components/helper.dart';
import 'package:flutterchatdemo/constants/constants.dart';
import 'package:flutterchatdemo/home/index.dart';
import 'package:flutterchatdemo/login/index.dart';
import 'package:flutterchatdemo/search/search_page.dart';

class HomeScreen extends StatefulWidget {
  final FirebaseUser user;

  HomeScreen({@required this.user});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc homeBloc;

  @override
  Widget build(BuildContext context) {
    homeBloc = BlocProvider.of<HomeBloc>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: tPrimaryColor,
        title: Center(
          child: Text("Home"),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () async {
                homeBloc.add(HomeLogoutBtnPressedEvent());
              })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: tPrimaryColor,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SearchPage()));
        },
        child: Icon(Icons.search),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Text(widget.user.email),
            BlocListener<HomeBloc, HomeState>(
              listener: (context, state) {
                if (state is HomeLogoutSuccessState) {
                  navigateToLoginPage(context);
                }
                if (state is HomeInitialState) {
                  print("HomeInitialState");
                  homeBloc.add(HomeChatRoomSuccesEvent());
                }
                if (state is HomeChatToConversationSuccessState) {
                  print("Home to Chat");
                  navigateTopagePush(context, ChatRoomPage());
                }
              },
              child:
                  BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
                if (state is HomeInitialState) {
                  homeBloc.add(HomeChatRoomSuccesEvent());
                  return initialHomeWidget();
                }
                if (state is HomeChatRoomsGetSuccessState) {
                  print("HomeChatRoomsGetSuccessState");
                  print(state.chatRoomStream.toString());
                  return chatRoomList(state.chatRoomStream, homeBloc);
                }
                return Container();
              }),
            ),
          ],
        ),
      ),
    );
  }

  void navigateToLoginPage(BuildContext context) {
    print("******navigateToRegisterPage******");
    navigateTopage(context, LoginPage());
  }

  Widget initialHomeWidget() {
    //getUserInfo();
    return Text("Initial Home page");
  }

  getUserInfo() async {
    myName = await Helper.getUserNameInSP();
    return myName;
  }

  Widget chatRoomList(Stream chatRoomStream, homeBloc) {
    print(chatRoomList);
    print(chatRoomStream);
    return StreamBuilder(
      stream: chatRoomStream,
      builder: (context, snpashot) {
        print("#######");
        //print(snpashot.data.documents.toString());
        return snpashot.hasData
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: snpashot.data.documents.length,
                itemBuilder: (context, index) {
                  print(snpashot.data.documents[index].data["chatroomId"]);
                  // mChatRoomId=snpashot.data.documents[index].data["chatroomId"];
                  return ChatRoomListItem(
                    userName: snpashot.data.documents[index].data["chatroomId"]
                        .toString()
                        .replaceAll("_", "")
                        .replaceAll(myName, ""),
                    homeBloc: homeBloc,
                  );
                },
              )
            : Text("No Chat Rooms");
      },
    );
  }
}

class ChatRoomListItem extends StatelessWidget {
  final String userName;
  final HomeBloc homeBloc;
  const ChatRoomListItem({Key key, this.userName, this.homeBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("ChatRoomListItem=$userName");
    return GestureDetector(
      onTap: () {
        homeBloc.add(HomeChatBtnPressEvent());
      },
      child: Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: <Widget>[
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: tPrimaryColor),
              child: Center(
                  child: Text(
                "${userName.substring(0, 1).toUpperCase()}",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
            ),
            SizedBox(
              width: 10,
            ),
            Text(userName)
          ],
        ),
      ),
    );
  }
}
