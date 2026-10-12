import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:evently_app/home/models/category_model.dart';
import 'package:evently_app/theme/app_color.dart';
import 'package:evently_app/common/App_text_styles.dart';
import 'package:evently_app/common/app_strings.dart';

class HorizontalCategoryList extends StatelessWidget {
  final List<CategoryModel> categories;
  final int selectedIndex;
  final ValueChanged<int> onCategorySelected;

  const HorizontalCategoryList({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final strings = AppStrings.of(context);

    final activeColor = isDark
        ? AppColors.mainColorDark
        : AppColors.mainColorlight;

    final inactiveColor = isDark ? AppColors.darkBgColor : AppColors.white;

    final textColor = isDark
        ? AppColors.darkTextColor
        : AppColors.lightTextColor;

    return SizedBox(
      height: 48,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isActive = index == selectedIndex;

          return Padding(
            padding: EdgeInsetsDirectional.only(
              end: index == categories.length - 1 ? 0 : 8,
            ),
            child: GestureDetector(
              onTap: () {
                onCategorySelected(index);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: isActive ? activeColor : inactiveColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isActive
                        ? activeColor
                        : AppColors.mainColorlight.withValues(alpha: 0.5),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      category.icon,
                      width: 20,
                      height: 20,
                      colorFilter: ColorFilter.mode(
                        isActive ? AppColors.white : activeColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      // title stays the English id; only the label is translated
                      strings.categoryName(category.title),
                      style: AppTextStyles.styleW500S16(
                        color: isActive ? AppColors.white : textColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
