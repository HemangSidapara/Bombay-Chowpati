import 'package:bombay_chowpati/Constants/app_colors.dart';
import 'package:bombay_chowpati/Constants/app_strings.dart';
import 'package:bombay_chowpati/Screens/home_screen/cart_screen/order_history_screen/order_history_controller.dart';
import 'package:bombay_chowpati/Widgets/custom_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OrderHistoryView extends GetView<OrderHistoryController> {
  const OrderHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
      child: Column(
        children: [
          ///Header
          CustomHeaderWidget(
            title: AppStrings.orderHistory.tr,
            backIconBackgroundColor: AppColors.WHITE_COLOR,
            onBackPressed: () {
              Get.back(id: 2);
            },
          ),
          SizedBox(height: 2.h),
        ],
      ),
    );
  }
}
