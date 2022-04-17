import 'package:flutter/material.dart';

class HomeScreenButton extends StatelessWidget {
  final String title;
  final Function() onPressed;

  const HomeScreenButton({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(title),
    );
  }
}
