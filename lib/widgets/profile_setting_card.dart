import 'package:flutter/material.dart';
import 'package:evently_app/common/App_text_styles.dart';
import 'package:evently_app/theme/app_color.dart';

class ProfileSettingCard extends StatelessWidget {
  static const String routeName = '/profileScreen';

  //final IconData icon;
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? titleColor;

  const ProfileSettingCard({
    super.key,
    //required this.icon,
    required this.title,
    this.trailing,
    this.onTap,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final textColor =
        titleColor ??
        (isDark ? AppColors.darkTextColor : AppColors.lightTextColor);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.mainColorDark.withValues(alpha: 0.06)
            : AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: isDark
            ? Border.all(color: AppColors.mainColorDark.withValues(alpha: 0.4))
            : null,
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        title: Text(title, style: AppTextStyles.styleW500S14(color: textColor)),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }
}
