import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'index.dart';

class RegisterPage extends StatelessWidget {
  //RegisterBloc registerBloc;

  @override
  Widget build(BuildContext context) {
    //registerBloc = BlocProvider.of<RegisterBloc>(context);
    return BlocProvider(
      create: (context) => RegisterBloc(),
      child: RegisterScreen(),
    );
  }
}