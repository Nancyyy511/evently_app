import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:evently_app/widgets/custom_back_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:evently_app/common/App_text_styles.dart';
import 'package:evently_app/theme/app_color.dart';
import 'package:evently_app/common/app_data.dart';
import 'package:evently_app/auth/login/login_screen.dart';
import 'package:evently_app/widgets/custom_elevated_button.dart';
import 'package:evently_app/widgets/custom_text_field.dart';
import 'package:evently_app/widgets/auth_error_message.dart';
import 'package:evently_app/auth/auth_helper.dart';
import 'package:evently_app/common/app_strings.dart';
import 'package:evently_app/services/firebase_auth_services.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});
  static const String routeName = "/forgetPasswordScreen";

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool _prefilled = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Pre-fill with the email typed on the Login screen, if any
    if (!_prefilled) {
      _prefilled = true;
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is String) _emailController.text = args;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void goToLogin() {
    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
  }

  // Error shown inside the screen under the email field (null = hidden)
  String? errorMessage;

  // Success message only (errors are shown inline with showError)
  void showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void showError(String message) {
    setState(() {
      errorMessage = message;
    });
  }

  // Called when the user edits the email: the old error no longer applies
  void clearError() {
    if (errorMessage != null) {
      setState(() {
        errorMessage = null;
      });
    }
  }

  Future<void> resetPassword() async {
    if (isLoading) return;
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      await FirebaseAuthServices.resetPassword(_emailController.text.trim());

      if (!mounted) return;
      // Generic wording: Firebase may hide whether the email is registered
      showMessage(AppStrings.of(context).resetEmailSent);
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      showError(AuthHelper.messageFor(e, AppStrings.of(context)));
    } catch (_) {
      if (!mounted) return;
      showError(AppStrings.of(context).genericError);
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
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 56,
                        child: Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: CustomBackButton(
                            onTap: goToLogin,
                            backgroundColor: AppColors.white,
                            borderColor: Colors.transparent,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            strings.forgetPasswordTitle,
                            style: AppTextStyles.styleW600S22(
                              color: isDark
                                  ? AppColors.darkTextColor
                                  : AppColors.lightTextColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //forget password image
                SizedBox(height: 32),
                Image.asset(AppData.forgetPassword, width: 343, height: 343),

                SizedBox(height: 24),
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

                // Inline error; same 40px gap as before when hidden
                if (errorMessage != null) ...[
                  const SizedBox(height: 16),
                  AuthErrorMessage(message: errorMessage!),
                  const SizedBox(height: 24),
                ] else
                  SizedBox(height: 40),
                CustomElevatedButton(
                  text: strings.resetPassword,
                  isLoading: isLoading,
                  onPressed: resetPassword,
                ),
                SizedBox(height: 48),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
