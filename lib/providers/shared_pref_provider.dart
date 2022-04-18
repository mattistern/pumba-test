import 'package:flutter/material.dart';

import 'package:pumba_test/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefProvider with ChangeNotifier {
  //The _IS_REGISTER String is a easy way to use a string globaly in the class.
  ///A String that show the status of the registration.
  final String _IS_REGISTER = 'isRegister';
  final String _USER_ID = 'userId';

  late SharedPreferences prefs;

  late String _userId;
  //This bool will tell us eventually if a registration have made from this device.
  late bool _isRegister;

  ///Initializing the property how checks if the user is allready registered.
  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
    _isRegister = prefs.getBool(_IS_REGISTER) ?? false;
    _userId = prefs.getString(_USER_ID) ?? '';
  }

  ///A getter for the 'is register' (registration status) bool.
  bool get isRegister => _isRegister;

  ///A getter for fisrt name String.
  String get userId => _userId;

  ///Set the registration status.
  Future<void> setIsRegister(bool status) async {
    await prefs.setBool(_IS_REGISTER, status);
    _isRegister = prefs.getBool(_IS_REGISTER) ?? false;
  }

  Future<void> setUserId(String userId) async {
    await prefs.setString(_USER_ID, userId);
    _userId = prefs.getString(_USER_ID) as String;
  }
}
