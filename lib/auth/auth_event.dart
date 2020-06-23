
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthEvent extends Equatable {
  //final UserRepo _authRepository = UserRepo();
}

class AuthStartedEvent extends AuthEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}
