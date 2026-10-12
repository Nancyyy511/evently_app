import 'package:flutter/material.dart';

import 'package:evently_app/common/App_text_styles.dart';
import 'package:evently_app/theme/app_color.dart';

// Inline error box shown inside the auth screens (instead of a SnackBar)
class AuthErrorMessage extends StatelessWidget {
  final String message;

  const AuthErrorMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Same error colors as CustomTextField so both look consistent
    final errorColor = isDark ? AppColors.errorColor : Colors.red;

    // liveRegion lets screen readers announce the error when it appears
    return Semantics(
      liveRegion: true,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: errorColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: errorColor),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.error_outline, color: errorColor, size: 20),
            const SizedBox(width: 8),
            // Expanded lets long messages wrap onto several lines
            Expanded(
              child: Text(
                message,
                style: AppTextStyles.styleW500S14(color: errorColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
