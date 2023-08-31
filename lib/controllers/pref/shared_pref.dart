
import 'package:flutter/material.dart';
import 'package:betweener_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../pages/auth/login_screen.dart';
import '../../pages/main/main_app_screen.dart';

enum PerfKeys { user, loggedIn }

class SharedPerfController {
  SharedPerfController._();

  late SharedPreferences _sharedPreferences;
  static SharedPerfController? _instance;

  factory SharedPerfController() {
    return _instance ??= SharedPerfController._();
  }

  Future<void> initPerf() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }


    Future<void> save(UserAuth userAuth) async {
      await _sharedPreferences.setString(
          PerfKeys.user.name, userAuthToJson(userAuth));
    }
    Future<bool> clean() async {
      return await _sharedPreferences.clear();
    }
    T? getKey<T>(String key) {
      if (_sharedPreferences.containsKey(key)) {
        return _sharedPreferences.get(key) as T;
      }
      return null;
    }

    bool get loggedIn =>
        _sharedPreferences.getBool(PerfKeys.loggedIn.name) ?? false;

    String get userAuth => _sharedPreferences.getString(PerfKeys.user.name)!;

  void checkLogin(context) async{
    if (_sharedPreferences.containsKey(PerfKeys.user.name)) {
      Navigator.pushReplacementNamed(context, MainAppScreen.id);
    } else {
      Navigator.pushReplacementNamed(context, LoginScreen.id);
    }}
  }
