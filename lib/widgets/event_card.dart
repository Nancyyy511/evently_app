import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:evently_app/home/models/event_model.dart';
import 'package:evently_app/theme/app_color.dart';
import 'package:evently_app/common/App_text_styles.dart';
import 'package:evently_app/common/app_data.dart';
import 'package:evently_app/common/app_strings.dart';
import 'package:evently_app/home/event_details_screen.dart';

class EventCard extends StatelessWidget {
  final EventModel event;
  final VoidCallback onFavouriteTap;

  const EventCard({
    super.key,
    required this.event,
    required this.onFavouriteTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final imagePath = event.imageFor(context);

    final mainColor = isDark
        ? AppColors.mainColorDark
        : AppColors.mainColorlight;

    final textColor = isDark
        ? AppColors.darkTextColor
        : AppColors.lightTextColor;

    final cardColor = isDark ? AppColors.darkBgColor : AppColors.white;

    final labelColor = isDark ? AppColors.darkBgColor : AppColors.lightBgColor;

    final borderColor = isDark ? mainColor : mainColor.withValues(alpha: 0.15);

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventDetailsScreen(event: event),
          ),
        );
      },
      child: Container(
        height: 193,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor),
        ),
        child: Stack(
          children: [
            // Event artwork: light or dark image
            Positioned.fill(
              child: Image.asset(
                imagePath,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            // Date badge
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  color: labelColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: borderColor),
                ),
                child: Text(
                  AppStrings.of(context).eventDate(event.date),
                  style: AppTextStyles.styleW600S14(color: mainColor),
                ),
              ),
            ),

            // Caption and favourite button
            Positioned(
              bottom: 8,
              left: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                  color: labelColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: borderColor),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        event.caption,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.styleW500S14(color: textColor),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: onFavouriteTap,
                      child: SvgPicture.asset(
                        event.isFavourite
                            ? AppData.favouriteFilled
                            : AppData.favourite,
                        width: 24,
                        height: 24,
                        colorFilter: ColorFilter.mode(
                          mainColor,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
