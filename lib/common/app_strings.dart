import 'package:flutter/material.dart';

class AppStrings {
  final bool isArabic;

  AppStrings.of(BuildContext context)
    : isArabic = Localizations.localeOf(context).languageCode == 'ar';

  String get language => isArabic ? 'اللغة' : 'Language';
  String get theme => isArabic ? 'المظهر' : 'Theme';
  String get english => isArabic ? 'الإنجليزية' : 'English';
  String get arabic => isArabic ? 'العربية' : 'Arabic';

  String get letsStart => isArabic ? 'لنبدأ' : "Let's start";
  String get next => isArabic ? 'التالي' : 'Next';
  String get getStarted => isArabic ? 'ابدأ الآن' : 'Get started';
  String get skip => isArabic ? 'تخطي' : 'Skip';

  // Shared
  String get or => isArabic ? 'أو' : 'Or';
  String get cancel => isArabic ? 'إلغاء' : 'Cancel';
  String get confirm => isArabic ? 'تأكيد' : 'Confirm';
  String get delete => isArabic ? 'حذف' : 'Delete';
  String get description => isArabic ? 'الوصف' : 'Description';
  String get user => isArabic ? 'مستخدم' : 'User';
  String get genericError => isArabic
      ? 'حدث خطأ ما. يرجى المحاولة مرة أخرى.'
      : 'Something went wrong. Please try again.';

  // Auth: fields and validation
  String get enterEmail =>
      isArabic ? 'أدخل بريدك الإلكتروني' : 'Enter your email';
  String get emailRequired =>
      isArabic ? 'يرجى إدخال بريدك الإلكتروني' : 'Please enter your email';
  String get enterPassword =>
      isArabic ? 'أدخل كلمة المرور' : 'Enter your password';
  String get passwordRequired =>
      isArabic ? 'يرجى إدخال كلمة المرور' : 'Please enter your password';
  String get enterName => isArabic ? 'أدخل اسمك' : 'Enter your name';
  String get usernameRequired =>
      isArabic ? 'يرجى إدخال اسم المستخدم' : 'Please enter your username';
  String get confirmPasswordHint =>
      isArabic ? 'أكد كلمة المرور' : 'confirm your password';
  String get confirmPasswordRequired =>
      isArabic ? 'يرجى تأكيد كلمة المرور' : 'Please confirm your password';
  String get passwordsDoNotMatch =>
      isArabic ? 'كلمتا المرور غير متطابقتين' : 'Passwords do not match';

  // Login
  String get loginTitle =>
      isArabic ? 'سجّل الدخول إلى حسابك' : 'Login to your account';
  String get forgetPasswordLink =>
      isArabic ? 'نسيت كلمة المرور؟ ' : 'Forget Password? ';
  String get login => isArabic ? 'تسجيل الدخول' : 'Login';
  String get noAccount =>
      isArabic ? 'ليس لديك حساب؟ ' : "Don't have an account? ";
  String get signupLink => isArabic ? 'إنشاء حساب ' : 'Signup ';
  String get loginWithGoogle =>
      isArabic ? 'تسجيل الدخول باستخدام Google' : 'Login with Google';
  String get googleLoginFailed => isArabic
      ? 'فشل تسجيل الدخول باستخدام Google. يرجى المحاولة مرة أخرى.'
      : 'Google login failed. Please try again.';

  // Sign up
  String get registerTitle => isArabic ? 'أنشئ حسابك' : 'Create your account';
  String get signUp => isArabic ? 'إنشاء حساب' : 'Sign UP';
  String get haveAccount =>
      isArabic ? 'لديك حساب بالفعل؟' : 'Already have an account?';
  String get loginLink => isArabic ? 'تسجيل الدخول ' : 'Login ';
  String get signUpWithGoogle =>
      isArabic ? 'إنشاء حساب باستخدام Google' : 'Sign up with Google';
  String get googleSignUpFailed => isArabic
      ? 'فشل التسجيل باستخدام Google. يرجى المحاولة مرة أخرى.'
      : 'Google sign-in failed. Please try again.';
  String get createAccountFailed => isArabic
      ? 'تعذّر إنشاء الحساب. يرجى المحاولة مرة أخرى.'
      : 'Could not create account. Please try again.';

  // Forget password
  String get forgetPasswordTitle =>
      isArabic ? 'نسيت كلمة المرور' : 'Forget Password';
  String get resetPassword =>
      isArabic ? 'إعادة تعيين كلمة المرور' : 'Reset Password';
  String get resetEmailSent => isArabic
      ? 'إذا كان هناك حساب مرتبط بهذا البريد، فقد تم إرسال رابط إعادة تعيين كلمة المرور.'
      : 'If an account exists for this email, a password reset link has been sent.';

  // Firebase auth errors
  String get invalidEmail => isArabic
      ? 'يرجى إدخال بريد إلكتروني صالح.'
      : 'Please enter a valid email address.';
  String get userDisabled =>
      isArabic ? 'تم تعطيل هذا الحساب.' : 'This account has been disabled.';
  String get wrongCredentials => isArabic
      ? 'البريد الإلكتروني أو كلمة المرور غير صحيحة.'
      : 'The email or password is incorrect.';
  String get emailInUse => isArabic
      ? 'هذا البريد الإلكتروني مسجّل بالفعل.'
      : 'This email is already registered.';
  String get weakPassword => isArabic
      ? 'كلمة المرور لا تستوفي الحد الأدنى من المتطلبات (6 أحرف على الأقل).'
      : 'The password does not meet the minimum requirements (at least 6 characters).';
  String get passwordRequirements => isArabic
      ? 'كلمة المرور لا تستوفي متطلبات الأمان.'
      : 'Password does not meet the security requirements.';
  String get differentCredential => isArabic
      ? 'هذا البريد مرتبط بطريقة تسجيل دخول أخرى.'
      : 'This email is already linked to a different sign-in method.';
  String get methodNotEnabled => isArabic
      ? 'طريقة تسجيل الدخول هذه غير مفعّلة.'
      : 'This sign-in method is not enabled.';
  String get tooManyRequests => isArabic
      ? 'محاولات كثيرة جدًا. يرجى المحاولة لاحقًا.'
      : 'Too many attempts. Please try again later.';
  String get networkError => isArabic
      ? 'حدثت مشكلة في الاتصال بالشبكة. يرجى المحاولة مرة أخرى.'
      : 'A network connection problem occurred. Please try again.';

  // Firestore (user profile) errors, kept separate from Auth errors
  String get profileSaveFailed => isArabic
      ? 'تم إنشاء حسابك، لكن تعذّر حفظ بيانات ملفك الشخصي. يرجى تسجيل الدخول لإكمال الإعداد.'
      : 'Your account was created, but your profile could not be saved. Please log in to finish setting it up.';
  String get profileLoadFailed => isArabic
      ? 'تعذّر تحميل بيانات حسابك. يرجى المحاولة مرة أخرى.'
      : 'Could not load your account data. Please try again.';

}
