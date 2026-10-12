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

}
