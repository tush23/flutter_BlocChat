import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterchatdemo/components/helper.dart';
import 'package:flutterchatdemo/constants/constants.dart';
import 'package:flutterchatdemo/repo/user_database.dart';
import 'package:flutterchatdemo/search/index.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  UserDataBase userDataBase;
  QuerySnapshot querySnap;
  SearchBloc() {
    userDataBase = UserDataBase();
  }

  @override
  Future<void> close() async {
    // dispose objects
    await super.close();
  }

  @override
  SearchState get initialState => SearchInitialState();

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    try {
      if (event is SearchBtnEvent) {
        yield SearchingState();
        querySnap = await userDataBase.getUserByUserName(event.query);
        yield SearchSuccesState(querySnap: querySnap);
      }
      if (event is SearchMsgBtnPressedEvent) {
        chatRoomConvoStarter(event.userName);
        yield SearchMsgtoChatState();
      }
    } catch (_, stackTrace) {
      developer.log('$_', name: 'SearchBloc', error: _, stackTrace: stackTrace);
      yield SearchFailureState(_);
    }
  }

  chatRoomConvoStarter(String userName1) async {
    myName = await Helper.getUserNameInSP();
    hisName = userName1;
    print("Username1=$userName1 || myName=$myName");

    if (userName1 != null && userName1 != myName) {
      List<String> users = [userName1, myName];
      var chatRoomId = getChatRoomID(userName1, myName);
      Map<String, dynamic> chatRoomMap = {
        "users": users,
        "chatroomId": chatRoomId
      };
      userDataBase.createChatRoom(chatRoomId, chatRoomMap);
      mChatRoomId = chatRoomId;
      print("Username1=$userName1 || myName=$myName || roomId=$chatRoomId");
    } else {
      print("Chat room not created");
    }
  }

  getChatRoomID(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else
      return "$a\_$b";
  }
}
