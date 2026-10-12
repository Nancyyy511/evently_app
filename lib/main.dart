import 'package:evently_app/auth/login/login_screen.dart';
import 'package:evently_app/auth/forget_password/forget_password_screen.dart';
import 'package:evently_app/onboarding/onboarding_screen.dart';
import 'package:evently_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:evently_app/auth/register/register_screen.dart';
import 'package:evently_app/home/home_screen.dart';
import 'package:evently_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:evently_app/services/firebase_auth_services.dart';
import 'package:evently_app/layout/layout_screen.dart';
import 'package:evently_app/home/profile_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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

  // Route guard: protected screens show Login when no Firebase user is
  // signed in (e.g. a typed web URL or browser Back after logout)
  Widget requireAuth(Widget screen) =>
      FirebaseAuthServices.currentUser == null ? const LoginScreen() : screen;

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

        LoginScreen.routeName: (_) => LoginScreen(),

        RegisterScreen.routeName: (_) => RegisterScreen(),

        ForgetPasswordScreen.routeName: (_) => const ForgetPasswordScreen(),

        HomeScreen.routeName: (_) => requireAuth(
          HomeScreen(
            selectedTheme: themeMode,
            onThemeChanged: changeTheme,
            languageCode: locale.languageCode,
            onLanguageChanged: changeLanguage,
          ),
        ),

        LayoutScreen.routeName: (_) => requireAuth(
          LayoutScreen(
            selectedTheme: themeMode,
            onThemeChanged: changeTheme,
            languageCode: locale.languageCode,
            onLanguageChanged: changeLanguage,
          ),
        ),
      },

      initialRoute: OnboardingScreen.routeName,
    );
  }
}
