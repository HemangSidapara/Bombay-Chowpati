import 'package:bombay_chowpati/Constants/app_assets.dart';
import 'package:bombay_chowpati/Constants/app_colors.dart';
import 'package:bombay_chowpati/Constants/app_strings.dart';
import 'package:bombay_chowpati/Routes/app_pages.dart';
import 'package:bombay_chowpati/Screens/home_screen/cart_screen/cart_controller.dart';
import 'package:bombay_chowpati/Widgets/custom_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CartView extends GetView<CartController> {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
      child: Column(
        children: [
          ///Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ///Title
              CustomHeaderWidget(
                title: AppStrings.cart.tr,
                titleIcon: AppAssets.cartAnim,
                titleIconSize: 10.w,
              ),
              SizedBox(width: 2.w),

              ///Order History
              IconButton(
                onPressed: () {
                  Get.toNamed(Routes.orderHistoryScreen, id: 2);
                },
                style: IconButton.styleFrom(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  elevation: 4,
                  backgroundColor: AppColors.SETTING_BG_COLOR,
                ),
                tooltip: AppStrings.orderHistory.tr,
                icon: Image.asset(
                  AppAssets.orderHistoryIcon,
                  width: 6.w,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
        ],
      ),
    );
  }
}
