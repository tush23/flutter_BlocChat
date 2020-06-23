import 'package:flutter/material.dart';
import 'package:flutterchatdemo/pages/welcome/components/body.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
