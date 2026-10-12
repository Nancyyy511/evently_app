import 'package:flutter/material.dart';

class OnboardingModel {
  final String image;
  // Optional illustration for dark mode, falls back to [image]
  final String? darkImage;
  final String title;
  final String titleAr;
  final String description;
  final String descriptionAr;

  OnboardingModel({
    required this.image,
    this.darkImage,
    required this.title,
    required this.titleAr,
    required this.description,
    required this.descriptionAr,
  });

  String imageFor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark && darkImage != null ? darkImage! : image;
  }

  String titleFor(BuildContext context) => _isArabic(context) ? titleAr : title;

  String descriptionFor(BuildContext context) =>
      _isArabic(context) ? descriptionAr : description;

  bool _isArabic(BuildContext context) =>
      Localizations.localeOf(context).languageCode == 'ar';
}
