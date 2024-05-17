import 'package:bombay_chowpati/Constants/app_assets.dart';
import 'package:bombay_chowpati/Constants/app_colors.dart';
import 'package:bombay_chowpati/Screens/home_screen/dashboard_screen/dashboard_view.dart';
import 'package:bombay_chowpati/Screens/home_screen/settings_screen/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt bottomIndex = 0.obs;
  PageController pageController = PageController(initialPage: 0);
  RxBool isLatestVersionAvailable = false.obs;
  RxString newAPKUrl = ''.obs;
  RxString newAPKVersion = ''.obs;

  RxList<String> listOfImages = [
    AppAssets.homeIcon,
    AppAssets.settingsIcon,
  ].obs;

  RxList<Widget> bottomItemWidgetList = [
    const DashboardView(),
    const SettingsView(),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.SECONDARY_COLOR,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: AppColors.SECONDARY_COLOR,
        statusBarBrightness: Brightness.light,
      ),
    );
  }

  Future<void> onBottomItemChange({required int index}) async {
    bottomIndex.value = index;
    if (index == 0) {
      if (Get.keys[0]?.currentState?.canPop() == true) {
        Get.back(id: 0);
      }
    } else if (index == 1) {
      if (Get.keys[1]?.currentState?.canPop() == true) {
        Get.back(id: 1);
      }
    }
    pageController.jumpToPage(bottomIndex.value);
  }
}
