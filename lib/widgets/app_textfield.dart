import 'package:flutter/material.dart';

import '../theme/colors.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    this.initialValue,
    this.label,
    required this.hinText,
    this.onChanged,
    this.enabled,
    this.suffixIcon,
    this.validator,
    this.keyboardType,
    this.obscureText = false,
    this.maxLines = 1,
    this.textInputAction,
    Key? key,
  }) : super(key: key);
  final String? initialValue;
  final String? label;
  final String hinText;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool? enabled;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int? maxLines;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      obscureText: obscureText,
      validator: validator,
      keyboardType: keyboardType,
      initialValue: initialValue,
      enabled: enabled,
      maxLines: maxLines,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        labelText: label,
        isDense: false,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        filled: true,
        fillColor: AppColors.fillerColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.fillerColor),
          borderRadius: BorderRadius.circular(30.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.oliveGreen),
          borderRadius: BorderRadius.circular(30.0),
        ),
        hintText: hinText,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
