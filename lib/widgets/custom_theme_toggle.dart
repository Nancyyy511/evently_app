import 'package:flutter/material.dart';
import 'package:evently_app/theme/app_color.dart';

/// Theme selector shared by Home and Profile.
///
/// - Default (Profile "Dark mode" row): a switch, on = dark theme.
/// - [CustomThemeToggle.compact] (Home header): a single sun / moon icon
///   that flips between light and dark.
///
/// Onboarding uses its own selector design (see onboarding_first_page.dart).
class CustomThemeToggle extends StatelessWidget {
  final ThemeMode selectedTheme;
  final ValueChanged<ThemeMode> onThemeChanged;
  final bool _compact;

  const CustomThemeToggle({
    super.key,
    required this.selectedTheme,
    required this.onThemeChanged,
  }) : _compact = false;

  const CustomThemeToggle.compact({
    super.key,
    required this.selectedTheme,
    required this.onThemeChanged,
  }) : _compact = true;

  bool get _isDarkSelected => selectedTheme == ThemeMode.dark;

  void _toggle() {
    onThemeChanged(_isDarkSelected ? ThemeMode.light : ThemeMode.dark);
  }

  @override
  Widget build(BuildContext context) {
    return _compact ? _buildCompact() : _buildSwitch();
  }

  Widget _buildCompact() {
    return GestureDetector(
      onTap: _toggle,
      child: Icon(
        _isDarkSelected ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
        size: 28,
        color: _isDarkSelected
            ? AppColors.darkTextColor
            : AppColors.mainColorlight,
      ),
    );
  }

  Widget _buildSwitch() {
    return Transform.scale(
      scale: 0.8,
      child: Switch(
        value: _isDarkSelected,
        onChanged: (_) => _toggle(),
        thumbColor: const WidgetStatePropertyAll(AppColors.white),
        activeTrackColor: AppColors.mainColorDark,
        inactiveTrackColor: AppColors.lightSecTextColor.withValues(alpha: 0.3),
        trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
      ),
    );
  }
}
