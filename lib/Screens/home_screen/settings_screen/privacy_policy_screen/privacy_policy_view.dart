import 'package:bombay_chowpati/Constants/app_colors.dart';
import 'package:bombay_chowpati/Constants/app_constance.dart';
import 'package:bombay_chowpati/Constants/app_strings.dart';
import 'package:bombay_chowpati/Screens/home_screen/settings_screen/privacy_policy_screen/privacy_policy_controller.dart';
import 'package:bombay_chowpati/Utils/app_formatter.dart';
import 'package:bombay_chowpati/Widgets/custom_header_widget.dart';
import 'package:bombay_chowpati/Widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PrivacyPolicyView extends GetView<PrivacyPolicyController> {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
      child: Column(
        children: [
          ///Header
          CustomHeaderWidget(
            title: AppStrings.privacyPolicy.tr,
            onBackPressed: () {
              Get.back(id: AppConstance.settingsNavigatorKey.getNavigatorId, closeOverlays: true);
            },
          ),
          SizedBox(height: 2.h),

          ///Privacy Policy
          Expanded(
            child: Obx(
              () {
                if (controller.isLoadingPrivacy.isTrue) {
                  return const LoadingWidget();
                } else if (controller.privacyPolicyTag.isEmpty) {
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
                  return SingleChildScrollView(
                    child: HtmlWidget(
                      controller.privacyPolicyTag.value,
                      textStyle: TextStyle(
                        fontSize: 16.sp,
                      ),
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
