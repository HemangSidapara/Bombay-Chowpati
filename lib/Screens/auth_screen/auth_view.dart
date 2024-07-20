import 'dart:io';

import 'package:bombay_chowpati/Constants/app_assets.dart';
import 'package:bombay_chowpati/Constants/app_colors.dart';
import 'package:bombay_chowpati/Constants/app_constance.dart';
import 'package:bombay_chowpati/Constants/app_strings.dart';
import 'package:bombay_chowpati/Constants/app_utils.dart';
import 'package:bombay_chowpati/Routes/nested_navigator/sign_in_navigator.dart';
import 'package:bombay_chowpati/Routes/nested_navigator/sign_up_navigator.dart';
import 'package:bombay_chowpati/Screens/auth_screen/auth_controller.dart';
import 'package:bombay_chowpati/Utils/app_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return PopScope(
        canPop: controller.canPopSignInNavigator.isFalse,
        onPopInvoked: (didPop) {
          if (Get.keys[AppConstance.signInNavigatorKey.getNavigatorId]?.currentState?.canPop() == true) {
            Get.back(id: AppConstance.signInNavigatorKey.getNavigatorId);
            if (Get.keys[AppConstance.signInNavigatorKey.getNavigatorId]?.currentState?.canPop() == true) {
              controller.canPopSignInNavigator(true);
            } else {
              controller.canPopSignInNavigator(false);
            }
          } else if (Get.keys[AppConstance.signUpNavigatorKey.getNavigatorId]?.currentState?.canPop() == true) {
            Get.back(id: AppConstance.signUpNavigatorKey.getNavigatorId);
          } else if (!didPop) {
            Get.back(closeOverlays: true);
          }
        },
        child: GestureDetector(
          onTap: () => Utils.unfocus(),
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size(double.maxFinite, 25.h),
              child: Container(
                padding: EdgeInsets.only(top: 5.h),
                decoration: BoxDecoration(
                  color: AppColors.WHITE_COLOR,
                  boxShadow: [
                    if (Platform.isAndroid)
                      BoxShadow(
                        color: Colors.black12.withOpacity(0.1),
                        blurRadius: 15,
                        spreadRadius: 10,
                      ),
                    if (Platform.isIOS)
                      BoxShadow(
                        color: Colors.black12.withOpacity(0.05),
                        blurRadius: 30,
                        spreadRadius: 8,
                      ),
                  ],
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    ///Login Image
                    Obx(() {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.h),
                        child: AnimatedCrossFade(
                          crossFadeState: controller.tabIndex.value == 0 ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                          duration: const Duration(milliseconds: 300),
                          firstChild: Image.asset(
                            AppAssets.loginImage,
                            height: 12.h,
                          ),
                          secondChild: Image.asset(
                            AppAssets.createAccountIcon,
                            height: 12.h,
                          ),
                        ),
                      );
                    }),
                    const Spacer(),

                    ///Tabs
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: TabBar(
                        controller: controller.tabController,
                        dividerColor: AppColors.TRANSPARENT,
                        tabAlignment: TabAlignment.fill,
                        labelPadding: EdgeInsets.only(bottom: 1.h),
                        indicator: UnderlineTabIndicator(
                          borderSide: BorderSide(
                            color: AppColors.DARK_GREEN_COLOR,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(99),
                        ),
                        indicatorPadding: EdgeInsets.symmetric(horizontal: 8.w),
                        indicatorSize: TabBarIndicatorSize.tab,
                        onTap: (value) {
                          Utils.unfocus();
                        },
                        tabs: [
                          Text(
                            AppStrings.login.tr,
                            style: TextStyle(
                              color: AppColors.BLACK_COLOR,
                              fontWeight: FontWeight.w600,
                              fontSize: 18.sp,
                            ),
                          ),
                          Text(
                            AppStrings.signUp,
                            style: TextStyle(
                              color: AppColors.BLACK_COLOR,
                              fontWeight: FontWeight.w600,
                              fontSize: 18.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: TabBarView(
                      controller: controller.tabController,
                      children: const [
                        SignInNavigator(),
                        SignUpNavigator(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
