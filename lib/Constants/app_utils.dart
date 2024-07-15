import 'package:bombay_chowpati/Constants/app_colors.dart';
import 'package:bombay_chowpati/Constants/app_constance.dart';
import 'package:bombay_chowpati/Utils/app_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

extension GetKeyboardPadding on BuildContext {
  dynamic get getKeyboardPadding {
    return MediaQuery.viewInsetsOf(this).bottom;
  }
}

class Utils {
  ///Set Welcome Screen Seen
  static Future<void> setWelcomeSeen() async {
    await GetStorage('Welcome').write(AppConstance.isWelcomeSeen, true);
  }

  ///Get Welcome Screen Seen
  static bool? getWelcomeSeen() {
    return GetStorage('Welcome').read(AppConstance.isWelcomeSeen);
  }

  ///Unfocus
  static void unfocus() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  /// Current app is latest or not
  static bool isUpdateAvailable({required String currentVersion, required String newAPKVersion}) {
    List<String> versionNumberList = currentVersion.split('.').toList();
    List<String> storeVersionNumberList = newAPKVersion.split('.').toList();
    for (int i = 0; i < versionNumberList.length; i++) {
      if (versionNumberList[i].toInt() != storeVersionNumberList[i].toInt()) {
        if (versionNumberList[i].toInt() < storeVersionNumberList[i].toInt()) {
          return true;
        } else {
          return false;
        }
      }
    }
    return false;
  }

  ///showSnackBar
  static void handleMessage({
    String? message,
    bool isError = false,
    bool isWarning = false,
    Color? barColor,
    Color? iconColor,
    Color? textColor,
  }) {
    if (!Get.isSnackbarOpen) {
      Get.rawSnackbar(
        margin: EdgeInsets.only(bottom: 12.w + 1.h, left: 5.w, right: 5.w),
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(milliseconds: 2000),
        backgroundColor: barColor ??
            (isError
                ? AppColors.ERROR_COLOR
                : isWarning
                    ? AppColors.WARNING_COLOR
                    : AppColors.SUCCESS_COLOR),
        borderRadius: 12,
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
        messageText: Row(
          children: [
            Icon(
              isError
                  ? Icons.error_rounded
                  : isWarning
                      ? Icons.warning_rounded
                      : Icons.check_circle_rounded,
              color: iconColor ?? AppColors.WHITE_COLOR,
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: Text(
                message ?? 'Empty message',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: textColor ?? AppColors.WHITE_COLOR,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
