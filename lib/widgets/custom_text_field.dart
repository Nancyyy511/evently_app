import 'package:flutter/material.dart';

import 'package:evently_app/common/App_text_styles.dart';
import 'package:evently_app/theme/app_color.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final bool expands;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.validator,
    this.onChanged,
    this.expands = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // App error color reads better on dark (6.06:1 vs 5.13:1); on white,
    // Colors.red keeps the higher contrast (3.68:1 vs 3.12:1)
    final errorColor = isDark ? AppColors.errorColor : Colors.red;

    return TextFormField(
      controller: controller,
      expands: expands,
      maxLines: expands ? null : 1,
      minLines: expands ? null : 1,
      textAlignVertical: TextAlignVertical.top,

      keyboardType: keyboardType,
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,

        // Secondary color so the hint is distinct from typed text
        hintStyle: AppTextStyles.styleW400S14(
          color: isDark ? AppColors.darkSecTextColor : Colors.grey,
        ),

        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,

        filled: true,

        fillColor: isDark ? AppColors.darkBgColor : AppColors.white,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),

        // Normal border
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: isDark ? AppColors.mainColorDark : Colors.grey.shade200,
            width: 1,
          ),
        ),

        // Focused border
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: isDark ? AppColors.mainColorDark : AppColors.mainColorlight,
            width: 1.5,
          ),
        ),

        // Error border
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: errorColor, width: 1),
        ),

        // Focused + error border
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: errorColor, width: 1.5),
        ),

        // Error message
        errorStyle: TextStyle(color: errorColor, fontSize: 12),
      ),
      onChanged: onChanged,
    );
  }
}
