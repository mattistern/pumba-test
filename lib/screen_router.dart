import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pumba_test/providers/shared_pref_provider.dart';
import 'package:pumba_test/providers/user_provider.dart';
import 'package:pumba_test/screens/home_screen.dart';
import 'package:pumba_test/screens/waiting_screen.dart';
import 'package:pumba_test/screens/register_screen.dart';

class ScreenRouter extends StatelessWidget {
  const ScreenRouter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Here we manage the shared pref.
    //if the user is already registerd here we send him to the home screen.
    var _sharedPrefProvider =
        Provider.of<SharedPrefProvider>(context, listen: false);

    // Is Register
    return FutureBuilder(
      future: _sharedPrefProvider.init(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const WaitingScreen();

          case ConnectionState.done:
            if (_sharedPrefProvider.isRegister) {
              return HomeScreen();
            } else {
              return RegisterScreen();
            }

          default:
            return Scaffold(
              body: Container(),
            );
        }
      },
    );
  }
}
