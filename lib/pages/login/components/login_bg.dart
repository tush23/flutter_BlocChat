import 'package:flutter/material.dart';
import 'package:flutterchatdemo/constants/constants.dart';

class LoginBackground extends StatelessWidget {
  Widget child;
  LoginBackground({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      child: Stack(
        children: <Widget>[
          Positioned(
              height: size.height * 0.3,
              bottom: 640,
              right: 190,
              child: Image.asset(bg_1path)),
          Positioned(
              top: 150,
              right: 100,
              height: size.height * .07,
              child: Image.asset(bg_2path)),
          Positioned(
              top: 650,
              left: 300,
              height: size.height * .2,
              child: Image.asset(bg_2path)),
          Center(child: child)
        ],
      ),
    );
  }
}
