import 'package:flutter/material.dart';

import '../../constant/constant.dart';

class TextInputField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isObscure;
  final IconData icon;
  const TextInputField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.isObscure = false,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: inputDecoration.copyWith(
        labelText: labelText,
        prefixIcon: Icon(icon),
      ),
      obscureText: isObscure,
    );
  }
}
