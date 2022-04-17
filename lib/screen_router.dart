import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pumba_test/providers/shared_pref_provider.dart';
import 'package:pumba_test/screens/home_screen.dart';
import 'package:pumba_test/screens/waiting_screen.dart';
import 'package:pumba_test/screens/register_screen.dart';

class ScreenRouter extends StatelessWidget {
  const ScreenRouter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var sharedPrefProvider =
        Provider.of<SharedPrefProvider>(context, listen: false);
    // Is Register
    return FutureBuilder(
      future: sharedPrefProvider.init(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const WaitingScreen();

          case ConnectionState.done:
            return sharedPrefProvider.isRegister
                ? const HomeScreen()
                : const RegisterScreen();
          default:
            return Scaffold(
              body: Container(),
            );
        }
      },
    );
  }
}
