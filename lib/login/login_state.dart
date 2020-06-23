import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class LoginState extends Equatable {
  /// notify change state without deep clone state

  @override
  List<Object> get props => [];
}
class LoginInitialState extends LoginState{}

/// UnInitialized
class LoginLoadingState extends LoginState{}

class LoginSuccessState extends LoginState{
  final FirebaseUser user;
  LoginSuccessState({@required this.user});
}

class LoginFailureState extends LoginState{
  final String error;

  LoginFailureState({@required this.error});
}