import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterchatdemo/search/index.dart';

abstract class SearchState extends Equatable {
  /// notify change state without deep clone state

  @override
  List<Object> get props => [];
}

/// UnInitialized
class SearchInitialState extends SearchState {}

/// Initialized
class SearchingState extends SearchState {}

class SearchSuccesState extends SearchState {
  final QuerySnapshot querySnap;

  SearchSuccesState({this.querySnap});
}
class SearchMsgtoChatState extends SearchState{
  
}

class SearchFailureState extends SearchState {
  final String errorMessage;

  SearchFailureState(this.errorMessage);

  @override
  String toString() => 'SearchFailureState';

  SearchFailureState getStateCopy() {
    return SearchFailureState(errorMessage);
  }

  SearchFailureState getNewVersion() {
    return SearchFailureState(errorMessage);
  }
}
