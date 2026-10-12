import 'package:evently_app/onboarding/onbarding_model.dart';
import 'package:evently_app/home/models/category_model.dart';
import 'package:evently_app/home/models/event_model.dart';
import 'package:flutter/widgets.dart';

class AppData {
  static const evently = "assets/images/Evently.png";
  static const logoSplash = "assets/images/Logo.png";

  //onboarding Assets
  static const onboarding1 = "assets/images/being-creative1.png";
  static const onboarding2 = "assets/images/being-creative2.png";
  static const onboarding3 = "assets/images/being-creative3.png";
  static const onboarding4 = "assets/images/being-creative4.png";

  static const onboarding1Dark = "assets/images/being-creative1dark.png";
  static const onboarding2Dark = "assets/images/being-creative2dark.png";
  static const onboarding3Dark = "assets/images/being-creative3dark.png";
  static const onboarding4Dark = "assets/images/being-creative4dark.png";

  static List<OnboardingModel> onboardingData = [
    OnboardingModel(
      image: onboarding1,
      darkImage: onboarding1Dark,
      title: 'Personalize Your Experience',
      titleAr: 'خصص تجربتك',
      description:
          'Choose your preferred theme and language to get started with a '
          'comfortable, tailored experience that suits your style.',
      descriptionAr:
          'اختر المظهر واللغة المفضلين لديك لتبدأ تجربة مريحة ومصممة '
          'خصيصًا لتناسب أسلوبك.',
    ),
    OnboardingModel(
      image: onboarding2,
      darkImage: onboarding2Dark,
      title: 'Find Events That Inspire You',
      titleAr: 'اكتشف فعاليات تلهمك',
      description:
          "Dive into a world of events crafted to fit your unique interests. "
          "Whether you're into live music, art workshops, professional "
          "networking, or simply discovering new experiences, we have "
          "something for everyone. Our curated recommendations will help you "
          "explore, connect, and make the most of every opportunity around you.",
      descriptionAr:
          'انطلق في عالم من الفعاليات المصممة لتناسب اهتماماتك الفريدة. '
          'سواء كنت تحب الموسيقى الحية أو ورش العمل الفنية أو التواصل المهني '
          'أو ببساطة اكتشاف تجارب جديدة، لدينا ما يناسب الجميع. ستساعدك '
          'توصياتنا المختارة على الاستكشاف والتواصل والاستفادة القصوى من كل '
          'فرصة من حولك.',
    ),
    OnboardingModel(
      image: onboarding3,
      darkImage: onboarding3Dark,
      title: 'Effortless Event Planning',
      titleAr: 'تخطيط فعاليات بلا عناء',
      description:
          "Take the hassle out of organizing events with our all-in-one "
          "planning tools. From setting up invites and managing RSVPs to "
          "scheduling reminders and coordinating details, we've got you "
          "covered. Plan with ease and focus on what matters – creating an "
          "unforgettable experience for you and your guests.",
      descriptionAr:
          'تخلص من عناء تنظيم الفعاليات مع أدوات التخطيط الشاملة لدينا. '
          'من إعداد الدعوات وإدارة الردود إلى جدولة التذكيرات وتنسيق '
          'التفاصيل، نحن نتكفل بكل شيء. خطط بسهولة وركز على ما يهم – '
          'صناعة تجربة لا تُنسى لك ولضيوفك.',
    ),
    OnboardingModel(
      image: onboarding4,
      darkImage: onboarding4Dark,
      title: 'Connect with Friends & Share Moments',
      titleAr: 'تواصل مع أصدقائك وشارك اللحظات',
      description:
          'Make every event memorable by sharing the experience with others. '
          'Our platform lets you invite friends, keep everyone in the loop, '
          'and celebrate moments together. Capture and share the excitement '
          'with your network, so you can relive the highlights and cherish '
          'the memories.',
      descriptionAr:
          'اجعل كل فعالية لا تُنسى بمشاركة التجربة مع الآخرين. تتيح لك '
          'منصتنا دعوة أصدقائك وإبقاء الجميع على اطلاع والاحتفال باللحظات '
          'معًا. التقط الحماس وشاركه مع شبكتك لتستعيد أبرز اللحظات وتحتفظ '
          'بالذكريات.',
    ),
  ];

  //login Assets
  static const email = "assets/icons/sms.svg";
  static const password = "assets/icons/lock.svg";
  static const eyeToggle = "assets/icons/eye-slash.svg";

  static const google = "assets/images/google.png";

  //Signup ASsets
  static const user = "assets/icons/user.svg";

  //forget password assets
  static const forgetPassword = "assets/images/change-setting.png";

  //home Asset
  static const home = "assets/icons/home-2.svg";
  static const favourite = "assets/icons/heart.svg";
  static const favouriteFilled = "assets/icons/heart-filled.svg";

  static const all = "assets/icons/all.svg";
  static const birthday = "assets/icons/birthday-cake.svg";
  static const sport = "assets/icons/sport.svg";
  static const book = "assets/icons/book.svg";

  static const birthdayBgLight = "assets/images/birthdaylight.png";
  static const mettingBgLight = "assets/images/meetinglight.png";
  static const exhibitionBgLight = "assets/images/exhibitionlight.png";
  static const sportBgLight = "assets/images/sportlight.png";
  static const bookClubBgLight = "assets/images/bookclublight.png";

  static const birthdayBgDark = "assets/images/birthdaydark.png";
  static const mettingBgDark = "assets/images/meetingdark.png";
  static const exhibitionBgDark = "assets/images/exhibitiondark.png";
  static const sportBgDark = "assets/images/sportdark.png";
  static const bookClubBgDark = "assets/images/bookclubdark.png";

  static const List<CategoryModel> categories = [
    CategoryModel(icon: AppData.all, title: 'All'),

    CategoryModel(icon: AppData.birthday, title: 'Birthday'),
    CategoryModel(icon: AppData.sport, title: 'Sport'),

    CategoryModel(icon: AppData.book, title: 'Book Club'),
    CategoryModel(icon: AppData.home, title: 'Meeting'),
    CategoryModel(icon: AppData.favourite, title: 'Exhibition'),
  ];

  static List<EventModel> events = [];

  //favourite screen
  static const search = "assets/icons/search.svg";

  //profile screen
  static const logout = "assets/icons/logout.svg";

  // Add event categories
  static const List<CategoryModel> addEventCategories = [
    CategoryModel(icon: AppData.birthday, title: 'Birthday'),
    CategoryModel(icon: AppData.sport, title: 'Sport'),
    CategoryModel(icon: AppData.book, title: 'Book Club'),
    CategoryModel(icon: AppData.home, title: 'Meeting'),
    CategoryModel(icon: AppData.favourite, title: 'Exhibition'),
  ];

  //event details screen
  static const edit = "assets/icons/edit.svg";
  static const delete = "assets/icons/trash.svg";

  static final ValueNotifier<int> eventsRevision = ValueNotifier<int>(0);
  static void notifyEventsChanged() {
    eventsRevision.value++;
  }
}
