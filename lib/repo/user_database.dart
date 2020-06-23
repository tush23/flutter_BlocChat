import 'package:cloud_firestore/cloud_firestore.dart';

class UserDataBase {
  var firstoreInstance = Firestore.instance;
  getUserByUserName(String query) async {
    return await firstoreInstance
        .collection("users")
        .where("name", isEqualTo: query)
        .getDocuments();
  }

  getUserByEmail(String userEmail) async {
    return await firstoreInstance
        .collection("users")
        .where("email", isEqualTo: userEmail)
        .getDocuments();
  }

  uploaduserInfo(userMap) {
    firstoreInstance
        .collection("users")
        .add(userMap)
        .whenComplete(() => print("Upload Succes"));
    print("UserDataBase");
  }

  createChatRoom(String chatRoomId, chatRoomMap) {
    firstoreInstance
        .collection("ChatRoom")
        .document(chatRoomId)
        .setData(chatRoomMap);
    print("Chat room created");
  }

  addConvoMsg(String chatRoomId, chatMsgMap) {
    firstoreInstance
        .collection("ChatRoom")
        .document(chatRoomId)
        .collection("chats")
        .add(chatMsgMap);
  }

  getConvoMsg(String chatRoomId) {
    return firstoreInstance
        .collection("ChatRoom")
        .document(chatRoomId)
        .collection("chats")
        .orderBy("time", descending: false)
        .snapshots();
  }

  getChatRooms(String userName) {
  
    return firstoreInstance
        .collection("ChatRoom")
        .where("users", arrayContains: userName)
        .snapshots();
  }
}
