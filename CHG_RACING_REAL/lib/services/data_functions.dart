import 'package:chg_racing/constants/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataFunctions {
  ///Set data in sharedpreference..............///
  Future<bool> setIntVariable(String key, dynamic value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, value);
    return true;
  }

  ///Set data in sharedpreference..............///
  Future<bool> setStringVariable(String key, dynamic value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
    return true;
  }

  ///Set data in sharedpreference..............///
  Future<bool> setBoolVariable(String key, dynamic value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
    return true;
  }

  ///Get data in sharedpreference..............///
  Future<int?> getIntVariable(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? response = prefs.getInt(key);
    return response;
  }

  ///Get data in sharedpreference..............///
  Future<String?> getStringVariable(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? response = prefs.getString(key);
    return response;
  }

  ///Get data in sharedpreference..............///
  Future<bool?> getBoolVariable(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? response = prefs.getBool(key);
    return response;
  }

  ///Clear  saved data in sharedpreference..............///
  Future<bool> clearSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool response = await prefs.clear();
    setBoolVariable("isLogin", false);

    if (response) {
      // resetGlobalVariables();
    }
    return response;
  }

  //// Save data in sharedpreference..............///
  Future<bool> saveData({bool isLogin = false}) async {
    await setBoolVariable("isLogin", isLogin);

    return true;
  }
}
