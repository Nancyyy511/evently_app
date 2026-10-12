import 'package:evently_app/auth/login/login_screen.dart';
import 'package:flutter/material.dart';

import 'package:evently_app/widgets/evently_logo.dart';
import 'package:evently_app/common/app_data.dart';
import 'package:evently_app/common/App_text_styles.dart';
import 'package:evently_app/theme/app_color.dart';
import 'package:evently_app/widgets/custom_text_field.dart';
import 'package:evently_app/widgets/custom_elevated_button.dart';
import 'package:evently_app/widgets/auth_error_message.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:evently_app/layout/layout_screen.dart';
import 'package:evently_app/auth/auth_helper.dart';
import 'package:evently_app/common/app_strings.dart';
import 'package:evently_app/models/user_model.dart';
import 'package:evently_app/services/firebase_auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "/registerScreen";

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isGoogleLoading = false;
  bool isLoading = false;
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Error shown inside the screen above the Sign Up button (null = hidden)
  String? errorMessage;

  void showError(String message) {
    setState(() {
      errorMessage = message;
    });
  }

  // Called when the user edits a field: the old error no longer applies
  void clearError() {
    if (errorMessage != null) {
      setState(() {
        errorMessage = null;
      });
    }
  }

  Future<void> signUpWithGoogle() async {
    if (isGoogleLoading || isLoading) return;

    setState(() {
      isGoogleLoading = true;
      errorMessage = null;
    });

    try {
      await FirebaseAuthServices.signInWithGoogle();

      if (!mounted) return;

      Navigator.pushNamedAndRemoveUntil(
        context,
        LayoutScreen.routeName,
        (route) => false,
      );
    } catch (e) {
      if (!mounted || AuthHelper.isGoogleCancellation(e)) return;

      final strings = AppStrings.of(context);
      showError(
        e is FirebaseAuthException
            ? AuthHelper.messageFor(e, strings)
            : strings.googleSignUpFailed,
      );
    } finally {
      if (mounted) {
        setState(() {
          isGoogleLoading = false;
        });
      }
    }
  }

  Future<void> signUpWithEmail() async {
    if (isLoading || isGoogleLoading) return;
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      await FirebaseAuthServices.register(
        UserModel(
          name: _usernameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text,
        ),
      );

      if (!mounted) return;

      Navigator.pushNamedAndRemoveUntil(
        context,
        LayoutScreen.routeName,
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      showError(AuthHelper.messageFor(e, AppStrings.of(context)));
    } on FirebaseException catch (_) {
      // Account was created, but saving the Firestore profile failed
      if (!mounted) return;
      showError(AppStrings.of(context).profileSaveFailed);
    } catch (_) {
      if (!mounted) return;
      showError(AppStrings.of(context).createAccountFailed);
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final strings = AppStrings.of(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),

                  // LOGO
                  const SizedBox(
                    height: 27,
                    child: Center(child: EventlyLogo()),
                  ),

                  const SizedBox(height: 47),

                  //  TITLE
                  Text(
                    strings.registerTitle,
                    style: AppTextStyles.styleW600S22(
                      color: isDark
                          ? AppColors.darkTextColor
                          : AppColors.mainColorlight,
                    ),
                  ),

                  const SizedBox(height: 24),
                  //USERNAME
                  CustomTextField(
                    controller: _usernameController,
                    hintText: strings.enterName,
                    keyboardType: TextInputType.name,
                    onChanged: (_) => clearError(),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return strings.usernameRequired;
                      }

                      return null;
                    },

                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12),
                      child: SvgPicture.asset(
                        AppData.user,
                        width: 24,
                        height: 24,
                        colorFilter: const ColorFilter.mode(
                          Colors.grey,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),

                  // EMAIL
                  CustomTextField(
                    controller: _emailController,
                    hintText: strings.enterEmail,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (_) => clearError(),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return strings.emailRequired;
                      }

                      return null;
                    },

                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12),
                      child: SvgPicture.asset(
                        AppData.email,
                        width: 24,
                        height: 24,
                        colorFilter: const ColorFilter.mode(
                          Colors.grey,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  //PASSWORD
                  CustomTextField(
                    controller: _passwordController,
                    hintText: strings.enterPassword,
                    obscureText: !isPasswordVisible,
                    onChanged: (_) => clearError(),

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return strings.passwordRequired;
                      }

                      return null;
                    },

                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12),
                      child: SvgPicture.asset(
                        AppData.password,
                        width: 24,
                        height: 24,
                        colorFilter: const ColorFilter.mode(
                          Colors.grey,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),

                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                      icon: Padding(
                        padding: EdgeInsets.all(4),
                        child: SvgPicture.asset(
                          AppData.eyeToggle,
                          width: 24,
                          height: 24,
                          colorFilter: const ColorFilter.mode(
                            Colors.grey,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  //confirmPassword
                  CustomTextField(
                    controller: _confirmPasswordController,
                    hintText: strings.confirmPasswordHint,
                    obscureText: !isConfirmPasswordVisible,
                    onChanged: (_) => clearError(),

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return strings.confirmPasswordRequired;
                      }
                      if (value != _passwordController.text) {
                        return strings.passwordsDoNotMatch;
                      }

                      return null;
                    },

                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12),
                      child: SvgPicture.asset(
                        AppData.password,
                        width: 24,
                        height: 24,
                        colorFilter: const ColorFilter.mode(
                          Colors.grey,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),

                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isConfirmPasswordVisible = !isConfirmPasswordVisible;
                        });
                      },
                      icon: Padding(
                        padding: EdgeInsets.all(4),
                        child: SvgPicture.asset(
                          AppData.eyeToggle,
                          width: 24,
                          height: 24,
                          colorFilter: const ColorFilter.mode(
                            Colors.grey,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Inline error; same 52px gap as before when hidden
                  if (errorMessage != null) ...[
                    const SizedBox(height: 24),
                    AuthErrorMessage(message: errorMessage!),
                    const SizedBox(height: 28),
                  ] else
                    SizedBox(height: 52),
                  CustomElevatedButton(
                    text: strings.signUp,
                    isLoading: isLoading,
                    onPressed: signUpWithEmail,
                  ),
                  SizedBox(height: 24),
                  //sign up
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        strings.haveAccount,
                        style: AppTextStyles.styleW400S14(
                          color: isDark
                              ? AppColors.darkSecTextColor
                              : AppColors.lightSecTextColor,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, LoginScreen.routeName);
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          strings.loginLink,
                          style:
                              AppTextStyles.styleW600S14(
                                color: isDark
                                    ? AppColors.darkTextColor
                                    : AppColors.mainColorlight,
                              ).copyWith(
                                decoration: TextDecoration.underline,
                                decorationColor: isDark
                                    ? AppColors.darkTextColor
                                    : AppColors.mainColorlight,
                              ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                  //OR
                  Center(
                    child: Text(
                      strings.or,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.styleW500S16(
                        color: isDark
                            ? AppColors.darkTextColor
                            : AppColors.mainColorlight,
                      ),
                    ),
                  ),
                  SizedBox(height: 24),

                  // Google button keeps its own colors and content
                  CustomElevatedButton(
                    backgroundColor: isDark
                        ? AppColors.darkBgColor
                        : AppColors.white,
                    foregroundColor: isDark
                        ? AppColors.darkTextColor
                        : AppColors.mainColorlight,
                    isLoading: isGoogleLoading,
                    onPressed: signUpWithGoogle,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(AppData.google, height: 24, width: 24),
                        const SizedBox(width: 15),
                        Text(
                          strings.signUpWithGoogle,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.styleW500S18(
                            color: isDark
                                ? AppColors.darkTextColor
                                : AppColors.mainColorlight,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
