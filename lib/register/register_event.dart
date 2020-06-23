
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class RegisterEvent extends Equatable{}
class SignUpBtnPressedEvent extends RegisterEvent {
  final String name;
  final String email;
  final String pass;
  SignUpBtnPressedEvent( {@required this.email,@required this.name,@required this.pass});
  @override
  List<Object> get props => null;
}
