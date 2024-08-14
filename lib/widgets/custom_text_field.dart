import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final Function(String) validator;
  final Function(String) onSaved;
  final bool obscureText;

  CustomTextField({
    @required this.labelText,
    @required this.validator,
    @required this.onSaved,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(labelText: labelText),
      obscureText: obscureText,
      validator: validator,
      onSaved: onSaved,
    );
  }
}