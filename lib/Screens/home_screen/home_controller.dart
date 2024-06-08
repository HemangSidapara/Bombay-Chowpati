import 'package:bombay_chowpati/Constants/app_assets.dart';
import 'package:bombay_chowpati/Constants/app_colors.dart';
import 'package:bombay_chowpati/Constants/app_constance.dart';
import 'package:bombay_chowpati/Network/models/auth_models/get_user_details_model.dart';
import 'package:bombay_chowpati/Network/services/auth_services/auth_services.dart';
import 'package:bombay_chowpati/Routes/nested_navigator/settings_navigator.dart';
import 'package:bombay_chowpati/Screens/home_screen/cart_screen/cart_view.dart';
import 'package:bombay_chowpati/Screens/home_screen/dashboard_screen/dashboard_view.dart';
import 'package:bombay_chowpati/Screens/home_screen/order_history_screen/order_history_view.dart';
import 'package:bombay_chowpati/Utils/app_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt bottomIndex = 0.obs;
  PageController pageController = PageController(initialPage: 0);
  RxBool isLatestVersionAvailable = false.obs;
  RxString newAPKUrl = ''.obs;
  RxString newAPKVersion = ''.obs;

  Rx<GetUserDetailsModel> getUserDetails = Rx(GetUserDetailsModel());

  RxList<String> listOfImages = [
    AppAssets.homeIcon,
    AppAssets.favouriteIcon,
    AppAssets.cartIcon,
    AppAssets.settingsIcon,
  ].obs;

  RxList<Widget> bottomItemWidgetList = [
    DashboardView(),
    const OrderHistoryView(),
    CartView(),
    const SettingsNavigator(),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.SECONDARY_COLOR,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: AppColors.WHITE_COLOR,
        statusBarBrightness: Brightness.light,
      ),
    );
    pageController.addListener(() {
      if (bottomIndex.value == 3) {
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
            systemNavigationBarColor: AppColors.SECONDARY_COLOR,
            systemNavigationBarIconBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: AppColors.SETTING_BG_COLOR,
            statusBarBrightness: Brightness.light,
          ),
        );
      } else {
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
            systemNavigationBarColor: AppColors.SECONDARY_COLOR,
            systemNavigationBarIconBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: AppColors.WHITE_COLOR,
            statusBarBrightness: Brightness.light,
          ),
        );
      }
    });

    getUserDetailsApiCall();
  }

  Future<void> onBottomItemChange({required int index}) async {
    bottomIndex.value = index;
    if (index == 3) {
      if (Get.keys[AppConstance.settingsNavigatorKey.getNavigatorId]?.currentState?.canPop() == true) {
        Get.back(id: AppConstance.settingsNavigatorKey.getNavigatorId);
      }
    }
    pageController.jumpToPage(bottomIndex.value);
  }

  Future<void> getUserDetailsApiCall() async {
    final response = await AuthServices.getUserDetailsService();
    if (response.isSuccess) {
      getUserDetails(GetUserDetailsModel.fromJson(response.response?.data));
    }
  }
}
