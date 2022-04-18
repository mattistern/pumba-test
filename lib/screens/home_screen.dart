import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

import 'package:pumba_test/models/user_model.dart';
import 'package:pumba_test/providers/shared_pref_provider.dart';
import 'package:pumba_test/screens/waiting_screen.dart';
import 'package:pumba_test/utils/notification_service.dart';
import 'package:pumba_test/utils/permissions.dart';
import 'package:pumba_test/utils/user_location.dart';
import 'package:pumba_test/widgets/address_display.dart';
import 'package:pumba_test/widgets/home_content.dart';
import 'package:pumba_test/widgets/home_screen_button.dart';
import 'package:pumba_test/providers/user_provider.dart';
import 'package:pumba_test/widgets/user_name_display.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // Provider.of<UserProvider>(context, listen: false).getUserFromDB();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    var sharedPrefProvider = Provider.of<SharedPrefProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Punba Test'),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: Future.wait([
            NotificationService.init(),
            // Permissions.checkPermissionLocationGranted(),
            Geolocator.checkPermission(),
            Permissions.askPermissionNotification(),
            userProvider.getUserData(sharedPrefProvider.userId),
          ]),
          builder: (
            context,
            AsyncSnapshot<List<Object?>> snapshot,
          ) {
            //Show the widget duo to the snapshot.connectionState
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(
                  child: WaitingScreen(),
                );

              case ConnectionState.done:
                return HomeContent(data: snapshot.data!);

              default:
                return Container();
            }
          },
        ),
      ),
    );
  }
}
