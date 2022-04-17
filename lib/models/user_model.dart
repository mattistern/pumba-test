enum Gender {
  male,
  female,
  other,
}

class UserModel {
  final String firstName;
  final String lastName;
  final String email;
  final Gender gender;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'gender': _genderToString(),
    };
  }

  /// tranform gender to string
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
