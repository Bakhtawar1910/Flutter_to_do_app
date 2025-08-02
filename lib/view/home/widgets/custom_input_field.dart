import 'package:flutter/material.dart';
import 'package:todoapp/constant/colors.dart';

class CustomInputField extends StatelessWidget {
  final String hintText;
  final bool isMultiLine;
  final bool readOnly;
  final VoidCallback? onTap;
  final IconData? suffixIcon;
  final TextEditingController? controller;

  const CustomInputField({
    super.key,
    required this.hintText,
    this.isMultiLine = false,
    this.readOnly = false,
    this.onTap,
    this.suffixIcon,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      minLines: isMultiLine ? 3 : 1,
      maxLines: isMultiLine ? 5 : 1,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        hintText: hintText,
        hintStyle: const TextStyle(color: AppColors.grey),
        suffixIcon: suffixIcon != null
            ? Icon(suffixIcon, color: AppColors.primary)
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.grey),
          borderRadius: BorderRadius.circular(13),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
          borderRadius: BorderRadius.circular(13),
        ),
      ),
    );
  }
}
