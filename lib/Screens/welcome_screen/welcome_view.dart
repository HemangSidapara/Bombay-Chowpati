import 'package:bombay_chowpati/Constants/app_assets.dart';
import 'package:bombay_chowpati/Constants/app_colors.dart';
import 'package:bombay_chowpati/Routes/app_pages.dart';
import 'package:bombay_chowpati/Screens/welcome_screen/welcome_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class WelcomeView extends GetView<WelcomeController> {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.WHITE_COLOR,
        body: PageView.builder(
          controller: controller.pageController,
          itemCount: controller.welcomePageImageList.length,
          itemBuilder: (context, index) {
            return WelcomePageWidget(index: index);
          },
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget WelcomePageWidget({required int index}) {
    return Column(
      children: [
        ///Title & Subtitle
        if (index == 1) ...[
          SizedBox(height: 3.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 7.w),
            child: Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: 75.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      controller.welcomePageSubtitleList[index].tr,
                      style: TextStyle(
                        color: AppColors.WELCOME_SUBTITLE_COLOR,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      controller.welcomePageTitleList[index].tr,
                      style: TextStyle(
                        color: AppColors.BLACK_COLOR,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],

        ///Image
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 7.w),
            child: Image.asset(
              controller.welcomePageImageList[index],
            ),
          ),
        ),
        SizedBox(height: 3.h),

        ///Context & Button
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 7.w),
          child: Row(
            mainAxisAlignment: index != 1 ? MainAxisAlignment.spaceBetween : MainAxisAlignment.end,
            children: [
              ///Title & Subtitle
              if (index != 1) ...[
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.welcomePageTitleList[index].tr,
                        style: TextStyle(
                          color: AppColors.BLACK_COLOR,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        controller.welcomePageSubtitleList[index].tr,
                        style: TextStyle(
                          color: AppColors.WELCOME_SUBTITLE_COLOR,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
              ],

              ///Next Button
              InkWell(
                onTap: () {
                  if (index != 2) {
                    controller.pageController.animateToPage(
                      index + 1,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeOut,
                    );
                  } else {
                    Get.toNamed(Routes.authScreen);
                  }
                },
                borderRadius: BorderRadius.circular(99),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.symmetric(
                      vertical: BorderSide(
                        color: AppColors.PRIMARY_COLOR,
                        width: 2,
                      ),
                    ),
                    color: AppColors.PRIMARY_COLOR.withOpacity(0.25),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                  child: Center(
                    child: Image.asset(
                      AppAssets.arrowRightIcon,
                      width: 8.w,
                      color: AppColors.PRIMARY_COLOR,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 3.h),
      ],
    );
  }
}
