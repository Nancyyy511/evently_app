import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:evently_app/common/App_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:evently_app/theme/app_color.dart';
import 'package:evently_app/widgets/profile_setting_card.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:evently_app/common/app_data.dart';
import 'package:evently_app/common/app_strings.dart';
import 'package:evently_app/widgets/custom_theme_toggle.dart';
import 'package:evently_app/widgets/custom_language_toggle.dart';
import 'package:evently_app/auth/login/login_screen.dart';
import 'package:evently_app/services/firebase_auth_services.dart';

class ProfileScreen extends StatefulWidget {
  final ThemeMode selectedTheme;
  final ValueChanged<ThemeMode> onThemeChanged;
  final String languageCode;
  final ValueChanged<String> onLanguageChanged;

  const ProfileScreen({
    super.key,
    required this.selectedTheme,
    required this.onThemeChanged,
    required this.languageCode,
    required this.onLanguageChanged,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ImagePicker picker = ImagePicker();
  Uint8List? selectedImage;

  Future<void> pickProfileImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final bytes = await image.readAsBytes();

      if (!mounted) return;

      setState(() {
        selectedImage = bytes;
      });
    }
  }

  Future<void> logout() async {
    try {
      await FirebaseAuthServices.logout();

      if (!mounted) return;

      Navigator.pushNamedAndRemoveUntil(
        context,
        LoginScreen.routeName,
        (route) => false,
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppStrings.of(context).logoutFailed)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final textColor = isDark
        ? AppColors.darkTextColor
        : AppColors.lightTextColor;

    final strings = AppStrings.of(context);

    // Get the currently signed-in Firebase user.
    final User? user = FirebaseAuthServices.currentUser;

    final String email = user?.email ?? '';

    final String? displayName = user?.displayName;

    final String userName = displayName != null && displayName.trim().isNotEmpty
        ? displayName.trim()
        : email.contains('@')
        ? email.split('@').first
        : strings.user;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBgColor : AppColors.lightBgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Profile picture
              Center(
                child: GestureDetector(
                  onTap: pickProfileImage,
                  child: CircleAvatar(
                    radius: 52,
                    backgroundColor: isDark
                        ? AppColors.mainColorlight
                        : AppColors.white,
                    backgroundImage: selectedImage != null
                        ? MemoryImage(selectedImage!)
                        : user?.photoURL != null
                        ? NetworkImage(user!.photoURL!)
                        : null,
                    child: selectedImage == null && user?.photoURL == null
                        ? Icon(
                            Icons.add_a_photo,
                            color: isDark
                                ? AppColors.darkTextColor
                                : AppColors.mainColorlight,
                            size: 32,
                          )
                        : null,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Dynamic username
              Text(
                userName,
                textAlign: TextAlign.center,
                style: AppTextStyles.styleW600S20(color: textColor),
              ),

              const SizedBox(height: 8),

              // Dynamic email
              Text(
                email.isNotEmpty ? email : strings.noEmail,
                textAlign: TextAlign.center,
                style: AppTextStyles.styleW400S14(
                  color: isDark ? AppColors.darkSecTextColor : textColor,
                ),
              ),

              const SizedBox(height: 32),

              // Theme Card
              ProfileSettingCard(
                title: strings.darkMode,
                trailing: CustomThemeToggle(
                  selectedTheme: widget.selectedTheme,
                  onThemeChanged: widget.onThemeChanged,
                ),
                onTap: () {
                  widget.onThemeChanged(
                    widget.selectedTheme == ThemeMode.dark
                        ? ThemeMode.light
                        : ThemeMode.dark,
                  );
                },
              ),

              const SizedBox(height: 16),

              // Language Card
              ProfileSettingCard(
                title: strings.language,
                trailing: CustomLanguageToggle(
                  languageCode: widget.languageCode,
                  onLanguageChanged: widget.onLanguageChanged,
                ),
                onTap: () {
                  widget.onLanguageChanged(
                    widget.languageCode == 'en' ? 'ar' : 'en',
                  );
                },
              ),

              const SizedBox(height: 16),

              // Logout Card
              ProfileSettingCard(
                title: strings.logout,
                titleColor: textColor,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(AppData.logout, width: 24, height: 24),
                  ],
                ),
                onTap: logout,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
