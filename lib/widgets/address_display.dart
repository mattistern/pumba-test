import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pumba_test/screens/waiting_screen.dart';

import 'package:pumba_test/utils/user_location.dart';

//This widget isn't done and not working good!!!
class AddressDisplay extends StatelessWidget {
  final Position position;

  const AddressDisplay({
    Key? key,
    required this.position,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: UserLocation.getAddressFronCords(position),
      builder: (
        context,
        AsyncSnapshot<Object> snapshot,
      ) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return WaitingScreen();

          case ConnectionState.done:
            return Column(
              children: [
                Text(snapshot.data.toString()),
                Text(position.latitude.toString()),
                Text(position.altitude.toString()),
              ],
            );
          default:
            return Text('something went wrong');
        }
      },
    );
  }
}
