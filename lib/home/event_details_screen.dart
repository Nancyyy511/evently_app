import 'package:evently_app/home/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:evently_app/widgets/custom_back_button.dart';
import 'package:evently_app/common/App_text_styles.dart';
import 'package:evently_app/common/app_data.dart';
import 'package:evently_app/common/app_strings.dart';
import 'package:evently_app/theme/app_color.dart';
import 'package:evently_app/home/add_event_screen.dart';
import 'package:flutter_svg/svg.dart';

class EventDetailsScreen extends StatefulWidget {
  static const String routeName = "/eventDetailsScreen";
  final EventModel event;

  const EventDetailsScreen({super.key, required this.event});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  void goToHome() {
    Navigator.pop(context);
  }

  Future<void> deleteEvent() async {
    final strings = AppStrings.of(context);

    final confirm = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(strings.deleteEvent),
          content: Text(strings.deleteEventConfirm),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: Text(strings.cancel),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              child: Text(strings.delete),
            ),
          ],
        );
      },
    );

    if (confirm != true || !mounted) return;

    AppData.events.remove(widget.event);
    AppData.notifyEventsChanged();
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final event = widget.event;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final strings = AppStrings.of(context);

    final mainColor = isDark
        ? AppColors.mainColorDark
        : AppColors.mainColorlight;

    final textColor = isDark
        ? AppColors.darkTextColor
        : AppColors.lightTextColor;

    final cardColor = isDark ? AppColors.darkBgColor : AppColors.white;

    final borderColor = isDark
        ? mainColor.withValues(alpha: 0.4)
        : AppColors.lightSecTextColor.withValues(alpha: 0.2);

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBgColor : AppColors.lightBgColor,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 56,
                        child: Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: CustomBackButton(onTap: goToHome),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            strings.eventDetails,
                            style: AppTextStyles.styleW500S18(
                              color: isDark
                                  ? AppColors.darkTextColor
                                  : AppColors.lightTextColor,
                            ),
                          ),
                        ),
                      ),
                      _EditButton(
                        onTap: () async {
                          final result = await Navigator.push<bool>(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AddEventScreen(event: widget.event),
                            ),
                          );

                          if (result == true && mounted) {
                            setState(() {});
                          }
                        },
                      ),
                      const SizedBox(width: 8),
                      _DeleteButton(onTap: deleteEvent),
                    ],
                  ),
                ),

                SizedBox(height: 32),
                //
                Container(
                  height: 193,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.asset(
                    event.imageFor(context),
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(height: 16),
                //event title
                Text(
                  event.caption,

                  style: AppTextStyles.styleW500S16(color: textColor),
                ),

                SizedBox(height: 8),

                //Date field
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: borderColor),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: isDark
                              ? AppColors.mainColorDark.withValues(alpha: 0.15)
                              : AppColors.lightBgColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.calendar_month_outlined,
                          color: mainColor,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              strings.eventDate(event.date),
                              style: AppTextStyles.styleW500S16(
                                color: textColor,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              event.time?.format(context) ?? '--:--',
                              style: AppTextStyles.styleW400S14(
                                color: isDark
                                    ? AppColors.darkSecTextColor
                                    : AppColors.lightSecTextColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),

                //Description title
                Text(
                  strings.description,

                  style: AppTextStyles.styleW500S16(color: textColor),
                ),

                SizedBox(height: 8),
                //Description field
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: borderColor),
                  ),
                  child: Text(
                    event.description?.isNotEmpty == true
                        ? event.description!
                        : strings.noDescription,
                    style: AppTextStyles.styleW400S14(color: textColor),
                  ),
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),

        //forget password image
      ),
    );
  }
}

String getCategoryBackground(String category, bool isDark) {
  switch (category) {
    case 'Birthday':
      return isDark ? AppData.birthdayBgDark : AppData.birthdayBgLight;

    case 'Meeting':
      return isDark ? AppData.mettingBgDark : AppData.mettingBgLight;

    case 'Exhibition':
      return isDark ? AppData.exhibitionBgDark : AppData.exhibitionBgLight;

    case 'Sport':
      return isDark ? AppData.sportBgDark : AppData.sportBgLight;

    case 'Book Club':
      return isDark ? AppData.bookClubBgDark : AppData.bookClubBgLight;

    default:
      return isDark ? AppData.birthdayBgDark : AppData.birthdayBgLight;
  }
}

class _EditButton extends StatelessWidget {
  final VoidCallback onTap;

  const _EditButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: isDark ? AppColors.darkBgColor : AppColors.white,

          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isDark ? AppColors.mainColorlight : AppColors.white,
          ),
        ),
        child: SvgPicture.asset(AppData.edit, width: 20, height: 20),
      ),
    );
  }
}

class _DeleteButton extends StatelessWidget {
  final VoidCallback onTap;

  const _DeleteButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: isDark ? AppColors.darkBgColor : AppColors.white,

          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isDark ? AppColors.mainColorlight : AppColors.white,
          ),
        ),

        child: SvgPicture.asset(AppData.delete, width: 20, height: 20),
      ),
    );
  }
}
