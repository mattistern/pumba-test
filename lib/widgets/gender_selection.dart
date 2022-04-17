import 'package:flutter/material.dart';

import '../models/user_model.dart';

class GenderSelection extends StatelessWidget {
  final Gender selectedGender;
  final Function(Gender gender) setGenderFn;

  const GenderSelection({
    Key? key,
    required this.selectedGender,
    required this.setGenderFn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Build the gender card and icon, check if the card need to be selected or not.
    Widget _buildGenderCard({
      required IconData iconData,
      required Gender gender,
    }) {
      return InkWell(
        onTap: () => setGenderFn(gender),
        child: Card(
          child: Icon(
            iconData,
            size: 50,
            color: gender == selectedGender ? Colors.blue : Colors.black,
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildGenderCard(
          iconData: Icons.male_outlined,
          gender: Gender.male,
        ),
        _buildGenderCard(
          iconData: Icons.female_outlined,
          gender: Gender.female,
        ),
        _buildGenderCard(
          iconData: Icons.person_outline_sharp,
          gender: Gender.other,
        ),
      ],
    );
  }
}
