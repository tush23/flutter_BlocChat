import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutterchatdemo/constants/constants.dart';
import 'package:flutterchatdemo/home/index.dart';
import 'package:flutterchatdemo/login/index.dart';
import 'package:flutterchatdemo/pages/login/components/already_account_check.dart';
import 'package:flutterchatdemo/pages/login/components/login_bg.dart';
import 'package:flutterchatdemo/pages/login/components/textfeild_container.dart';
import 'package:flutterchatdemo/pages/signup/social_icon_container.dart';
import 'package:flutterchatdemo/register/index.dart';
import 'package:flutterchatdemo/validator/validator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatelessWidget {
  Validators _validators = Validators();
  var formkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  LoginBloc loginBloc;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    loginBloc = BlocProvider.of<LoginBloc>(context);
    return Scaffold(
      body: SafeArea(
        child: LoginBackground(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "LOGIN",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Image.asset(
                girlchatImgpath,
                height: 250,
              ),
              SizedBox(
                height: 20,
              ),
              BlocListener<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state is LoginSuccessState) {
                    navigateToHomePage(context, state.user);
                  }
                },
                child: BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                  if (state is LoginInitialState) {
                    return logInitialUI(context);
                  } else if (state is LoginLoadingState) {
                    return loginLoadingUI(context, formkey);
                  } else if (state is LoginFailureState) {
                    return loginFailedUI(state.error);
                  } else if (state is LoginSuccessState) {
                    return Container();
                  }
                }),
              ),

              Form(
                  key: formkey,
                  child: Column(
                    children: <Widget>[
                      TextFieldContainer(
                        child: TextFormField(
                          autovalidate: false,
                          validator: (value) {
                            return _validators.isValidEmail(value)
                                ? null
                                : _validators.validatorMsg("");
                          },
                          controller: emailController,
                          decoration: InputDecoration(
                              fillColor: Colors.brown,
                              hintText: "Email",
                              icon: Icon(
                                Icons.mail,
                                color: tPrimaryColor,
                              ),
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)),
                              border: InputBorder.none),
                        ),
                      ),
                      TextFieldContainer(
                          child: TextFormField(
                        autovalidate: false,
                        validator: (value) {
                          return _validators.isValidPassword(value) ||
                                  value.length > 6
                              ? null
                              : _validators.validatorMsg("Wrong Password");
                        },
                        controller: passController,
                        decoration: InputDecoration(
                            hintText: "Password",
                            icon: Icon(
                              Icons.lock,
                              color: tPrimaryColor,
                            ),
                            border: InputBorder.none),
                      )),
                    ],
                  )),
              // RoundedInputField(
              //   controller: emailController,
              //   bloc: loginBloc,
              //   hintText: "Email",
              //   icon: Icons.person,
              // ),
              // RoundedInputField(
              //   controller: passController,
              //   bloc: loginBloc,
              //   hintText: "Password",
              //   icon: Icons.lock,
              //   suffixIcon: Icons.visibility,
              // ),
              SizedBox(
                height: 3,
              ),
              GestureDetector(
                onTap: () {
                  loginBloc.userRepo.resetPass(emailController.text);
                },
                child: Container(
                    margin: EdgeInsets.only(right: 50),
                    alignment: Alignment.bottomRight,
                    child: Text("Forgot Password?")),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                width: size.width * 0.8,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: RaisedButton(
                      color: tPrimaryColor,
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                      onPressed: () {
                        onSibmitPressed(formkey, emailController.text,
                            passController.text, loginBloc);
                      },
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    )),
              ),
              // RoundedButton(
              //   press: () async {
              //     print(emailController.text);
              //     print(passController.text);
              //     loginBloc.add(LoginBtnPressedEvent(
              //         email: emailController.text, pass: passController.text));
              //   },
              //   text: "LOGIN",
              //   bgcolor: tPrimaryColor,
              //   textColor: Colors.black,
              // ),
              SizedBox(
                height: 20,
              ),
              AlreadyhaveAccountCheck(
                press: () {
                  navigateTopage(context, RegisterPage());
                  //Navigator.pop(context);
                },
                login: true,
              ),
              SizedBox(
                height: 10,
              ),
              OrDivider(),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SocialiconContainer(
                    icon: FontAwesomeIcons.facebookF,
                    press: () {},
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  SocialiconContainer(
                    icon: FontAwesomeIcons.google,
                    press: () {
                      loginBloc.add(LoginGoogleBtnPressedEvent());
                    },
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  SocialiconContainer(
                    icon: FontAwesomeIcons.twitter,
                    press: () {},
                  ),
                ],
              )
            ],
          ),
        )),
      ),
    );
  }

  Widget logInitialUI(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print("******regInitialUI******");
    return Container();
  }

  Widget loginLoadingUI(BuildContext context, var keyLoader) {
    print("******regLoadingUI******");
    return Center(
      child: SpinKitThreeBounce(
        key: keyLoader,
        color: tPrimaryColor,
        size: 20,
      ),
      // child: Container(
      //   width: size.width * .35,
      //   color: Colors.transparent,
      //   height: size.height * .14,
      //   child: WillPopScope(
      //     onWillPop: () async => false,
      //     child: SimpleDialog(key: keyLoader, children: <Widget>[
      //       Center(
      //         child: CircularProgressIndicator(),
      //       )
      //     ]),
      //   ),
      // ),
    );
    // return Container(
    //   height: size.height * 0.06,
    //   width: size.width * 0.8,s
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(40),
    //     color: tPrimaryColor,
    //   ),
    //   child: SpinKitThreeBounce(
    //     color: Colors.black,
    //     size: 20,
    //   ),
    // );
  }

  Widget loginFailedUI(String error) {
    print("******loginFailedUI******");
    return Text(error);
  }

  void navigateToHomePage(BuildContext context, FirebaseUser user) {
    print("******navigateToHomePage******");
    navigateTopage(context, HomePage(user: user));
  }

  void navigateToSignUPpage(BuildContext context) {
    print("******navigateToSignUp******");
    navigateTopage(context, RegisterPage());
  }

  void onSibmitPressed(
      var formkey, String email, String pass, LoginBloc loginBloc) {
    if (formkey.currentState.validate()) {
      print(email);
      print(pass);
      loginBloc.add(LoginBtnPressedEvent(email: email, pass: pass));
    } else {
      print("Not Valid Info");
    }
  }
}
