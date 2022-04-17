import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:pumba_test/models/user_model.dart';
import 'package:pumba_test/screens/waiting_screen.dart';

class UserProvider with ChangeNotifier {
  var _isLoading = false;
  late final UserModel _userModel;

  UserModel get userModel => _userModel;

  bool get isLoading => _isLoading;

  ///Rgister the user in Firebasa Firestore.
  ///
  ///We have a bool property twice, start and end.
  ///The bool is called 'isLoading' with notifyListeners().
  Future<void> registerUser(UserModel userModel) async {
    _isLoading = true;
    notifyListeners();

    var response = await FirebaseFirestore.instance
        .collection('users/')
        .add(userModel.toJson());

    _isLoading = false;
    notifyListeners();
  }

  void setGlobalUser(
    String firstName,
    String lastName,
    String email,
    Gender gender,
  ) {
    _userModel.firstName = firstName;
    _userModel.lastName = lastName;
    _userModel.email = email;
    _userModel.gender = gender;

    notifyListeners();
  }
}
