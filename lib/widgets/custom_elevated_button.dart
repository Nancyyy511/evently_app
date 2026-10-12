import 'package:flutter/material.dart';

import 'package:evently_app/common/App_text_styles.dart';
import 'package:evently_app/theme/app_color.dart';

class CustomElevatedButton extends StatelessWidget {
  final String? text;
  final Widget? child;
  final VoidCallback? onPressed;
  final double width;
  final double height;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double borderRadius;
  final TextStyle? textStyle;
  final bool isLoading;

  const CustomElevatedButton({
    super.key,
    this.text,
    this.child,
    required this.onPressed,
    this.width = double.infinity,
    this.height = 48,
    this.backgroundColor,
    this.foregroundColor,
    this.borderRadius = 16,
    this.textStyle,
    this.isLoading = false,
  }) : assert(text != null || child != null, 'Provide either text or child');

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              backgroundColor ??
              (isDark ? AppColors.mainColorDark : AppColors.mainColorlight),
          foregroundColor: foregroundColor ?? AppColors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        // Disabled while loading to prevent duplicate taps
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  // White on the default main-color button; custom-colored
                  // buttons (e.g. Google) keep the theme's default color
                  color: foregroundColor == null ? AppColors.white : null,
                ),
              )
            : child ??
                  Text(
                    text!,
                    style:
                        textStyle ??
                        AppTextStyles.styleW500S20(color: AppColors.white),
                  ),
      ),
    );
  }
}
