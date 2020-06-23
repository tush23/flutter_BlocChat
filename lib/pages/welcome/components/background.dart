import 'package:flutter/material.dart';
import 'package:flutterchatdemo/constants/constants.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          Positioned(
              bottom: 600,
              right: 200,
              child: Image.asset(bg_1path)),
          Positioned(
              top: 630, right: 300, child: Image.asset(bg_2path)),
          Center(
            child: child,
          )
        ],
      ),
    );
  }
}
