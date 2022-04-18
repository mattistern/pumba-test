import 'package:flutter/material.dart';

import 'package:pumba_test/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefProvider with ChangeNotifier {
  //The _IS_REGISTER String is a easy way to use a string globaly in the class.
  ///A String that show the status of the registration.
  final String _IS_REGISTER = 'isRegister';
  final String _NAME = 'firstName';

  late SharedPreferences prefs;

  late String _name;
  //This bool will tell us eventually if a registration have made from this device.
  late bool _isRegister;

  ///Initializing the property how checks if the user is allready registered.
  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
    _isRegister = prefs.getBool(_IS_REGISTER) ?? false;
    _name = prefs.getString(_NAME) as String;
  }

  ///A getter for the 'is register' (registration status) bool.
  bool get isRegister => _isRegister;

  ///A getter for fisrt name String.
  String get firstName => _name;

  ///Set the registration status.
  Future<void> setIsRegister(bool status) async {
    await prefs.setBool(_IS_REGISTER, status);
    _isRegister = prefs.getBool(_IS_REGISTER) ?? false;
  }

  Future<void> saveName(UserModel user) async {
    await prefs.setString(_NAME, '${user.firstName} ${user.lastName}');
    _name = prefs.getString(_NAME) as String;
  }
}
