import 'package:evently_app/common/App_text_styles.dart';
import 'package:evently_app/common/app_strings.dart';
import 'package:evently_app/onboarding/onbarding_model.dart';
import 'package:evently_app/theme/app_color.dart';
import 'package:flutter/material.dart';

class OnboardingFirstPage extends StatelessWidget {
  final OnboardingModel model;
  final ThemeMode selectedTheme;
  final ValueChanged<ThemeMode> onThemeChanged;
  final String languageCode;
  final ValueChanged<String> onLanguageChanged;

  const OnboardingFirstPage({
    super.key,
    required this.model,
    required this.selectedTheme,
    required this.onThemeChanged,
    required this.languageCode,
    required this.onLanguageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Text colors
    final Color titleColor = isDark
        ? AppColors.darkTextColor
        : AppColors.lightTextColor;

    final Color descriptionColor = isDark
        ? AppColors.darkSecTextColor
        : AppColors.lightSecTextColor;

    // Accent color for Language and Theme labels
    final Color accentColor = isDark
        ? AppColors.darkTextColor
        : AppColors.mainColorlight;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Onboarding Image
        Expanded(
          child: Center(
            child: Image.asset(model.imageFor(context), fit: BoxFit.contain),
          ),
        ),

        const SizedBox(height: 24),

        // Title
        Text(
          model.titleFor(context),
          style: AppTextStyles.styleW700S20(color: titleColor),
        ),

        const SizedBox(height: 12),

        // Description
        Text(
          model.descriptionFor(context),
          style: AppTextStyles.styleW400S14(
            color: descriptionColor,
          ).copyWith(height: 1.5),
        ),

        const SizedBox(height: 24),

        // Language
        _buildSelectionRow(
          title: strings.language,
          titleColor: accentColor,
          toggle: _ToggleSwitch(
            children: [
              _ToggleItem(
                width: 82,
                isSelected: languageCode == 'en',
                onTap: () => onLanguageChanged('en'),
                builder: (color) => Text(
                  strings.english,
                  style: AppTextStyles.styleW500S14(color: color),
                ),
              ),
              _ToggleItem(
                width: 78,
                isSelected: languageCode == 'ar',
                onTap: () => onLanguageChanged('ar'),
                builder: (color) => Text(
                  strings.arabic,
                  style: AppTextStyles.styleW500S14(color: color),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Theme
        _buildSelectionRow(
          title: strings.theme,
          titleColor: accentColor,
          toggle: _ToggleSwitch(
            children: [
              _ToggleItem(
                width: 56,
                isSelected: selectedTheme == ThemeMode.light,
                onTap: () => onThemeChanged(ThemeMode.light),
                builder: (color) =>
                    Icon(Icons.light_mode_outlined, size: 22, color: color),
              ),
              _ToggleItem(
                width: 56,
                isSelected: selectedTheme == ThemeMode.dark,
                onTap: () => onThemeChanged(ThemeMode.dark),
                builder: (color) => Icon(
                  selectedTheme == ThemeMode.dark
                      ? Icons.dark_mode
                      : Icons.dark_mode_outlined,
                  size: 22,
                  color: color,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildSelectionRow({
    required String title,
    required Color titleColor,
    required Widget toggle,
  }) {
    return Row(
      children: [
        Text(title, style: AppTextStyles.styleW500S18(color: titleColor)),
        const Spacer(),
        toggle,
      ],
    );
  }
}

class _ToggleSwitch extends StatelessWidget {
  final List<Widget> children;

  const _ToggleSwitch({required this.children});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < children.length; i++) ...[
          if (i > 0) const SizedBox(width: 8),
          children[i],
        ],
      ],
    );
  }
}

class _ToggleItem extends StatelessWidget {
  final double width;
  final bool isSelected;
  final VoidCallback onTap;
  final Widget Function(Color color) builder;

  const _ToggleItem({
    required this.width,
    required this.isSelected,
    required this.onTap,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final Color selectedColor = isDark
        ? AppColors.mainColorDark
        : AppColors.mainColorlight;

    final Color unselectedBgColor = isDark
        ? Colors.transparent
        : AppColors.white;

    final Color unselectedBorderColor = isDark
        ? AppColors.mainColorDark.withValues(alpha: 0.3)
        : AppColors.mainColorlight.withValues(alpha: 0.1);

    final Color unselectedContentColor = isDark
        ? AppColors.darkTextColor
        : AppColors.mainColorlight;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: width,
        height: 32,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? selectedColor : unselectedBgColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? selectedColor : unselectedBorderColor,
          ),
        ),
        child: builder(isSelected ? AppColors.white : unselectedContentColor),
      ),
    );
  }
}
