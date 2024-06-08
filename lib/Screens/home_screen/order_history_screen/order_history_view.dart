import 'package:bombay_chowpati/Constants/app_assets.dart';
import 'package:bombay_chowpati/Constants/app_strings.dart';
import 'package:bombay_chowpati/Screens/home_screen/order_history_screen/order_history_controller.dart';
import 'package:bombay_chowpati/Widgets/custom_header_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OrderHistoryView extends GetView<OrderHistoryController> {
  const OrderHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///Header
            CustomHeaderWidget(
              title: AppStrings.orderHistory.tr,
              titleIconWidget: LottieBuilder.asset(
                AppAssets.favouriteAnim,
              ),
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }
}
