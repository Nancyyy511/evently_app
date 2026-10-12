import 'package:flutter/material.dart';
import 'package:evently_app/theme/app_color.dart';

/// 32 x 32 rounded-square back button shared across screens.
///
/// [onTap] is required so each screen keeps its own navigation logic.
/// [backgroundColor] and [borderColor] override the theme-based defaults
/// for screens that need a different look in both themes.
class CustomBackButton extends StatelessWidget {
  final VoidCallback onTap;
  final Color? backgroundColor;
  final Color? borderColor;

  const CustomBackButton({
    super.key,
    required this.onTap,
    this.backgroundColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color:
              backgroundColor ??
              (isDark ? AppColors.darkBgColor : AppColors.white),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isDark ? AppColors.mainColorlight : AppColors.white,
          ),
        ),
        child: const Icon(
          Icons.arrow_back_ios_new,
          size: 14,
          color: AppColors.mainColorlight,
        ),
      ),
    );
  }
}
