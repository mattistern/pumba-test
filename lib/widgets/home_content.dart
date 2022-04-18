import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:notification_permissions/notification_permissions.dart' as np;
// import 'package:permission_handler/permission_handler.dart';
import 'package:pumba_test/utils/user_location.dart';
import 'package:pumba_test/widgets/user_name_display.dart';

import '../utils/notification_service.dart';
import '../utils/permissions.dart';
import 'home_screen_button.dart';

class HomeContent extends StatefulWidget {
  final List<Object?> data;
  const HomeContent({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  Timer? _timer;
  LocationPermission? _locationPermissionIsGranted;
  var _startIsPressed = false;
  Position? _position;

  void startPress() {
    setState(() {
      _startIsPressed = !_startIsPressed;
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(
      Duration(minutes: 2),
      (timer) {
        startPress();
      },
    );
  }

  Widget getLocation() {
    return FutureBuilder(
      future: UserLocation.determinePosition(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: const LinearProgressIndicator(),
            );

          case ConnectionState.done:
            _position = snapshot.data as Position?;
            return Text(_position.toString());
          default:
            return Container();
        }
      },
    );
  }

  @override
  void initState() {
    _locationPermissionIsGranted = (widget.data[1] as LocationPermission);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(
        'locationPermissionIsGranted -- build -- $_locationPermissionIsGranted');
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _startIsPressed
              ? Text('The notification will appear at ${DateFormat.Hm().format(
                  DateTime.now().add(const Duration(minutes: 2)),
                )}')
              : const UserNameDisplay(),
          _locationPermissionIsGranted != null &&
                  _locationPermissionIsGranted! != LocationPermission.denied
              ? _position == null
                  ? getLocation()
                  : Text(_position.toString())
              : HomeScreenButton(
                  title: 'Allow Location',
                  onPressed: () async {
                    await UserLocation.determinePosition();
                    _locationPermissionIsGranted =
                        await Geolocator.checkPermission();
                    // await Permissions.checkPermissionLocationGranted();

                    print(
                        'locationPermissionIsGranted -- $_locationPermissionIsGranted');
                    setState(() {});
                  },
                ),
          const SizedBox(height: 30),
          HomeScreenButton(
            title: 'Start',
            onPressed: () async {
              _startTimer();
              var status = await Permissions.askPermissionNotification();
              if (status.index == np.PermissionStatus.granted.index) {
                NotificationService.showScheduledNotification(
                  id: 1,
                  title: 'Pumba_test',
                  body: 'Hi',
                );
                startPress();
              }
            },
          ),
        ],
      ),
    );
  }
}
