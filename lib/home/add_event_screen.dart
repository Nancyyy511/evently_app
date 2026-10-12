import 'package:flutter/material.dart';
import 'package:evently_app/widgets/custom_back_button.dart';

import 'package:evently_app/common/App_text_styles.dart';

import 'package:evently_app/common/app_data.dart';

import 'package:evently_app/common/app_strings.dart';

import 'package:evently_app/home/models/event_model.dart';

import 'package:evently_app/theme/app_color.dart';

import 'package:evently_app/widgets/add_event_card.dart';

import 'package:evently_app/widgets/custom_text_field.dart';

import 'package:evently_app/widgets/custom_elevated_button.dart';

import 'package:evently_app/widgets/horizontal_category_list.dart';

class AddEventScreen extends StatefulWidget {
  static const String routeName = '/addEventScreen';

  final EventModel? event;

  const AddEventScreen({super.key, this.event});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  int selectedCategoryIndex = 0;

  final TextEditingController titleController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  DateTime? selectedDate;

  TimeOfDay? selectedTime;

  String? selectedLocation;

  bool get isEditing => widget.event != null;

  @override
  void initState() {
    super.initState();

    final event = widget.event;

    if (event == null) return;

    // Fill the fields with the existing event data.

    titleController.text = event.caption;

    descriptionController.text = event.description ?? '';

    selectedLocation = event.location;

    // Restore the selected category.

    final categoryIndex = AppData.addEventCategories.indexWhere(
      (category) => category.title == event.category,
    );

    if (categoryIndex != -1) {
      selectedCategoryIndex = categoryIndex;
    }

    // Restore the saved date and time (stored as values, so no parsing is
    // needed and the language they were created in doesn't matter)

    selectedDate = event.date;

    selectedTime = event.time;
  }

  @override
  void dispose() {
    titleController.dispose();

    descriptionController.dispose();

    super.dispose();
  }

  void goBack() {
    Navigator.pop(context);
  }

  Future<void> chooseDate() async {
    final now = DateTime.now();

    final pickedDate = await showDatePicker(
      context: context,

      initialDate: selectedDate ?? now,

      firstDate: DateTime(2000),

      lastDate: DateTime(2035),

      helpText: AppStrings.of(context).chooseEventDate,
    );

    if (!mounted) return;

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> chooseTime() async {
    final pickedTime = await showTimePicker(
      context: context,

      initialTime: selectedTime ?? TimeOfDay.now(),

      helpText: AppStrings.of(context).chooseEventTime,
    );

    if (!mounted) return;

    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  Future<void> chooseLocation() async {
    final locationController = TextEditingController(
      text: selectedLocation ?? '',
    );

    final strings = AppStrings.of(context);

    final location = await showDialog<String>(
      context: context,

      builder: (dialogContext) {
        return AlertDialog(
          title: Text(strings.eventLocationLabel),

          content: TextField(
            controller: locationController,

            autofocus: true,

            decoration: InputDecoration(
              hintText: strings.enterEventLocation,

              border: const OutlineInputBorder(),
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },

              child: Text(strings.cancel),
            ),

            TextButton(
              onPressed: () {
                final value = locationController.text.trim();

                if (value.isNotEmpty) {
                  Navigator.pop(dialogContext, value);
                }
              },

              child: Text(strings.confirm),
            ),
          ],
        );
      },
    );

    locationController.dispose();

    if (!mounted) return;

    if (location != null) {
      setState(() {
        selectedLocation = location;
      });
    }
  }

  void saveEvent() {
    final title = titleController.text.trim();

    final description = descriptionController.text.trim();

    if (title.isEmpty ||
        description.isEmpty ||
        selectedDate == null ||
        selectedTime == null ||
        selectedLocation == null ||
        selectedLocation!.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppStrings.of(context).completeEventDetails)),
      );

      return;
    }

    final selectedCategory =
        AppData.addEventCategories[selectedCategoryIndex].title;

    final selectedLocationText = selectedLocation!.trim();

    if (widget.event != null) {
      // Update the existing event.

      final event = widget.event!;

      event.date = selectedDate!;

      event.caption = title;

      event.image = getCategoryBackground(selectedCategory, false);

      event.darkImage = getCategoryBackground(selectedCategory, true);

      event.category = selectedCategory;

      event.description = description;

      event.time = selectedTime;

      event.location = selectedLocationText;
    } else {
      // Create a new event.

      final newEvent = EventModel(
        date: selectedDate!,

        caption: title,

        image: getCategoryBackground(selectedCategory, false),

        darkImage: getCategoryBackground(selectedCategory, true),

        category: selectedCategory,

        isFavourite: false,

        description: description,

        time: selectedTime,

        location: selectedLocationText,
      );

      AppData.events.insert(0, newEvent);
    }
    AppData.notifyEventsChanged();
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final strings = AppStrings.of(context);

    final textColor = isDark
        ? AppColors.darkTextColor
        : AppColors.lightTextColor;

    final categories = AppData.addEventCategories;

    final selectedCategory = categories[selectedCategoryIndex].title;

    final backgroundImage = getCategoryBackground(selectedCategory, isDark);

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBgColor : AppColors.lightBgColor,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),

          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 16),
                // Header
                SizedBox(
                  height: 40,

                  child: Row(
                    children: [
                      SizedBox(
                        width: 40,

                        child: Align(
                          alignment: AlignmentDirectional.centerStart,

                          child: CustomBackButton(
                            onTap: goBack,
                            borderColor: AppColors.mainColorlight,
                          ),
                        ),
                      ),

                      Expanded(
                        child: Center(
                          child: Text(
                            isEditing ? strings.editEvent : strings.addEvent,

                            style: AppTextStyles.styleW500S18(color: textColor),
                          ),
                        ),
                      ),

                      const SizedBox(width: 40),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Category background
                Container(
                  height: 193,

                  width: double.infinity,

                  clipBehavior: Clip.antiAlias,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),

                  child: Image.asset(backgroundImage, fit: BoxFit.cover),
                ),

                const SizedBox(height: 16),

                // Categories
                HorizontalCategoryList(
                  categories: categories,

                  selectedIndex: selectedCategoryIndex,

                  onCategorySelected: (index) {
                    setState(() {
                      selectedCategoryIndex = index;
                    });
                  },
                ),

                const SizedBox(height: 16),

                // Title
                Align(
                  alignment: AlignmentDirectional.centerStart,

                  child: Text(
                    strings.title,

                    style: AppTextStyles.styleW500S16(color: textColor),
                  ),
                ),

                const SizedBox(height: 8),

                CustomTextField(
                  controller: titleController,

                  hintText: strings.eventTitleHint,
                ),

                const SizedBox(height: 16),

                // Description
                Align(
                  alignment: AlignmentDirectional.centerStart,

                  child: Text(
                    strings.description,

                    style: AppTextStyles.styleW500S16(color: textColor),
                  ),
                ),

                const SizedBox(height: 8),

                SizedBox(
                  height: 168,

                  child: CustomTextField(
                    controller: descriptionController,

                    hintText: strings.eventDescriptionHint,

                    expands: true,
                  ),
                ),

                const SizedBox(height: 16),

                // Event date
                AddEventCard(
                  title: strings.eventDateLabel,

                  trailingText: selectedDate == null
                      ? strings.chooseDate
                      : '${selectedDate!.day.toString().padLeft(2, '0')}/'
                            '${selectedDate!.month.toString().padLeft(2, '0')}/'
                            '${selectedDate!.year}',

                  icon: Icons.calendar_month_outlined,

                  onTap: chooseDate,
                ),

                const SizedBox(height: 8),

                // Event time
                AddEventCard(
                  title: strings.eventTimeLabel,

                  trailingText: selectedTime == null
                      ? strings.chooseTime
                      : selectedTime!.format(context),

                  icon: Icons.access_time,

                  onTap: chooseTime,
                ),

                const SizedBox(height: 8),

                // Event location
                AddEventCard(
                  title: strings.eventLocationLabel,

                  trailingText: selectedLocation ?? strings.chooseLocation,

                  icon: Icons.location_city,

                  onTap: chooseLocation,
                ),

                const SizedBox(height: 40),

                // Save button
                CustomElevatedButton(
                  text: isEditing ? strings.saveChanges : strings.addEvent,
                  onPressed: saveEvent,
                ),

                const SizedBox(height: 48),
              ],
            ),
          ),
        ),
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
