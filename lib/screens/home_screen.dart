import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

import 'package:pumba_test/models/user_model.dart';
import 'package:pumba_test/screens/waiting_screen.dart';
import 'package:pumba_test/utils/notification_service.dart';
import 'package:pumba_test/utils/permissions.dart';
import 'package:pumba_test/utils/user_location.dart';
import 'package:pumba_test/widgets/address_display.dart';
import 'package:pumba_test/widgets/home_screen_button.dart';
import 'package:pumba_test/providers/user_provider.dart';
import 'package:pumba_test/widgets/user_name_disply.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var startIsPressed = false;

  void startPress() {
    setState(() {
      startIsPressed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Punba Test'),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: Future.wait([
            NotificationService.init(),
            Permissions.checkPermissionLocation(),
            UserLocation.determinePosition(),
            userProvider.init(),
          ]),
          builder: (
            context,
            AsyncSnapshot<List<Object?>> snapshot,
          ) {
            //Show the widget duo to the snapshot.connectionState
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const WaitingScreen();

              case ConnectionState.done:
                if (snapshot.hasData) {
                  bool locationPermissionGranted = snapshot.data![1] as bool;
                  return Container(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        startIsPressed
                            ? Text(
                                'The notification will appear at ${DateFormat.Hm().format(DateTime.now().add(Duration(minutes: 2)))}')
                            : Text('userProvider.userModel.firstName'),
                        locationPermissionGranted
                            ? Text(snapshot.data![2].toString())
                            // AddressDisplay(
                            //     position: snapshot.data![2] as Position)
                            : HomeScreenButton(
                                title: 'Allow Location',
                                onPressed: () async {
                                  await Permissions.askPermissionLocation();
                                  setState(() {});
                                },
                              ),
                        SizedBox(height: 30),
                        HomeScreenButton(
                          title: 'Start',
                          onPressed: () {
                            NotificationService.showScheduledNotification(
                              id: 1,
                              title: 'Pumba',
                              body: 'Hi',
                            );
                            startPress();
                          },
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Center(
                    child: Text('Something went wrong'),
                  );
                }
              default:
                return Container();
            }
          },
        ),
      ),
    );
  }
}
