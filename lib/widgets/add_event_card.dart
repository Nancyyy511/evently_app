import 'package:flutter/material.dart';
import 'package:evently_app/common/App_text_styles.dart';
import 'package:evently_app/theme/app_color.dart';

class AddEventCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String trailingText;
  final VoidCallback onTap;
  //final Color? titleColor;

  const AddEventCard({
    super.key,
    required this.icon,
    required this.title,
    required this.trailingText,
    required this.onTap,
    //this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final textColor = isDark
        ? AppColors.darkTextColor
        : AppColors.lightTextColor;

    final linkColor = isDark
        ? AppColors.mainColorDark
        : AppColors.mainColorlight;

    return Row(
      children: [
        Icon(icon, size: 16, color: linkColor),

        const SizedBox(width: 6),

        Expanded(
          child: Text(
            title,
            style: AppTextStyles.styleW400S14(color: textColor),
          ),
        ),

        TextButton(
          onPressed: onTap,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            foregroundColor: linkColor,
          ),
          child: Text(
            trailingText,
            style: AppTextStyles.styleW400S14(color: linkColor).copyWith(
              decoration: TextDecoration.underline,
              decorationColor: linkColor,
            ),
          ),
        ),
      ],
    );
  }
}
