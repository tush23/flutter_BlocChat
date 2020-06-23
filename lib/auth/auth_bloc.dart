import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:flutterchatdemo/auth/index.dart';
import 'package:flutterchatdemo/repo/user_repo.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  UserRepo _userRepo;
  // todo: check singleton for logic in project
  AuthBloc(){
    this._userRepo = UserRepo();
  }
  
  @override
  Future<void> close() async{
    // dispose objects
    await super.close();
  }

  @override
  AuthState get initialState => AuthInitialState();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    try {
      var isSignIn = await _userRepo.isSignIn();
      if(isSignIn){
        var user = await _userRepo.getCurrentUser();
        yield AuthenticatedState(firebaseUser: user);
      }
      else{
        yield UnAuthenticatedState();
      }
    } catch (_, stackTrace) {
      developer.log('$_', name: 'AuthBloc', error: _, stackTrace: stackTrace);
      yield UnAuthenticatedState();
    }
  }

}
