import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pumba_test/providers/shared_pref_provider.dart';
import 'package:pumba_test/screens/waiting_screen.dart';

import '../providers/user_provider.dart';

//this widget don't work good
class UserNameDisplay extends StatelessWidget {
  const UserNameDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userModel = Provider.of<UserProvider>(context, listen: false).userModel;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        'Hello ${userModel.firstName} ${userModel.lastName}, how are you today?',
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 20,
        ),
      ),
    );
  }
}
