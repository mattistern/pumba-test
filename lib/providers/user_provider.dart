import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:pumba_test/models/user_model.dart';
import 'package:pumba_test/screens/waiting_screen.dart';

class UserProvider with ChangeNotifier {
  var _isLoading = false;
  late final UserModel _userModel;
  late final String userId;

  UserModel get userModel => _userModel;

  bool get isLoading => _isLoading;

  ///Rgister the user in Firebasa Firestore.
  ///
  ///We have a bool property twice, start and end.
  ///The bool is called 'isLoading' with notifyListeners().
  Future<String> registerUser(UserModel userModel) async {
    _isLoading = true;
    notifyListeners();

    try {
      var response = await FirebaseFirestore.instance
          .collection('users/')
          .add(userModel.toJson());

      _userModel = userModel;

      _isLoading = false;
      notifyListeners();
      return response.id;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return '';
    }
  }

  Future<void> getUserData(String userId) async {
    try {
      var response = await FirebaseFirestore.instance
          .collection('users/')
          .doc(userId)
          .get();

      _userModel = UserModel.fromJson(response.data()!);
      response.data()!.forEach(
        (key, value) {
          print('$key :: $value');
        },
      );
    } catch (e) {
      print('userProvider, getUserData error: $e');
    }
  }

  // Future<void> getUserFromDB() async {
  //   var aaa = await FirebaseFirestore.instance;
  //   var url = Uri.parse(aaa.toString());
  //   try {
  //     final response = await http.get(url);
  //     print(response.body);
  //   } catch (error) {
  //     print(error);
  //   }
  // }

  // ///Creates a UserModel fron Json
  // UserModel fromJsonToUser(Map<String, dynamic> jsonMap) {
  //   return UserModel(
  //     firstName: jsonMap['firstName'],
  //     lastName: jsonMap['lastName'],
  //     email: jsonMap['email'],
  //     gender: _stringToGender(jsonMap['gender'] as String),
  //   );
  // }

  // ///Tranforms String to Gender
  // Gender _stringToGender(String genderString) {
  //   switch (genderString) {
  //     case 'male':
  //       return Gender.male;
  //     case 'female':
  //       return Gender.female;
  //     case 'other':
  //       return Gender.other;

  //     default:
  //       return Gender.other;
  //   }
  // }
}
