import 'package:equatable/equatable.dart';

abstract class ChatRoomState extends Equatable {
  /// notify change state without deep clone state
  
  @override
  List<Object> get props => [];
}

/// UnInitialized

/// Initialized
class ChatRoomMsgSendState extends ChatRoomState {
  
}
class ChatRoomMsgLoadedSucsessState extends ChatRoomState {
  final Stream chatMsgStream;

  ChatRoomMsgLoadedSucsessState({this.chatMsgStream});
}
class ChatRoomMsgLoadingState extends ChatRoomState {
}

class ErrorChatRoomState extends ChatRoomState {
  final String errorMessage;

  ErrorChatRoomState(this.errorMessage): super();
  
  
}
