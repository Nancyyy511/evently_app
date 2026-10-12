import 'package:evently_app/common/App_text_styles.dart';
import 'package:evently_app/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ElevatedButtonThemeData _elevatedButtonTheme(String languageCode) =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.mainColorlight,
          foregroundColor: AppColors.white,
          elevation: 0,
          minimumSize: const Size(double.infinity, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: AppTextStyles.styleW500S18(
            color: AppColors.white,
          ).copyWith(fontFamily: _fontFamily(languageCode)),
        ),
      );

  // Poppins for English, Cairo for Arabic (Poppins has no Arabic glyphs)
  static String? _fontFamily(String languageCode) => languageCode == 'ar'
      ? GoogleFonts.cairo().fontFamily
      : GoogleFonts.poppins().fontFamily;

  static ThemeData lightTheme(String languageCode) => ThemeData(
    fontFamily: _fontFamily(languageCode),
    scaffoldBackgroundColor: AppColors.lightBgColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.lightBgColor,
      foregroundColor: AppColors.lightTextColor,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.mainColorlight),
      titleTextStyle: AppTextStyles.styleW400S22(
        color: AppColors.mainColorlight,
      ),
      centerTitle: true,
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.mainColorlight,
      primary: AppColors.mainColorlight,
      onPrimary: AppColors.white,
      surface: AppColors.lightBgColor,
      onSurface: AppColors.lightTextColor,
      brightness: Brightness.light,
    ),
    elevatedButtonTheme: _elevatedButtonTheme(languageCode),
    textTheme: TextTheme(
      displayLarge: AppTextStyles.styleW700S22(),
      displayMedium: AppTextStyles.styleW700S20(),
      displaySmall: AppTextStyles.styleW700S18(),

      headlineLarge: AppTextStyles.styleW600S22(),
      headlineMedium: AppTextStyles.styleW600S20(),
      headlineSmall: AppTextStyles.styleW600S18(),

      titleLarge: AppTextStyles.styleW500S22(),
      titleMedium: AppTextStyles.styleW500S20(),
      titleSmall: AppTextStyles.styleW500S18(),

      bodyLarge: AppTextStyles.styleW600S22(),
      bodyMedium: AppTextStyles.styleW600S20(),
      bodySmall: AppTextStyles.styleW600S18(),

      labelLarge: AppTextStyles.styleW400S18(),
      labelMedium: AppTextStyles.styleW400S16(),
      labelSmall: AppTextStyles.styleW400S14(),
    ),
  );

  static ThemeData darkTheme(String languageCode) => ThemeData(
    fontFamily: _fontFamily(languageCode),
    scaffoldBackgroundColor: AppColors.darkBgColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.mainColorDark,
      primary: AppColors.mainColorDark,
      onPrimary: AppColors.white,
      surface: AppColors.darkBgColor,
      onSurface: AppColors.darkTextColor,
      brightness: Brightness.dark,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkBgColor,
      foregroundColor: AppColors.darkTextColor,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.mainColorDark),
      titleTextStyle: AppTextStyles.styleW400S22(
        color: AppColors.mainColorDark,
      ),
      centerTitle: true,
    ),
    elevatedButtonTheme: _elevatedButtonTheme(languageCode),
    textTheme: TextTheme(
      displayLarge: AppTextStyles.styleW700S22(color: AppColors.darkTextColor),
      displayMedium: AppTextStyles.styleW700S20(color: AppColors.darkTextColor),
      displaySmall: AppTextStyles.styleW700S18(color: AppColors.darkTextColor),

      headlineLarge: AppTextStyles.styleW600S22(color: AppColors.darkTextColor),
      headlineMedium: AppTextStyles.styleW600S20(
        color: AppColors.darkTextColor,
      ),
      headlineSmall: AppTextStyles.styleW600S18(color: AppColors.darkTextColor),

      titleLarge: AppTextStyles.styleW500S22(color: AppColors.darkTextColor),
      titleMedium: AppTextStyles.styleW500S20(color: AppColors.darkTextColor),
      titleSmall: AppTextStyles.styleW500S18(color: AppColors.darkTextColor),

      bodyLarge: AppTextStyles.styleW600S22(color: AppColors.darkTextColor),
      bodyMedium: AppTextStyles.styleW600S20(color: AppColors.darkTextColor),
      bodySmall: AppTextStyles.styleW600S18(color: AppColors.darkTextColor),

      labelLarge: AppTextStyles.styleW400S18(color: AppColors.darkTextColor),
      labelMedium: AppTextStyles.styleW400S16(color: AppColors.darkTextColor),
      labelSmall: AppTextStyles.styleW400S14(color: AppColors.darkTextColor),
    ),
  );
}
