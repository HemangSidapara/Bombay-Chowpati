import 'package:bombay_chowpati/Constants/app_colors.dart';
import 'package:bombay_chowpati/Constants/app_constance.dart';
import 'package:bombay_chowpati/Constants/app_strings.dart';
import 'package:bombay_chowpati/Screens/home_screen/settings_screen/terms_and_conditions_screen/terms_and_conditions_controller.dart';
import 'package:bombay_chowpati/Utils/app_formatter.dart';
import 'package:bombay_chowpati/Widgets/custom_header_widget.dart';
import 'package:bombay_chowpati/Widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TermsAndConditionsView extends GetView<TermsAndConditionsController> {
  const TermsAndConditionsView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.id = ModalRoute.of(context)?.settings.arguments?.toString().toInt() ?? AppConstance.settingsNavigatorKey.getNavigatorId!;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
      child: Column(
        children: [
          ///Header
          if (controller.id == AppConstance.settingsNavigatorKey.getNavigatorId)
            CustomHeaderWidget(
              title: AppStrings.termsAndConditions.tr,
              onBackPressed: () {
                Get.back(id: controller.id, closeOverlays: true);
              },
            )
          else ...[
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Get.back(id: controller.id);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 6.w,
                  ),
                ),
                SizedBox(width: 2.w),

                ///Title
                Text(
                  AppStrings.termsAndConditions.tr,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.PRIMARY_COLOR,
                  ),
                ),
              ],
            ),
            SizedBox(height: 1.h),
          ],
          SizedBox(height: 2.h),

          ///Terms & Condition
          Expanded(
            child: Obx(
              () {
                if (controller.isLoadingTerms.isTrue) {
                  return const LoadingWidget();
                } else if (controller.termsAndConditionsTag.isEmpty) {
                  return Center(
                    child: Text(
                      AppStrings.noDataFound.tr,
                      style: TextStyle(
                        color: AppColors.BLACK_COLOR,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                      ),
                    ),
                  );
                } else {
                  return HtmlWidget(
                    controller.termsAndConditionsTag.value,
                    textStyle: TextStyle(
                      fontSize: 16.sp,
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
