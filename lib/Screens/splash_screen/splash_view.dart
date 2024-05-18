import 'package:bombay_chowpati/Constants/app_assets.dart';
import 'package:bombay_chowpati/Constants/app_colors.dart';
import 'package:bombay_chowpati/Constants/app_constance.dart';
import 'package:bombay_chowpati/Constants/app_strings.dart';
import 'package:bombay_chowpati/Screens/splash_screen/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.SECONDARY_COLOR,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      AppAssets.splashImage,
                      height: 50.h,
                    ),
                  ),
                  Center(
                    child: Text(
                      AppStrings.appName.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.PRIMARY_COLOR,
                        fontWeight: FontWeight.w600,
                        fontSize: 23.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Obx(() {
              return Text(
                AppConstance.appVersion.replaceAll('1.0.0', controller.currentVersion.value),
                style: TextStyle(
                  color: AppColors.HINT_GREY_COLOR.withOpacity(0.55),
                  fontWeight: FontWeight.w700,
                  fontSize: 14.sp,
                ),
              );
            }),
            Text(
              AppStrings.poweredByMindwaveInfoway,
              style: TextStyle(
                color: AppColors.HINT_GREY_COLOR.withOpacity(0.55),
                fontWeight: FontWeight.w700,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }
}
