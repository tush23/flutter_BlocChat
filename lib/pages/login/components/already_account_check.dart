import 'package:flutter/material.dart';
import 'package:flutterchatdemo/constants/constants.dart';
import 'package:flutterchatdemo/login/login_page.dart';

class AlreadyhaveAccountCheck extends StatelessWidget {
  final bool login;
  final Function press;
  final BuildContext bcontext;
  const AlreadyhaveAccountCheck({
    Key key,
    this.login,
    this.press,
    this.bcontext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(login ? dontHaveAcc : alreadyHaveAcc),
        GestureDetector(
            onTap: press,
            child: Text(
              login ? signUp : signIn,
              style: TextStyle(color: tPrimaryColor),
            ))
      ],
    );
  }
}
