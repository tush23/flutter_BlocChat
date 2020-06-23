import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {

  @override
  List<Object> get props => [];
}

/// UnInitialized
class HomeInitialState extends HomeState {

}

/// Initialized
class HomeLogoutSuccessState extends HomeState {
  
}
class HomeChatRoomsGetSuccessState extends HomeState {
  final Stream chatRoomStream;

  HomeChatRoomsGetSuccessState({this.chatRoomStream});
  
}
class HomeChatToConversationSuccessState extends HomeState {
  final String chatId;

  HomeChatToConversationSuccessState({this.chatId});
  
} 

