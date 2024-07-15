import 'package:bombay_chowpati/Constants/app_assets.dart';
import 'package:bombay_chowpati/Constants/app_colors.dart';
import 'package:bombay_chowpati/Constants/app_strings.dart';
import 'package:bombay_chowpati/Widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Future<void> showUpdateDialog({
  required void Function() onUpdate,
}) async {
  await showGeneralDialog(
    context: Get.context!,
    barrierDismissible: false,
    useRootNavigator: true,
    barrierLabel: 'string',
    barrierColor: AppColors.TRANSPARENT,
    transitionDuration: const Duration(milliseconds: 350),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween(
          begin: const Offset(0, 1),
          end: const Offset(0, 0),
        ).animate(animation),
        child: child,
      );
    },
    pageBuilder: (context, animation, secondaryAnimation) {
      return PopScope(
        canPop: false,
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: AppColors.PRODUCT_BACKGROUND_COLOR,
          surfaceTintColor: AppColors.WHITE_COLOR,
          contentPadding: EdgeInsets.symmetric(horizontal: 2.w),
          content: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.PRODUCT_BACKGROUND_COLOR,
            ),
            height: 35.h,
            width: 80.w,
            clipBehavior: Clip.hardEdge,
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  AppAssets.updateAnim,
                  height: 10.h,
                ),
                SizedBox(height: 2.h),
                Text(
                  AppStrings.newVersionAvailable.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.PRIMARY_COLOR,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                ButtonWidget(
                  onPressed: onUpdate,
                  buttonTitle: AppStrings.update.tr,
                ),
                SizedBox(height: 2.h),
              ],
            ),
          ),
        ),
      );
    },
  );
}
