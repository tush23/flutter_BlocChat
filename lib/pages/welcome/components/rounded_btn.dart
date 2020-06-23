import 'package:flutter/material.dart';
import 'package:flutterchatdemo/constants/constants.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Widget pageTo;
  final Color bgcolor;
  final Color textColor;
  final Function press;
  RoundedButton({
    Key key,
    this.text,
    this.pageTo,
    this.bgcolor = tPrimaryColor,
    this.textColor = Colors.black,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: RaisedButton(
            color: bgcolor,
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
            onPressed: () {
              print(text);
              navigateTopage(context, pageTo);
            },
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),
          )),
    );
  }
}
