import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormWidget extends StatelessWidget {
  const CustomTextFormWidget({
    super.key,
    this.obscureText = false,
    required this.controller,
    this.enabled = true,
    this.inputFormatters,
    this.onChanged,
    this.suffixIcon,
    required this.label,
  });
  final bool obscureText;
  final TextEditingController controller;
  final bool enabled;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final Widget? suffixIcon;
  final Widget label;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscuringCharacter: '*',
      obscureText: obscureText,
      controller: controller,
      enabled: enabled,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      decoration: InputDecoration(
        label: label,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
