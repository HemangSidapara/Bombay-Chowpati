import 'package:bombay_chowpati/Constants/app_colors.dart';
import 'package:bombay_chowpati/Constants/app_constance.dart';
import 'package:bombay_chowpati/Constants/app_strings.dart';
import 'package:bombay_chowpati/Screens/home_screen/home_controller.dart';
import 'package:bombay_chowpati/Utils/app_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (Get.keys[AppConstance.settingsNavigatorKey.getNavigatorId]?.currentState?.canPop() == true) {
          Get.back(id: AppConstance.settingsNavigatorKey.getNavigatorId);
        } else if (!didPop) {
          if (controller.bottomIndex.value != 0) {
            controller.onBottomItemChange(index: 0);
          } else {
            await showExitDialog(context);
          }
        }
      },
      child: SafeArea(
        child: Obx(() {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: controller.bottomIndex.value == 3 ? AppColors.SETTING_BG_COLOR : AppColors.WHITE_COLOR,
            bottomNavigationBar: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.SECONDARY_COLOR,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 0.5.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (int i = 0; i < controller.bottomItemWidgetList.length; i++)
                      SizedBox(
                        width: 100.w / controller.bottomItemWidgetList.length,
                        child: AssetImages(
                          index: i,
                          iconName: controller.listOfImages[i],
                        ),
                      ),
                  ],
                ),
              ),
            ),
            body: PageView(
              controller: controller.pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: controller.bottomItemWidgetList,
            ),
          );
        }),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget AssetImages({
    required int index,
    required String iconName,
  }) {
    return InkWell(
      onTap: () async {
        await controller.onBottomItemChange(index: index);
      },
      child: SizedBox(
        height: 12.w,
        width: 12.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() {
              return Image.asset(
                iconName,
                width: index == 3 ? 9.3.w : 8.w,
                color: controller.bottomIndex.value == index ? AppColors.PRIMARY_COLOR : AppColors.BLACK_COLOR,
              );
            }),
          ],
        ),
      ),
    );
  }

  Future<void> showExitDialog(BuildContext context) async {
    await showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'string',
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
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: AppColors.WHITE_COLOR,
          surfaceTintColor: AppColors.WHITE_COLOR,
          contentPadding: EdgeInsets.symmetric(horizontal: 2.w),
          content: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.WHITE_COLOR,
            ),
            height: 25.h,
            width: 80.w,
            clipBehavior: Clip.hardEdge,
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.exit_to_app_rounded,
                  color: AppColors.WARNING_COLOR,
                  size: 8.w,
                ),
                SizedBox(height: 2.h),
                Text(
                  AppStrings.areYouSureYouWantToExitTheApp.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.ERROR_COLOR,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ///No
                    ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.DARK_GREEN_COLOR,
                        fixedSize: Size(27.w, 5.h),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        AppStrings.no.tr,
                        style: TextStyle(
                          color: AppColors.SECONDARY_COLOR,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    ///Yes, exit
                    ElevatedButton(
                      onPressed: () async {
                        await SystemNavigator.pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.DARK_RED_COLOR,
                        fixedSize: Size(33.w, 5.h),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        AppStrings.yesExit.tr,
                        style: TextStyle(
                          color: AppColors.SECONDARY_COLOR,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 1.h),
              ],
            ),
          ),
        );
      },
    );
  }
}
