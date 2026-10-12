import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:evently_app/common/app_data.dart';
import 'package:evently_app/common/app_strings.dart';
import 'package:evently_app/theme/app_color.dart';
import 'package:evently_app/home/favourite.dart';
import 'package:evently_app/home/models/event_model.dart';
import 'package:evently_app/home/home_screen.dart';
import 'package:evently_app/home/profile_screen.dart';
import 'package:evently_app/home/add_event_screen.dart';

class LayoutScreen extends StatefulWidget {
  final ThemeMode selectedTheme;
  final ValueChanged<ThemeMode> onThemeChanged;
  final String languageCode;
  final ValueChanged<String> onLanguageChanged;
  const LayoutScreen({
    super.key,
    required this.selectedTheme,
    required this.onThemeChanged,
    required this.languageCode,
    required this.onLanguageChanged,
  });

  static const String routeName = '/layoutScreen';

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  int currentIndex = 0;

  // One place that changes favourites, so every tab rebuilds with the new value
  void toggleFavourite(EventModel event) {
    setState(() {
      event.isFavourite = !event.isFavourite;
    });
    AppData.notifyEventsChanged();
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeScreen(
        selectedTheme: widget.selectedTheme,
        onThemeChanged: widget.onThemeChanged,
        languageCode: widget.languageCode,
        onLanguageChanged: widget.onLanguageChanged,
        onFavouriteTap: toggleFavourite,
      ),
      FavouriteScreen(onFavouriteTap: toggleFavourite),
      ProfileScreen(
        selectedTheme: widget.selectedTheme,
        onThemeChanged: widget.onThemeChanged,
        languageCode: widget.languageCode,
        onLanguageChanged: widget.onLanguageChanged,
      ),
    ];
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final strings = AppStrings.of(context);

    final Color backgroundColor = isDark
        ? AppColors.darkBgColor
        : AppColors.white;

    final Color selectedColor = isDark
        ? AppColors.mainColorDark
        : AppColors.mainColorlight;

    final Color unselectedColor = isDark
        ? AppColors.darkTextColor
        : AppColors.lightSecTextColor;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBgColor : AppColors.lightBgColor,

      extendBody: true,

      body: pages[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,

        backgroundColor: backgroundColor,

        type: BottomNavigationBarType.fixed,

        elevation: 0,

        iconSize: 24,

        showSelectedLabels: true,
        showUnselectedLabels: true,

        selectedItemColor: selectedColor,
        unselectedItemColor: unselectedColor,

        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),

        unselectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),

        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppData.home,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(unselectedColor, BlendMode.srcIn),
            ),
            label: strings.home,
            activeIcon: buildActiveIcon(AppData.home, selectedColor),
          ),

          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppData.favourite,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(unselectedColor, BlendMode.srcIn),
            ),
            label: strings.favorite,
            activeIcon: buildActiveIcon(AppData.favourite, selectedColor),
          ),

          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppData.user,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(unselectedColor, BlendMode.srcIn),
            ),
            label: strings.profile,
            activeIcon: buildActiveIcon(AppData.user, selectedColor),
          ),
        ],

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: selectedColor,
        foregroundColor: Colors.white,
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: Icon(Icons.add, size: 28),
        onPressed: () async {
          final result = await Navigator.push<bool>(
            context,
            MaterialPageRoute(builder: (context) => const AddEventScreen()),
          );

          if (result == true && mounted) {
            setState(() {
              currentIndex = 0;
            });
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget buildActiveIcon(String icon, Color colorSelected) {
    return Container(
      width: 40,
      height: 32,

      padding: const EdgeInsets.all(6),

      decoration: BoxDecoration(
        color: colorSelected,
        borderRadius: BorderRadius.circular(10),
      ),

      child: SvgPicture.asset(
        icon,
        width: 20,
        height: 20,
        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
      ),
    );
  }
}
