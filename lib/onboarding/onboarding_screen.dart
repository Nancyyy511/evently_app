import 'package:evently_app/common/App_text_styles.dart';
import 'package:evently_app/common/app_data.dart';
import 'package:evently_app/common/app_strings.dart';
import 'package:evently_app/theme/app_color.dart';
import 'package:evently_app/widgets/evently_logo.dart';
import 'package:evently_app/widgets/onboarding_first_page.dart';
import 'package:evently_app/widgets/onboarding_page.dart';
import 'package:evently_app/auth/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:evently_app/widgets/custom_back_button.dart';

class OnboardingScreen extends StatefulWidget {
  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeChanged;
  final String languageCode;
  final ValueChanged<String> onLanguageChanged;

  const OnboardingScreen({
    super.key,
    required this.themeMode,
    required this.onThemeChanged,
    required this.languageCode,
    required this.onLanguageChanged,
  });

  static const String routeName = '/onboardingScreen';

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController pageController = PageController();

  int currentPage = 0;
  late ThemeMode selectedTheme = widget.themeMode;
  late String selectedLanguage = widget.languageCode;

  int get lastPage => AppData.onboardingData.length - 1;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void nextPage() {
    if (currentPage < lastPage) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      goToLogin();
    }
  }

  void previousPage() {
    if (currentPage > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void goToLogin() {
    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
  }

  void changeTheme(ThemeMode mode) {
    setState(() => selectedTheme = mode);
    widget.onThemeChanged(mode);
  }

  void changeLanguage(String languageCode) {
    setState(() => selectedLanguage = languageCode);
    widget.onLanguageChanged(languageCode);
  }

  @override
  Widget build(BuildContext context) {
    // Back button from the 3rd page on, Skip on the middle pages (as in the design)
    final strings = AppStrings.of(context);
    final showBack = currentPage >= 2;
    final showSkip = currentPage > 0 && currentPage < lastPage;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 16),

              SizedBox(
                height: 40,
                child: Row(
                  children: [
                    SizedBox(
                      width: 56,
                      child: Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: showBack
                            ? CustomBackButton(onTap: previousPage)
                            : null,
                      ),
                    ),
                    const Expanded(child: Center(child: EventlyLogo())),
                    SizedBox(
                      width: 56,
                      child: Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: showSkip ? _SkipButton(onTap: goToLogin) : null,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  itemCount: AppData.onboardingData.length,
                  onPageChanged: (index) {
                    setState(() {
                      currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return OnboardingFirstPage(
                        model: AppData.onboardingData[index],
                        selectedTheme: selectedTheme,
                        onThemeChanged: changeTheme,
                        languageCode: selectedLanguage,
                        onLanguageChanged: changeLanguage,
                      );
                    }

                    // The first (settings) page has no indicator dot
                    return OnboardingPage(
                      model: AppData.onboardingData[index],
                      indicatorCount: AppData.onboardingData.length - 1,
                      indicatorIndex: index - 1,
                    );
                  },
                ),
              ),

              const SizedBox(height: 16),

              ElevatedButton(
                onPressed: nextPage,
                child: Text(
                  currentPage == 0
                      ? strings.letsStart
                      : currentPage == lastPage
                      ? strings.getStarted
                      : strings.next,
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _SkipButton extends StatelessWidget {
  final VoidCallback onTap;

  const _SkipButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isDark ? Colors.transparent : AppColors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isDark ? AppColors.mainColorlight : AppColors.white,
          ),
        ),
        child: Text(
          AppStrings.of(context).skip,
          style: AppTextStyles.styleW500S14(
            color: isDark ? AppColors.darkTextColor : AppColors.mainColorlight,
          ),
        ),
      ),
    );
  }
}
