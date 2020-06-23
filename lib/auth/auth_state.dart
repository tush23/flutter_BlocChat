import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class AuthState extends Equatable {
  /// notify change state without deep clone state

  /// Copy object for use in action
  /// if need use deep clone
  @override
  List<Object> get props => [];
}

/// UnInitialized
class AuthInitialState extends AuthState {

  @override
  String toString() => 'AuthInitialState';
}

/// Initialized
class AuthenticatedState extends AuthState {
final FirebaseUser firebaseUser;
AuthenticatedState({@required this.firebaseUser});

  @override
  String toString() => 'AthenticatedState ';
}

class UnAuthenticatedState extends AuthState {
  
}
