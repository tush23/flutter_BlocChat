import 'package:flutter/material.dart';
import 'package:flutterchatdemo/constants/constants.dart';

class SignUpBackground extends StatelessWidget {
  final Widget child;
  const SignUpBackground({
    Key key, this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      child: Stack(
        children: <Widget>[
          Positioned(right: 240, bottom: 600, child: Image.asset(bg_3path)),
          Positioned(top: 650, right: 300, child: Image.asset(bg_2path)),
          Center(child: child,)
        ],
      ),
    );
  }
}
