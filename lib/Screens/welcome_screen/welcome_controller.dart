import 'package:bombay_chowpati/Constants/app_assets.dart';
import 'package:bombay_chowpati/Constants/app_colors.dart';
import 'package:bombay_chowpati/Constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class WelcomeController extends GetxController {
  PageController pageController = PageController();

  List<String> welcomePageImageList = [
    AppAssets.welcomePageOneImage,
    AppAssets.welcomePageTwoImage,
    AppAssets.welcomePageThreeImage,
  ];

  List<String> welcomePageTitleList = [
    AppStrings.welcomePageTitleOne,
    AppStrings.welcomePageTitleTwo,
    AppStrings.welcomePageTitleThree,
  ];

  List<String> welcomePageSubtitleList = [
    AppStrings.welcomePageSubtitleOneTwo,
    AppStrings.welcomePageSubtitleOneTwo,
    AppStrings.welcomePageSubtitleThree,
  ];

  @override
  void onInit() {
    super.onInit();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.WHITE_COLOR,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: AppColors.WHITE_COLOR,
        statusBarBrightness: Brightness.light,
      ),
    );
  }
}
