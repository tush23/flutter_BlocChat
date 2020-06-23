import 'dart:async';
import 'dart:developer' as developer;
import 'package:bloc/bloc.dart';
import 'package:flutterchatdemo/components/helper.dart';
import 'package:flutterchatdemo/repo/user_repo.dart';
import 'index.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  // todo: check singleton for logic in project
  UserRepo userRepo;
  LoginBloc() {
    this.userRepo = UserRepo();
  }

  @override
  Future<void> close() async {
    // dispose objects
    await super.close();
  }

  @override
  LoginState get initialState => LoginInitialState();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    try {
      if (event is LoginBtnPressedEvent) {
        yield LoginLoadingState();
        Helper.saveUserNameInSP(event.pass);
        Helper.saveUserEmailInSP(event.email);
        var user = await userRepo.signInwithEmailPass(event.email, event.pass);
        Helper.saveUserLoggedInSP(true);
        yield LoginSuccessState(user: user);
      }
      if (event is LoginGoogleBtnPressedEvent) {
        yield LoginLoadingState();
        var user = await userRepo.signInWithGoogle();
        yield LoginSuccessState(user: user);
      }
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoginBloc', error: _, stackTrace: stackTrace);
      yield LoginFailureState(error: _);
    }
  }
}
