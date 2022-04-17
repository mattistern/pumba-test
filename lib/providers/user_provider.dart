import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:pumba_test/models/user_model.dart';
import 'package:pumba_test/screens/waiting_screen.dart';

class UserProvider with ChangeNotifier {
  var _isLoading = false;
  late final UserModel _userModel;
  late final String userId;

  UserModel get userModel => _userModel;

  bool get isLoading => _isLoading;

  Future<void> init() async {
    var response =
        await FirebaseFirestore.instance.collection('users/').doc().get();

    if (response.exists) {
      var user = response; //.data();
      print(user);
      print(userId);
      print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
      //print(user.toString());
    }

    //print(userId.toString());
    // _userModel = fromJsonToUser(user as Map<String, dynamic>);
  }

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

    setUserId(response.id);

    _userModel = fromJsonToUser(response.parent.parameters);

    _isLoading = false;
    notifyListeners();
  }

  void setUserId(String uid) {
    userId = uid;
  }
  // void setGlobalUser(
  //   String firstName,
  //   String lastName,
  //   String email,
  //   Gender gender,
  // ) {
  //   _userModel.firstName = firstName;
  //   _userModel.lastName = lastName;
  //   _userModel.email = email;
  //   _userModel.gender = gender;

  //   notifyListeners();
  // }

  ///Creates a UserModel fron Json
  UserModel fromJsonToUser(Map<String, dynamic> jsonMap) {
    return UserModel(
      firstName: jsonMap['firstName'],
      lastName: jsonMap['lastName'],
      email: jsonMap['email'],
      gender: _stringToGender(jsonMap['gender'] as String),
    );
  }

  ///Tranforms String to Gender
  Gender _stringToGender(String genderString) {
    switch (genderString) {
      case 'male':
        return Gender.male;
      case 'female':
        return Gender.female;
      case 'other':
        return Gender.other;

      default:
        return Gender.other;
    }
  }
}
