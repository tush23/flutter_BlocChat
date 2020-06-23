import 'package:flutter/material.dart';

const Color tPrimaryColor = Color(0xFFE0565F);
Color tPrimaryLightColors = Color(0xFFF9D4D7);
const String boychatImgpath = "assets/images/boychat.png";
const String girlchatImgpath = "assets/images/girlchat.png";
const String boygirlchatImgpath = "assets/images/boygirlchat.png";
const String bg_1path = "assets/bg/oval.png";
const String bg_2path = "assets/bg/bg_2.png";
const String bg_3path = "assets/bg/bg_3.png";

const String app_name = "Chatter";
const String app_version = "Version 1.0.0";
const String google_sans_family = 'GoogleSans';
const String welcomeText = "Welcome to Chatter";
const String dontHaveAcc = "Don't have Account? ";
const String alreadyHaveAcc = "Already have Account? ";
const String signUp = "Sign Up";
const String signIn = "Sign In";
String myName="";
String hisName="";
String mChatRoomId="";
//Stream mChatStream;


//*Shared Prefrences
const String sharedUserLoggedInKey="ISLOGGEDIN";
const String sharedUserNameKey="USERNAMEKEY";
const String sharedUserEmailKey="USEREMAILKEY";

void navigateTopage(BuildContext context, Widget pageTo) {
  print("******navigate=$pageTo******");

  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
    return pageTo;
  }));
}
void navigateTopagePush(BuildContext context, Widget pageTo) {
  print("******navigate=$pageTo******");

  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
    return pageTo;
  }));
}
class Dialogs {
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  backgroundColor: Colors.black54,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 10,),
                        Text("Please Wait....",style: TextStyle(color: Colors.blueAccent),)
                      ]),
                    )
                  ]));
        });
  }
}
