import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:flutterchatdemo/components/helper.dart';
import 'package:flutterchatdemo/constants/constants.dart';
import 'package:flutterchatdemo/repo/user_database.dart';
import 'package:flutterchatdemo/repo/user_repo.dart';

import 'index.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  // todo: check singleton for logic in project
  UserRepo userRepo;
  UserDataBase userDataBase;
  RegisterBloc() {
    this.userRepo = UserRepo();
    this.userDataBase = UserDataBase();
  }

  @override
  Future<void> close() async {
    // dispose objects
    await super.close();
  }

  @override
  RegisterState get initialState => RegisterInitialState();

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    try {
      if (event is SignUpBtnPressedEvent) {
        yield RegisterLoadingState();
        Map<String, String> userDataMap = {
          "name": event.name,
          "email": event.email,
          "pass": event.pass
        };
        myName = event.name;
        userDataBase.uploaduserInfo(userDataMap);
        Helper.saveUserNameInSP(event.name);
        Helper.saveUserEmailInSP(event.email);
        var user = await userRepo.createUser(event.email, event.pass);
        yield RegisterSuccesState(user: user);
      }
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'RegisterBloc', error: _, stackTrace: stackTrace);
      yield RegisterFailureState(errorMessage: _);
    }
  }
}
