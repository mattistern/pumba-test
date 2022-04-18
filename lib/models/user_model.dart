///enum of:
/// - male
/// - female
/// - other
enum Gender {
  male,
  female,
  other,
}

class UserModel {
  late final String firstName;
  late final String lastName;
  late final String email;
  late final Gender gender;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
  });

  UserModel.fromJson(Map<String, dynamic> jsonMap) {
    firstName = jsonMap['firstName'];
    lastName = jsonMap['lastName'];
    email = jsonMap['email'];
    gender = _stringToGender(jsonMap['gender'] as String);
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

  ///Creates a UserModel fron Json
  UserModel fromJsonToUser(Map<String, dynamic> jsonMap) {
    return UserModel(
      firstName: jsonMap['firstName'],
      lastName: jsonMap['lastName'],
      email: jsonMap['email'],
      gender: _stringToGender(jsonMap['gender'] as String),
    );
  }

  ///Creates a Json map
  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'gender': _genderToString(),
    };
  }

  ///Tranforms gender to string
  String _genderToString() {
    switch (gender) {
      case Gender.male:
        return 'male';
      case Gender.female:
        return 'female';
      case Gender.other:
        return 'other';

      default:
        return 'unknown';
    }
  }
}
