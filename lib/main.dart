import 'package:bombay_chowpati/Constants/app_colors.dart';
import 'package:bombay_chowpati/Constants/app_constance.dart';
import 'package:bombay_chowpati/Constants/app_fonts.dart';
import 'package:bombay_chowpati/Constants/app_strings.dart';
import 'package:bombay_chowpati/Constants/get_storage.dart';
import 'package:bombay_chowpati/Localization/localization.dart';
import 'package:bombay_chowpati/Routes/app_pages.dart';
import 'package:bombay_chowpati/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  GetStorage.init();
  GetStorage.init('Welcome');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppStrings.appName,
          translations: Localization(),
          locale: getString(AppConstance.languageCode) != null && getString(AppConstance.languageCode) != '' && getString(AppConstance.languageCountryCode) != null && getString(AppConstance.languageCountryCode) != '' ? Locale(getString(AppConstance.languageCode) ?? Get.deviceLocale?.languageCode ?? 'en', getString(AppConstance.languageCountryCode)) : Get.deviceLocale,
          fallbackLocale: const Locale('en', 'IN'),
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.SECONDARY_COLOR,
            primaryColor: AppColors.PRIMARY_COLOR,
            fontFamily: AppFonts.appFontFamily,
            datePickerTheme: DatePickerThemeData(
              headerBackgroundColor: AppColors.SECONDARY_COLOR,
            ),
            useMaterial3: true,
            textSelectionTheme: TextSelectionThemeData(
              selectionHandleColor: AppColors.DARK_GREEN_COLOR,
            ),
          ),
          initialRoute: Routes.splashScreen,
          defaultTransition: Transition.downToUp,
          getPages: AppPages.pages,
        );
      },
    );
  }
}
