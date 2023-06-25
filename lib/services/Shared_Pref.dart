import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  //keys
  static String user = "USERTYPE";

  static Future<bool?> saveUserTypeStatus(String userType) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    try{
      await sf.setString(user, userType) ;
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<String?> getUserTypeStatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(user);
  }

}