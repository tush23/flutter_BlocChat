
import 'package:meta/meta.dart';

@immutable
abstract class ChatRoomEvent {
  }

class ChatRoomStarted extends ChatRoomEvent {
}
class ChatRoomSendBtnEvent extends ChatRoomEvent {
  final String msg;

  ChatRoomSendBtnEvent({this.msg});
}
class ChatRoomMsgLoadingEvent extends ChatRoomEvent{}

class ChatRoomErrorEvent extends ChatRoomEvent {
   
  @override
  String toString() => 'LoadChatRoomEvent';
}
