import 'package:flutter/material.dart';
import 'package:evently_app/theme/app_color.dart';
import 'package:evently_app/common/App_text_styles.dart';

/// Language selector shared by Home and Profile.
///
/// - Default (Profile "Language" row): a chevron; tapping switches language.
/// - [CustomLanguageToggle.compact] (Home header): a filled "EN" / "AR"
///   badge that flips between the two languages.
///
/// Onboarding uses its own selector design (see onboarding_first_page.dart).
class CustomLanguageToggle extends StatelessWidget {
  final String languageCode;
  final ValueChanged<String> onLanguageChanged;
  final bool _compact;

  const CustomLanguageToggle({
    super.key,
    required this.languageCode,
    required this.onLanguageChanged,
  }) : _compact = false;

  const CustomLanguageToggle.compact({
    super.key,
    required this.languageCode,
    required this.onLanguageChanged,
  }) : _compact = true;

  void _toggle() {
    onLanguageChanged(languageCode == 'en' ? 'ar' : 'en');
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: _toggle,
      child: _compact ? _buildBadge(isDark) : _buildChevron(isDark),
    );
  }

  Widget _buildBadge(bool isDark) {
    return Container(
      width: 36,
      height: 36,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isDark ? AppColors.mainColorDark : AppColors.mainColorlight,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        languageCode.toUpperCase(),
        style: AppTextStyles.styleW700S14(color: AppColors.white),
      ),
    );
  }

  Widget _buildChevron(bool isDark) {
    // arrow_forward_ios mirrors automatically in RTL (Arabic).
    return Icon(
      Icons.arrow_forward_ios,
      size: 20,
      color: isDark ? AppColors.mainColorDark : AppColors.mainColorlight,
    );
  }
}
