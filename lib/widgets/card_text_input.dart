import 'package:flutter/material.dart';

//This widget build the text input and manage UI for it.
class CardTextInput extends StatelessWidget {
  final TextEditingController controller;
  final String lableText;
  final String? Function(String?)? validator;
  final TextInputType? textInputType;

  const CardTextInput({
    Key? key,
    required this.controller,
    required this.lableText,
    required this.validator,
    this.textInputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: lableText,
          ),
          keyboardType: textInputType,
          controller: controller,
          validator: validator,
        ),
      ),
    );
  }
}
