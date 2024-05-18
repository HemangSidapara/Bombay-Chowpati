import 'package:bombay_chowpati/Constants/app_assets.dart';
import 'package:bombay_chowpati/Constants/app_colors.dart';
import 'package:bombay_chowpati/Constants/app_constance.dart';
import 'package:bombay_chowpati/Constants/app_strings.dart';
import 'package:bombay_chowpati/Constants/get_storage.dart';
import 'package:bombay_chowpati/Routes/app_pages.dart';
import 'package:bombay_chowpati/Screens/home_screen/home_controller.dart';
import 'package:bombay_chowpati/Screens/home_screen/settings_screen/settings_controller.dart';
import 'package:bombay_chowpati/Utils/in_app_update_dialog_widget.dart';
import 'package:bombay_chowpati/Widgets/button_widget.dart';
import 'package:bombay_chowpati/Widgets/custom_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomHeaderWidget(
                title: AppStrings.settings.tr,
                titleIcon: AppAssets.settingsAnim,
                titleIconSize: 7.w,
              ),
              Obx(() {
                return Row(
                  children: [
                    if (Get.find<HomeController>().isLatestVersionAvailable.isTrue) ...[
                      IconButton(
                        onPressed: () async {
                          await showUpdateDialog(
                            isUpdateLoading: controller.isUpdateLoading,
                            downloadedProgress: controller.downloadedProgress,
                            onUpdate: () async {},
                          );
                        },
                        style: IconButton.styleFrom(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          padding: EdgeInsets.zero,
                          maximumSize: Size(6.w, 6.w),
                          minimumSize: Size(6.w, 6.w),
                        ),
                        icon: Icon(
                          Icons.arrow_circle_up_rounded,
                          color: AppColors.DARK_GREEN_COLOR,
                          size: 6.w,
                        ),
                      ),
                      SizedBox(width: 2.w),
                    ],
                    Obx(() {
                      return Text(
                        AppConstance.appVersion.replaceAll('1.0.0', controller.appVersion.value),
                        style: TextStyle(
                          color: AppColors.PRIMARY_COLOR.withOpacity(0.55),
                          fontWeight: FontWeight.w700,
                          fontSize: context.isPortrait ? 16.sp : 12.sp,
                        ),
                      );
                    }),
                  ],
                );
              }),
            ],
          ),
          SizedBox(height: 5.h),

          ///Personal Details
          Card(
            color: AppColors.TRANSPARENT,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 0,
            child: InkWell(
              onTap: () {
                Get.toNamed(Routes.personalDetailsScreen, id: 1);
              },
              child: ExpansionTile(
                title: Row(
                  children: [
                    Icon(
                      Icons.manage_accounts_rounded,
                      size: 5.w,
                      color: AppColors.HINT_GREY_COLOR,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      AppStrings.personalDetails.tr,
                      style: TextStyle(
                        color: AppColors.BLACK_COLOR,
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
                enabled: false,
                collapsedBackgroundColor: AppColors.WHITE_COLOR,
                backgroundColor: AppColors.WHITE_COLOR,
                collapsedShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                trailing: RotatedBox(
                  quarterTurns: 3,
                  child: Icon(
                    Icons.expand_more_rounded,
                    color: AppColors.BLACK_COLOR,
                    size: 6.w,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 1.h),

          ///Change Language
          Card(
            color: AppColors.TRANSPARENT,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 0,
            child: ExpansionTile(
              title: Row(
                children: [
                  Icon(
                    Icons.translate_rounded,
                    size: 5.w,
                    color: AppColors.HINT_GREY_COLOR,
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    AppStrings.changeLanguage.tr,
                    style: TextStyle(
                      color: AppColors.BLACK_COLOR,
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
              collapsedBackgroundColor: AppColors.WHITE_COLOR,
              backgroundColor: AppColors.WHITE_COLOR,
              collapsedShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              childrenPadding: EdgeInsets.symmetric(horizontal: 5.w).copyWith(bottom: 2.h),
              children: [
                Divider(
                  color: AppColors.HINT_GREY_COLOR,
                  thickness: 1,
                ),
                SizedBox(height: 1.h),
                Obx(() {
                  return ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 50.w, minHeight: 0.w, maxWidth: 90.w, minWidth: 90.w),
                    child: GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      crossAxisSpacing: 5.w,
                      childAspectRatio: 3,
                      children: [
                        ///Gujarati
                        InkWell(
                          onTap: () async {
                            await setData(AppConstance.languageCode, 'gu');
                            await setData(AppConstance.languageCountryCode, 'IN');
                            await Get.updateLocale(
                              Locale(getString(AppConstance.languageCode) ?? 'gu', getString(AppConstance.languageCountryCode) ?? 'IN'),
                            );
                            controller.isGujaratiLang(true);
                            controller.isHindiLang(false);
                          },
                          borderRadius: BorderRadius.circular(99),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                            child: Row(
                              children: [
                                AnimatedOpacity(
                                  opacity: controller.isGujaratiLang.isTrue ? 1 : 0,
                                  duration: const Duration(milliseconds: 300),
                                  child: Icon(
                                    Icons.done_rounded,
                                    size: 6.w,
                                    color: AppColors.DARK_GREEN_COLOR,
                                  ),
                                ),
                                SizedBox(width: 2.w),
                                Text(
                                  AppStrings.gujarati.tr,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.BLACK_COLOR,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        ///English
                        InkWell(
                          onTap: () async {
                            await setData(AppConstance.languageCode, 'en');
                            await setData(AppConstance.languageCountryCode, 'IN');
                            await Get.updateLocale(
                              Locale(getString(AppConstance.languageCode) ?? 'en', getString(AppConstance.languageCountryCode) ?? 'IN'),
                            );
                            controller.isGujaratiLang(false);
                            controller.isHindiLang(false);
                          },
                          borderRadius: BorderRadius.circular(99),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                            child: Row(
                              children: [
                                AnimatedOpacity(
                                  opacity: controller.isGujaratiLang.isFalse && controller.isHindiLang.isFalse ? 1 : 0,
                                  duration: const Duration(milliseconds: 300),
                                  child: Icon(
                                    Icons.done_rounded,
                                    size: 6.w,
                                    color: AppColors.DARK_GREEN_COLOR,
                                  ),
                                ),
                                SizedBox(width: 2.w),
                                Text(
                                  AppStrings.english.tr,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.BLACK_COLOR,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        ///Hindi
                        InkWell(
                          onTap: () async {
                            await setData(AppConstance.languageCode, 'hi');
                            await setData(AppConstance.languageCountryCode, 'IN');
                            await Get.updateLocale(
                              Locale(getString(AppConstance.languageCode) ?? 'hi', getString(AppConstance.languageCountryCode) ?? 'IN'),
                            );
                            controller.isGujaratiLang(false);
                            controller.isHindiLang(true);
                          },
                          borderRadius: BorderRadius.circular(99),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                            child: Row(
                              children: [
                                AnimatedOpacity(
                                  opacity: controller.isHindiLang.isTrue ? 1 : 0,
                                  duration: const Duration(milliseconds: 300),
                                  child: Icon(
                                    Icons.done_rounded,
                                    size: 6.w,
                                    color: AppColors.DARK_GREEN_COLOR,
                                  ),
                                ),
                                SizedBox(width: 2.w),
                                Text(
                                  AppStrings.hindi.tr,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.BLACK_COLOR,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                })
              ],
            ),
          ),
          const Spacer(),

          ///LogOut
          ButtonWidget(
            onPressed: () async {
              await controller.checkLogOut();
            },
            isLoading: controller.isLogOutLoading.isTrue,
            buttonTitle: AppStrings.logOut.tr,
          ),
          SizedBox(height: 2.h),

          Center(
            child: Text(
              AppStrings.copyrightContext.replaceAll('2024', DateTime.now().year.toString()),
              style: TextStyle(
                color: AppColors.HINT_GREY_COLOR.withOpacity(0.55),
                fontWeight: FontWeight.w700,
                fontSize: context.isPortrait ? 14.sp : 10.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
