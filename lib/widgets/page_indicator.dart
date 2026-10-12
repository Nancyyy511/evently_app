import 'package:evently_app/theme/app_color.dart';
import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  final int count;
  final int currentIndex;

  const PageIndicator({
    super.key,
    required this.count,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final inactiveColor = isDark
        ? AppColors.darkTextColor.withValues(alpha: 0.4)
        : AppColors.lightTextColor.withValues(alpha: 0.25);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final isSelected = currentIndex == index;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isSelected ? 20 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isSelected
                ? (isDark ? AppColors.mainColorDark : AppColors.mainColorlight)
                : inactiveColor,
            borderRadius: BorderRadius.circular(10),
          ),
        );
      }),
    );
  }
}
