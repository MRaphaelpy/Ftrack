// Arquivo: rounded_text_field.dart
import 'package:flutter/material.dart';

class RoundedTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validator;

  const RoundedTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          labelText: labelText,
          contentPadding: const EdgeInsets.all(16.0),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
