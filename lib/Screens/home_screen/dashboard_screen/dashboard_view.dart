import 'package:bombay_chowpati/Constants/app_colors.dart';
import 'package:bombay_chowpati/Constants/app_strings.dart';
import 'package:bombay_chowpati/Screens/home_screen/dashboard_screen/dashboard_controller.dart';
import 'package:bombay_chowpati/Screens/home_screen/dashboard_screen/hand_shaken_animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
      child: Column(
        children: [
          ///Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.hello.tr,
                      style: TextStyle(
                        color: AppColors.PRIMARY_COLOR.withOpacity(0.8),
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const HandShakenAnimation(),
                  ],
                ),
              ),
              SizedBox(width: 2.w),
            ],
          ),
          SizedBox(height: 2.h),
        ],
      ),
    );
  }
}
