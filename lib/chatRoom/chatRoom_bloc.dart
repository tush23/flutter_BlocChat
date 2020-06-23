import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:flutterchatdemo/chatRoom/index.dart';
import 'package:flutterchatdemo/constants/constants.dart';
import 'package:flutterchatdemo/repo/user_database.dart';

class ChatRoomBloc extends Bloc<ChatRoomEvent, ChatRoomState> {
  // todo: check singleton for logic in project

  UserDataBase userDataBase;
  ChatRoomBloc() {
    userDataBase = UserDataBase();
  }

  @override
  Future<void> close() async {
    // dispose objects
    await super.close();
  }

  @override
  ChatRoomState get initialState => ChatRoomMsgLoadingState();

  @override
  Stream<ChatRoomState> mapEventToState(
    ChatRoomEvent event,
  ) async* {
    Stream chatMsgStream = userDataBase.getConvoMsg(mChatRoomId);
    try {
      if (event is ChatRoomStarted) {
        yield ChatRoomMsgLoadingState();
        chatMsgStream = userDataBase.getConvoMsg(mChatRoomId);

        //print(chatMsgStream.toString());

        yield ChatRoomMsgLoadedSucsessState(chatMsgStream: chatMsgStream);
      }
      if (event is ChatRoomMsgLoadingEvent) {
        yield ChatRoomMsgLoadingState();
        chatMsgStream = userDataBase.getConvoMsg(mChatRoomId);

        //print(chatMsgStream.toString());

        yield ChatRoomMsgLoadedSucsessState(chatMsgStream: chatMsgStream);
      }
      if (event is ChatRoomSendBtnEvent) {
        sendMesssage(event.msg);
        chatMsgStream = userDataBase.getConvoMsg(mChatRoomId);
        //print(chatMsgStream);
        yield ChatRoomMsgSendState();
        //print(mChatStream);

        yield ChatRoomMsgLoadedSucsessState(chatMsgStream: chatMsgStream);
      }
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'ChatRoomBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }

  sendMesssage(String msg) {
    //if (msg.isNotEmpty) {
    Map<String, dynamic> chatMsgMap = {
      "message": msg,
      "sendBy": myName,
      "time": DateTime.now().millisecondsSinceEpoch
    };
    print(chatMsgMap.toString());
    userDataBase.addConvoMsg(mChatRoomId, chatMsgMap);
    //}
  }
}
