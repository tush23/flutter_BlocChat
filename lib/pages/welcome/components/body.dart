import 'package:flutter/material.dart';
import 'package:flutterchatdemo/constants/constants.dart';
import 'package:flutterchatdemo/login/index.dart';
import 'package:flutterchatdemo/pages/welcome/components/background.dart';
import 'package:flutterchatdemo/pages/welcome/components/rounded_btn.dart';
import 'package:flutterchatdemo/register/index.dart';

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 40),
            child: Text(
              welcomeText,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.3,
                  fontSize: 22),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 30, bottom: 20),
            child: Image.asset(
              boygirlchatImgpath,
              height: size.height * 0.4,
            ),
          ),
          SizedBox(
            height: 70,
          ),
          RoundedButton(
              text: "Get Started",
              bgcolor: tPrimaryColor,
              pageTo: RegisterPage()),
          SizedBox(
            height: 15,
          ),
          // RoundedButton(
          //   text: "SIGNUP",
          //   bgcolor: tPrimaryColor,
          //   pageTo: RegisterPage(),
          // ),
        ],
      ),
    );
  }
}
