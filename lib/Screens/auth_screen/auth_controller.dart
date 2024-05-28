import 'package:bombay_chowpati/Constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AuthController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  RxBool canPopSignInNavigator = true.obs;
  RxInt tabIndex = 0.obs;

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
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      tabIndex(tabController.index);
    });
  }
}
