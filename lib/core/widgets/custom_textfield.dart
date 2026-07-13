import 'package:flutter/material.dart';

import '../constants/app_strings.dart';


class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final bool isObscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String labelText;
  final TextInputType? keyboardInputType;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.isObscureText,
    this.suffixIcon,
    this.prefixIcon,
    required this.labelText,
    this.keyboardInputType,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.isObscureText,
      keyboardType: widget.keyboardInputType,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: TextStyle(fontFamily: AppStrings.poppins),

        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
