import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:pumba_test/screens/waiting_screen.dart';
import 'package:pumba_test/utils/notification_service.dart';
import 'package:pumba_test/utils/permissions.dart';
import 'package:pumba_test/widgets/home_screen_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Punba Test'),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: Future.wait([
            NotificationService.init(),
            Permissions.checkPermissionLocation(),
          ]),
          builder: (
            context,
            AsyncSnapshot<List<Object?>> snapshot,
          ) {
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
                        locationPermissionGranted
                            ? Text('Hiiiiii')
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
                              body: 'Hi my name is homo',
                            );
                          },
                        ),
                      ],
                    ),
                  );
                } else {
                  print(snapshot.data);
                  return const Center(
                    child: Text('Somthing went wrong'),
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
