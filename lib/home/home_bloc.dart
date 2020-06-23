import 'dart:async';
import 'dart:developer' as developer;
import 'package:bloc/bloc.dart';
import 'package:flutterchatdemo/components/helper.dart';
import 'package:flutterchatdemo/constants/constants.dart';
import 'package:flutterchatdemo/repo/user_database.dart';
import 'package:flutterchatdemo/repo/user_repo.dart';
import 'index.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  // todo: check singleton for logic in project
  UserRepo userRepo;
  UserDataBase userDataBase;
  HomeBloc() {
    this.userRepo = UserRepo();
    this.userDataBase = UserDataBase();
  }

  @override
  Future<void> close() async {
    // dispose objects
    await super.close();
  }

  @override
  HomeState get initialState => HomeInitialState();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    Stream chatRoomStream = userDataBase.getChatRooms(myName);
    try {
      if (event is HomeLogoutBtnPressedEvent) {
        myName = await Helper.getUserNameInSP();
        await userRepo.signOut();
        yield HomeLogoutSuccessState();
      }
      if (event is HomeChatRoomSuccesEvent) {
        print("*********");
        print(chatRoomStream);
        yield HomeChatRoomsGetSuccessState(chatRoomStream: chatRoomStream);
      }
      if(event is HomeChatBtnPressEvent){
        yield HomeChatToConversationSuccessState(
          chatId: mChatRoomId
        );
      }
    } catch (_, stackTrace) {
      developer.log('$_', name: 'HomeBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
