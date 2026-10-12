import 'package:evently_app/common/App_text_styles.dart';
import 'package:evently_app/onboarding/onbarding_model.dart';
import 'package:evently_app/theme/app_color.dart';
import 'package:evently_app/widgets/page_indicator.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingModel model;
  final int indicatorCount;
  final int indicatorIndex;

  const OnboardingPage({
    super.key,
    required this.model,
    required this.indicatorCount,
    required this.indicatorIndex,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final Color titleColor = isDark
        ? AppColors.darkTextColor
        : AppColors.lightTextColor;

    final Color descriptionColor = isDark
        ? AppColors.darkSecTextColor
        : AppColors.lightSecTextColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Onboarding Image
        Expanded(
          flex: 5,
          child: Center(
            child: Image.asset(model.imageFor(context), fit: BoxFit.contain),
          ),
        ),

        const SizedBox(height: 16),

        PageIndicator(count: indicatorCount, currentIndex: indicatorIndex),

        const SizedBox(height: 24),

        // Title
        Text(
          model.titleFor(context),
          style: AppTextStyles.styleW700S20(color: titleColor),
        ),

        const SizedBox(height: 12),

        // Description
        Expanded(
          flex: 3,
          child: SingleChildScrollView(
            child: Text(
              model.descriptionFor(context),
              style: AppTextStyles.styleW400S14(
                color: descriptionColor,
              ).copyWith(height: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
