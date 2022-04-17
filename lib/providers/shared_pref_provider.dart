import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefProvider with ChangeNotifier {
  //The _IS_REGISTER String is a easy way to use a string globaly in the class.
  ///A String that show the status of the registration.
  final String _IS_REGISTER = 'isRegister';

  late SharedPreferences prefs;
  //This bool will tell us eventually if a registration have made from this device.
  late bool _isRegister;

  ///Initializing the property how checks if the user is allready registered.
  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
    _isRegister = prefs.getBool(_IS_REGISTER) ?? false;
  }

  ///A getter for the 'is register' (registration status) bool.
  bool get isRegister => _isRegister;

  ///Set the registration status.
  Future<void> setIsRegister(bool status) async {
    await prefs.setBool(_IS_REGISTER, status);
    _isRegister = prefs.getBool(_IS_REGISTER) ?? false;
  }
}
