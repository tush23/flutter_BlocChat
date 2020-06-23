
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeEvent extends Equatable{
   @override
  List<Object> get props => throw UnimplementedError();
}

class HomeLogoutBtnPressedEvent extends HomeEvent {
 
}
class HomeChatRoomSuccesEvent extends HomeEvent {
 
}
class HomeChatBtnPressEvent extends HomeEvent {
 
}

