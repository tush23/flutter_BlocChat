import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepo {
  FirebaseAuth firebaseAuth;
  GoogleSignIn _googleSignIn;
  UserRepo() {
    this.firebaseAuth = FirebaseAuth.instance;
    this._googleSignIn = GoogleSignIn();
  }
  Future<FirebaseUser> createUser(String email, String pass) async {
    try {
      var result = await firebaseAuth.createUserWithEmailAndPassword(
          email: email.trim(), password: pass.trim());
      return result.user;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<FirebaseUser> signInwithEmailPass(String email, String pass) async {
    var result = await firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(), password: pass.trim());
    return result.user;
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  Future<bool> isSignIn() async {
    var currentUser = await firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<FirebaseUser> getCurrentUser() async {
    return await firebaseAuth.currentUser();
  }

  Future<FirebaseUser> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential authCredential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
    await firebaseAuth.signInWithCredential(authCredential);
    return firebaseAuth.currentUser();
  }
  Future resetPass(String email)async{
    try{
      return await firebaseAuth.sendPasswordResetEmail(email: email);
    }catch(e){
      print(e.toString());
    }
  }
}
