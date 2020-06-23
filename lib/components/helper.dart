import 'package:flutterchatdemo/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Helper{
  static Future<bool> saveUserLoggedInSP(bool isUserLoggedIn)async{
    SharedPreferences perf=await SharedPreferences.getInstance();
    return await perf.setBool(sharedUserLoggedInKey, isUserLoggedIn);
  }
  static Future<bool> saveUserNameInSP(String userName)async{
    SharedPreferences perf=await SharedPreferences.getInstance();
    return await perf.setString(sharedUserNameKey, userName);
  }
  static Future<bool> saveUserEmailInSP(String userEmail)async{
    SharedPreferences perf=await SharedPreferences.getInstance();
    return await perf.setString(sharedUserEmailKey, userEmail);
  }
   static Future<bool> getUserLoggedInSP()async{
    SharedPreferences perf=await SharedPreferences.getInstance();
    return perf.getBool(sharedUserLoggedInKey);
  }
  static Future<String> getUserNameInSP()async{
    SharedPreferences perf=await SharedPreferences.getInstance();
    return perf.getString(sharedUserNameKey);
  }
  static Future<String> getUserEmailInSP()async{
    SharedPreferences perf=await SharedPreferences.getInstance();
    return perf.getString(sharedUserEmailKey);
  }
}