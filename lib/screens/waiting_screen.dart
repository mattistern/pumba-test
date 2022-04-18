import 'package:flutter/material.dart';

class WaitingScreen extends StatelessWidget {
  ///Loading Screen.
  const WaitingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
