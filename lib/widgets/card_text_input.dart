import 'package:flutter/material.dart';

class CardTextInput extends StatelessWidget {
  final TextEditingController controller;
  final String lableText;
  final String? Function(String?)? validator;

  const CardTextInput({
    Key? key,
    required this.controller,
    required this.lableText,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 10.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: lableText,
          ),
          controller: controller,
          validator: validator,
        ),
      ),
    );
  }
}
