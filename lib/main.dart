import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterchatdemo/constants/constants.dart';
import 'package:flutterchatdemo/pages/welcome/welcome_page.dart';
import 'package:flutterchatdemo/register/register_page.dart';

import 'auth/index.dart';
import 'home/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme:
          ThemeData(primarySwatch: Colors.red, fontFamily: google_sans_family),
      home: BlocProvider(
        create: (context) => AuthBloc()..add(AuthStartedEvent()),
        child: App(),
      ),
    );
  }
}

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if (state is AuthInitialState) {
        return WelcomePage();
      } else if (state is AuthenticatedState) {
        return HomePage(
          user: state.firebaseUser,
        );
      } else if (state is UnAuthenticatedState) {
        return WelcomePage();
      }
    });
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Splash Screen"),
    );
  }
}
