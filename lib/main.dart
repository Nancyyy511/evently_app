import 'package:evently_app/onboarding/onboarding_screen.dart';
import 'package:evently_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode themeMode = ThemeMode.light;
  Locale locale = const Locale('en');

  void changeTheme(ThemeMode mode) {
    setState(() {
      themeMode = mode;
    });
  }

  void changeLanguage(String languageCode) {
    print('OLD LANGUAGE: ${locale.languageCode}');
    print('NEW LANGUAGE: $languageCode');

    setState(() {
      locale = Locale(languageCode);
    });
  }

  @override
  Widget build(BuildContext context) {
    final languageCode = locale.languageCode;

    return MaterialApp(
      title: 'Evently App',
      debugShowCheckedModeBanner: false,

      theme: AppTheme.lightTheme(languageCode),
      darkTheme: AppTheme.darkTheme(languageCode),
      themeMode: themeMode,

      locale: locale,
      supportedLocales: const [Locale('en'), Locale('ar')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      routes: {
        OnboardingScreen.routeName: (_) => OnboardingScreen(
          themeMode: themeMode,
          onThemeChanged: changeTheme,
          languageCode: languageCode,
          onLanguageChanged: changeLanguage,
        ),
      },

      initialRoute: OnboardingScreen.routeName,
    );
  }
}
