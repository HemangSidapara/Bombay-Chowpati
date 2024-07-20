import 'dart:async';
import 'dart:io';

import 'package:bombay_chowpati/Constants/app_colors.dart';
import 'package:bombay_chowpati/Constants/app_constance.dart';
import 'package:bombay_chowpati/Constants/app_utils.dart';
import 'package:bombay_chowpati/Constants/get_storage.dart';
import 'package:bombay_chowpati/Network/services/utils_services/get_package_info_service.dart';
import 'package:bombay_chowpati/Network/services/utils_services/update_app_service.dart';
import 'package:bombay_chowpati/Routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SplashController extends GetxController {
  RxString currentVersion = ''.obs;

  @override
  void onInit() async {
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

    Stopwatch stopwatch = Stopwatch()..start();

    await UpdateAppService().getStoreVersion(context: Get.context!).then((value) async {
      if (Platform.isAndroid) {
        currentVersion.value = (await GetPackageInfoService.getInfo()).version;
      } else if (Platform.isIOS) {
        currentVersion.value = (await PackageInfo.fromPlatform()).version;
      }
      await Future.delayed(
        Duration(milliseconds: stopwatch.elapsed.inSeconds < 3 ? 2500 - stopwatch.elapsedMilliseconds : 0),
        () {
          nextScreenRoute();
        },
      );
    });
  }

  /// Next Screen Route
  Future<void> nextScreenRoute() async {
    debugPrint("token value ::: ${getData(AppConstance.authorizationToken)}");
    if (getData(AppConstance.authorizationToken) == null) {
      if (Utils.getWelcomeSeen() == true) {
        Get.offAllNamed(Routes.authScreen);
      } else {
        Get.offAllNamed(Routes.welcomeScreen);
      }
    } else {
      Get.offAllNamed(Routes.homeScreen);
    }
  }
}
