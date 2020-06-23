import 'package:flutter/material.dart';
import 'package:flutterchatdemo/constants/constants.dart';
import 'package:flutterchatdemo/login/login_bloc.dart';

import 'textfeild_container.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon, suffixIcon;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  const RoundedInputField(
      {Key key, this.hintText, this.icon, this.controller, this.suffixIcon, this.onChanged, LoginBloc bloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
        child: TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
          hintText: hintText,
          icon: Icon(
            icon,
            color: tPrimaryColor,
          ),
          suffixIcon: Icon(
            suffixIcon,
            color: tPrimaryColor,
          ),
          border: InputBorder.none),
    ));
  }
}
