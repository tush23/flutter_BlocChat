import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutterchatdemo/constants/constants.dart';
import 'package:flutterchatdemo/home/index.dart';
import 'package:flutterchatdemo/login/index.dart';
import 'package:flutterchatdemo/pages/login/components/already_account_check.dart';
import 'package:flutterchatdemo/pages/login/components/textfeild_container.dart';
import 'package:flutterchatdemo/pages/signup/signup_bg.dart';
import 'package:flutterchatdemo/repo/user_database.dart';
import 'package:flutterchatdemo/validator/validator.dart';

import 'index.dart';

class RegisterScreen extends StatelessWidget {
  Validators _validators = Validators();
  var formkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  RegisterBloc registerBloc;
  bool loading = false;
  bool passVisibility = true;
  Color passVisibilityColor = tPrimaryColor;
  String name;
  String warningMsg = '';
  @override
  Widget build(BuildContext context) {
    registerBloc = BlocProvider.of<RegisterBloc>(context);

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SignUpBackground(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "SIGN UP",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                Image.asset(
                  boychatImgpath,
                  height: size.height * 0.35,
                ),
                SizedBox(
                  height: 10,
                ),

                Form(
                  key: formkey,
                  child: Column(
                    children: <Widget>[
                      TextFieldContainer(
                        child: TextFormField(
                          autovalidate: false,
                          validator: (value) {
                            return _validators.isValidName(value)
                                ? _validators
                                    .validatorMsg("Please enter valid Name")
                                : null;
                          },
                          controller: nameController,
                          decoration: InputDecoration(
                              hintText: "Name",
                              icon: Icon(
                                Icons.person,
                                color: tPrimaryColor,
                              ),
                              border: InputBorder.none),
                        ),
                      ),
                      TextFieldContainer(
                        child: TextFormField(
                          autovalidate: false,
                          validator: (value) {
                            return _validators.isValidEmail(value)
                                ? null
                                : _validators.validatorMsg("Enter valid Email");
                          },
                          controller: emailController,
                          decoration: InputDecoration(
                              hintText: "Email",
                              icon: Icon(
                                Icons.mail,
                                color: tPrimaryColor,
                              ),
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
                                : _validators.validatorMsg("Weak Password");
                          },
                          controller: passController,
                          obscureText: passVisibility,
                          decoration: InputDecoration(
                              hintText: "Password",
                              icon: Icon(
                                Icons.lock,
                                color: tPrimaryColor,
                              ),
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    if (passVisibility) {
                                      passVisibility = false;
                                    } else {
                                      passVisibility = true;
                                    }
                                    if (passVisibilityColor == tPrimaryColor) {
                                      passVisibilityColor = Colors.brown;
                                    } else {
                                      passVisibilityColor = tPrimaryColor;
                                    }
                                  },
                                  child: Icon(
                                    Icons.visibility,
                                    color: passVisibilityColor,
                                  )),
                              border: InputBorder.none),
                        ),
                      ),
                    ],
                  ),
                ),

                // RoundedInputField(
                //   hintText: "Name",
                //   icon: Icons.person,
                //   onChanged: (value) {
                //     name = value;
                //   },
                // ),
                // RoundedInputField(
                //   hintText: "Email",
                //   icon: Icons.mail,
                //   onChanged: (value) {
                //     emailController.text = value;
                //   },
                // ),
                // RoundedInputField(
                //   hintText: "Password",
                //   icon: Icons.lock,
                //   onChanged: (value) {
                //     passController.text = value;
                //   },
                //   suffixIcon: Icons.visibility,
                // ),
                SizedBox(
                  height: 20,
                ),
                BlocListener<RegisterBloc, RegisterState>(
                  listener: (context, state) {
                    if (state is RegisterSuccesState) {
                      navigateToHomePage(context, state.user);
                    }
                  },
                  child: BlocBuilder<RegisterBloc, RegisterState>(
                      builder: (context, state) {
                    if (state is RegisterInitialState) {
                      return regInitialUI(context);
                    } else if (state is RegisterLoadingState) {
                      loading = true;
                      return regLoadingUI(context);
                    } else if (state is RegisterSuccesState) {
                      return Container();
                    } else if (state is RegisterFailureState) {
                      return regFailedUI();
                    }
                  }),
                ),
                /*Container(
                  width: size.width * 0.8,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: RaisedButton(
                        color: tPrimaryColor,
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                        onPressed: () {
                          print(emailController.text);
                          print(passController.text);
                          registerBloc.add(SignUpBtnPressedEvent(
                              email: emailController.text,
                              pass: passController.text));
                          //         email: emailController.text,
                          //         pass: passController.text));
                        },
                        child: Text(
                          "SIGNUP",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      )),
                ),*/
                // RoundedButton(
                //   press: () async {
                //     print(name);
                //     registerBloc.add(SignUpBtnPressedEvent(
                //         email: emailController.text,
                //         pass: passController.text));
                //   },
                //   bgcolor: tPrimaryColor,
                //   text: "SIGNUP",
                // ),
                SizedBox(
                  height: 15,
                ),
                AlreadyhaveAccountCheck(
                  login: false,
                  bcontext: context,
                  press: () {
                    navigateTopage(context, LoginPage());
                  },
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget regInitialUI(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print("******regInitialUI******");
    return Container(
      width: size.width * 0.8,
      height: size.height * 0.06,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: RaisedButton(
            color: tPrimaryColor,
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
            onPressed: () {
              formkey.currentState.validate();
              if (formkey.currentState.validate()) {
                registerBloc.add(SignUpBtnPressedEvent(
                    name: nameController.text,
                    email: emailController.text,
                    pass: passController.text));
                print(emailController.text);
                print(passController.text);
                // Map<String, String> userDataMap = {
                //   "name": nameController.text,
                //   "email": emailController.text,
                //   "pass": passController.text
                // };
                // userDataBase.uploaduserInfo(userDataMap);
              } else {
                print("Not Valid Info");
                warningMsg = "Provide valid information";
              }

              //         email: emailController.text,
              //         pass: passController.text));
            },
            child: Text(
              "SIGNUP",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          )),
    );
  }

  Widget regLoadingUI(BuildContext context) {
    print("******regLoadingUI******");
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.06,
      width: size.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: tPrimaryColor,
      ),
      child: SpinKitThreeBounce(
        color: Colors.black,
        size: 20,
      ),
    );
  }

  Widget regFailedUI() {
    print("******regFailedUI******");

    return Text("Registration Failed");
  }

  void navigateToHomePage(BuildContext context, FirebaseUser user) {
    print("******navigateToHomePage******");

    navigateTopage(context, HomePage(user: user));
  }

  void navigateToLoginPage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LoginPage();
    }));
  }
}
