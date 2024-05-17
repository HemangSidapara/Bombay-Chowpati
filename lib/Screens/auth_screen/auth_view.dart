import 'package:bombay_chowpati/Constants/app_assets.dart';
import 'package:bombay_chowpati/Constants/app_colors.dart';
import 'package:bombay_chowpati/Constants/app_strings.dart';
import 'package:bombay_chowpati/Constants/app_utils.dart';
import 'package:bombay_chowpati/Routes/nested_navigator/sign_in_navigator.dart';
import 'package:bombay_chowpati/Screens/auth_screen/auth_controller.dart';
import 'package:bombay_chowpati/Screens/auth_screen/sign_up_screen/sign_up_view.dart';
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
          if (Get.keys[0]?.currentState?.canPop() == true) {
            Get.back(id: 0);
            if (Get.keys[0]?.currentState?.canPop() == true) {
              controller.canPopSignInNavigator(true);
            } else {
              controller.canPopSignInNavigator(false);
            }
          } else if (!didPop) {
            Get.back(closeOverlays: true);
          }
        },
        child: SafeArea(
          child: GestureDetector(
            onTap: () => Utils.unfocus(),
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: Size(double.maxFinite, 25.h),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.WHITE_COLOR,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12.withOpacity(0.1),
                        blurRadius: 15,
                        spreadRadius: 10,
                      )
                    ],
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      ///Login Image
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        child: Image.asset(
                          AppAssets.loginImage,
                          width: 20.w,
                        ),
                      ),
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
              body: Column(
                children: [
                  Expanded(
                    child: TabBarView(
                      controller: controller.tabController,
                      children: const [
                        SignInNavigator(),
                        SignUpView(),
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
