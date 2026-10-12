import 'package:flutter/material.dart';

class EventModel {
  // Stored as values, not text, so they survive language changes and edits;
  // format with AppStrings.eventDate / TimeOfDay.format when displaying
  DateTime date;
  String caption;
  String image;

  // Optional artwork for dark mode, falls back to [image]
  String? darkImage;
  String category;
  bool isFavourite;

  String? description;
  TimeOfDay? time;
  String? location;

  EventModel({
    required this.date,
    required this.caption,
    required this.image,

    required this.category,
    required this.isFavourite,
    this.description,
    this.time,
    this.location,
    this.darkImage,
  });

  String imageFor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark && darkImage != null ? darkImage! : image;
  }
}
