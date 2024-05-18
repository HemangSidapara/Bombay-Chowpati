import 'dart:async';

import 'package:bombay_chowpati/Constants/app_colors.dart';
import 'package:bombay_chowpati/Constants/app_constance.dart';
import 'package:bombay_chowpati/Constants/app_utils.dart';
import 'package:bombay_chowpati/Constants/get_storage.dart';
import 'package:bombay_chowpati/Network/services/utils_services/get_package_info_service.dart';
import 'package:bombay_chowpati/Routes/app_pages.dart';
import 'package:bombay_chowpati/Utils/in_app_update_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  RxString newAPKUrl = ''.obs;
  RxString newAPKVersion = ''.obs;
  RxBool isUpdateLoading = false.obs;
  RxInt downloadedProgress = 0.obs;
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

    await _getLatestVersion().then((value) {
      newAPKUrl(value.$1 ?? '');
      newAPKVersion(value.$2 ?? '');
    });

    await Future.delayed(
      const Duration(milliseconds: 600),
      () {
        newAPKUrl.addListener(GetStream(
          onListen: () async {
            currentVersion.value = (await GetPackageInfoService.instance.getInfo()).version;
            debugPrint('currentVersion :: ${currentVersion.value}');
            debugPrint('newVersion :: ${newAPKVersion.value}');
            if (newAPKUrl.value.isNotEmpty && newAPKVersion.value.isNotEmpty) {
              if (Utils.isUpdateAvailable(currentVersion.value, newAPKVersion.value)) {
                await showUpdateDialog(
                  onUpdate: () async {},
                  isUpdateLoading: isUpdateLoading,
                  downloadedProgress: downloadedProgress,
                );
              } else {
                nextScreenRoute();
              }
            } else {
              nextScreenRoute();
            }
          },
        ));
      },
    );
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

  /// Get latest Version on server
  Future<(String?, String?)> _getLatestVersion() async {
    return (null, null);
  }
}
