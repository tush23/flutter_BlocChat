import 'package:flutter/material.dart';
import 'package:flutterchatdemo/constants/constants.dart';

class SocialiconContainer extends StatelessWidget {
  final IconData icon;
  final Function press;
  const SocialiconContainer({
    Key key,
    this.icon,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.brown[100],
            ),
            borderRadius: BorderRadius.circular(12),
            shape: BoxShape.rectangle),
        child: Icon(
          icon,
          color: tPrimaryColor,
        ),
      ),
    );
  }
}

class OrDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * .8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Divider(
              height: 1.5,
              thickness: 1,
              color: Colors.brown[100],
            ),
          ),
          Text("  Or  "),
          Expanded(
            child: Divider(
              height: 1.5,
              thickness: 1,
              color: Colors.brown[100],
            ),
          ),
        ],
      ),
    );
  }
}
