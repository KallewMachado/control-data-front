import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CustomTextFormWidget extends StatefulWidget {
  const CustomTextFormWidget({
    super.key,
    this.obscureText = false,
    required this.controller,
    this.enabled = true,
    this.inputFormatters,
    this.onChanged,
    this.suffixIcon,
    required this.label,
    this.isDate = false,
    this.readOnly = false,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    this.validator,
  });

  final bool obscureText;
  final TextEditingController controller;
  final bool enabled;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final Widget? suffixIcon;
  final Widget label;
  final bool isDate;
  final bool readOnly;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;

  @override
  State<CustomTextFormWidget> createState() => _CustomTextFormWidgetState();
}

class _CustomTextFormWidgetState extends State<CustomTextFormWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: widget.textInputAction,
      keyboardType: widget.keyboardType,
      obscuringCharacter: '*',
      obscureText: widget.obscureText,
      controller: widget.controller,
      enabled: widget.enabled,
      inputFormatters: widget.inputFormatters,
      onChanged: widget.onChanged,
      readOnly: widget.readOnly,
      validator: widget.validator,
      decoration: InputDecoration(
        label: widget.label,
        suffixIcon: widget.suffixIcon,
      ),
      onTap: () async {
        if (widget.isDate) {
          DateTime dateNow = DateTime.now();

          late DateTime? pickedDate;

          pickedDate = await showDatePicker(
            locale: const Locale('pt'),
            context: context,
            initialDate: dateNow,
            firstDate: DateTime(1900),
            lastDate: DateTime(2040),
          );

          if (pickedDate != null) {
            setState(() {
              widget.controller.text =
                  DateFormat('yyyy/MM/dd').format(pickedDate!);
            });
          }
        }
      },
    );
  }
}
