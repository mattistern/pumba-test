import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pumba_test/screens/waiting_screen.dart';

import '../providers/user_provider.dart';

class UserNameDisplay extends StatelessWidget {
  const UserNameDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context, listen: false);

    return FutureBuilder(
      future: userProvider.init(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );

          case ConnectionState.done:
            return Container(child: Text(userProvider.userModel.firstName));
          default:
            return Container();
        }
      },
    );
  }
}
