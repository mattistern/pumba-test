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
    var sharedPrefProvider =
        Provider.of<SharedPrefProvider>(context, listen: false);

    return FutureBuilder(
      future: sharedPrefProvider.init(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(),
            );

          case ConnectionState.done:
            return Container(
              child: Text(
                  'Hello ${sharedPrefProvider.firstName}, how are you today?'),
            );
          default:
            return Container();
        }
      },
    );
  }
}
