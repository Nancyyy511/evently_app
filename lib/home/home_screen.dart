import 'package:evently_app/common/app_data.dart';
import 'package:evently_app/common/app_strings.dart';
import 'package:evently_app/home/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:evently_app/theme/app_color.dart';
import 'package:evently_app/common/App_text_styles.dart';
import 'package:evently_app/widgets/custom_theme_toggle.dart';
import 'package:evently_app/widgets/custom_language_toggle.dart';
import 'package:evently_app/widgets/horizontal_category_list.dart';
import 'package:evently_app/widgets/event_list.dart';
import 'package:evently_app/services/firebase_auth_services.dart';

class HomeScreen extends StatefulWidget {
  final ThemeMode selectedTheme;
  final ValueChanged<ThemeMode> onThemeChanged;
  final String languageCode;
  final ValueChanged<String> onLanguageChanged;
  // Comes from LayoutScreen so Home and Favourite share the same state
  final ValueChanged<EventModel>? onFavouriteTap;

  const HomeScreen({
    super.key,
    required this.selectedTheme,
    required this.onThemeChanged,
    required this.languageCode,
    required this.onLanguageChanged,
    this.onFavouriteTap,
  });

  static const String routeName = "/homeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedCategoryIndex = 0;

  void onCategorySelected(int index) {
    setState(() {
      selectedCategoryIndex = index;
    });
  }

  void onFavouriteTap(EventModel event) {
    if (widget.onFavouriteTap != null) {
      widget.onFavouriteTap!(event);
    } else {
      // HomeScreen opened on its own (without LayoutScreen)
      setState(() {
        event.isFavourite = !event.isFavourite;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final textColor = isDark
        ? AppColors.darkTextColor
        : AppColors.lightTextColor;

    final strings = AppStrings.of(context);

    final user = FirebaseAuthServices.currentUser;

    final userName = user?.displayName?.trim().isNotEmpty == true
        ? user!.displayName!
        : user?.email?.split('@').first ?? strings.user;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBgColor : AppColors.lightBgColor,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),

          child: Column(
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          strings.welcomeBack,
                          style: AppTextStyles.styleW400S14(color: textColor),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          userName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.styleW600S20(color: textColor),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Actions
                  Row(
                    children: [
                      // Theme Toggle
                      CustomThemeToggle.compact(
                        selectedTheme: widget.selectedTheme,
                        onThemeChanged: widget.onThemeChanged,
                      ),

                      const SizedBox(width: 12),

                      // Language Toggle
                      CustomLanguageToggle.compact(
                        languageCode: widget.languageCode,
                        onLanguageChanged: widget.onLanguageChanged,
                      ),
                    ],
                  ),
                ],
              ),

              // Categories
              HorizontalCategoryList(
                categories: AppData.categories,
                selectedIndex: selectedCategoryIndex,
                onCategorySelected: onCategorySelected,
              ),

              const SizedBox(height: 16),
              // Events
              EventList(
                selectedCtegory:
                    AppData.categories[selectedCategoryIndex].title,
                onFavouriteTap: onFavouriteTap,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
