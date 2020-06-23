// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutterappbloclogin/blocs/auth/index.dart';

// class AuthScreen extends StatefulWidget {
//   const AuthScreen({
//     Key key,
//     @required AuthBloc authBloc,
//   })  : _authBloc = authBloc,
//         super(key: key);

//   final AuthBloc _authBloc;

//   @override
//   AuthScreenState createState() {
//     return AuthScreenState();
//   }
// }

// class AuthScreenState extends State<AuthScreen> {
//   AuthScreenState();

//   @override
//   void initState() {
//     super.initState();
//     _load();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AuthBloc, AuthState>(
//         bloc: widget._authBloc,
//         builder: (
//           BuildContext context,
//           AuthState currentState,
//         ) {
//           if (currentState is UnAuthState) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           if (currentState is ErrorAuthState) {
//             return Center(
//                 child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Text(currentState.errorMessage ?? 'Error'),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 32.0),
//                   child: RaisedButton(
//                     color: Colors.blue,
//                     child: Text('reload'),
//                     onPressed: _load,
//                   ),
//                 ),
//               ],
//             ));
//           }
//            if (currentState is InAuthState) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Text(currentState.hello),
//                   Text('Flutter files: done'),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 32.0),
//                     child: RaisedButton(
//                       color: Colors.red,
//                       child: Text('throw error'),
//                       onPressed: () => _load(true),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }
//           return Center(
//               child: CircularProgressIndicator(),
//           );
          
//         });
//   }

//   void _load([bool isError = false]) {
//     widget._authBloc.add(LoadAuthEvent(isError));
//   }
// }
