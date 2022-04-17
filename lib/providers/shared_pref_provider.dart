import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefProvider with ChangeNotifier {
  final String _IS_REGISTER = 'isRegister';

  late SharedPreferences prefs;
  late bool _isRegister;

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
    _isRegister = prefs.getBool(_IS_REGISTER) ?? false;
  }

  bool get isRegister => _isRegister;

  Future<void> setIsRegister(bool status) async {
    await prefs.setBool(_IS_REGISTER, status);
    _isRegister = prefs.getBool(_IS_REGISTER) ?? false;
  }
}
