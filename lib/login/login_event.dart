
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LoginEvent extends Equatable{
   @override
  List<Object> get props => [];
  
}

class LoginBtnPressedEvent extends LoginEvent {
  final String email , pass;

  LoginBtnPressedEvent({@required this.email,@required this.pass});
}
class LoginGoogleBtnPressedEvent extends LoginEvent {

}