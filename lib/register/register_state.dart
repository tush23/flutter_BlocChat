import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

abstract class RegisterState extends Equatable {

  /// Copy object for use in action
  /// if need use deep clone
  @override
  List<Object> get props => [];
}

/// UnInitialized
class RegisterInitialState extends RegisterState {


  @override
  String toString() => 'RegisterInitialState';

}

/// Initialized
class RegisterLoadingState extends RegisterState {
}
class RegisterSuccesState extends RegisterState{
  final FirebaseUser user;
  RegisterSuccesState({@required this.user});

}

class RegisterFailureState extends RegisterState {
  final String errorMessage;

  RegisterFailureState({@required this.errorMessage});
  @override
  String toString() => 'RegisterFailureState';

}
