import 'package:bombay_chowpati/Constants/app_colors.dart';
import 'package:bombay_chowpati/Constants/app_strings.dart';
import 'package:bombay_chowpati/Screens/home_screen/dashboard_screen/dashboard_controller.dart';
import 'package:bombay_chowpati/Screens/home_screen/dashboard_screen/hand_shaken_animation.dart';
import 'package:bombay_chowpati/Widgets/loading_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Column(
        children: [
          ///Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 7.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.hello.tr,
                        style: TextStyle(
                          color: AppColors.PRIMARY_COLOR.withOpacity(0.8),
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const HandShakenAnimation(),
                    ],
                  ),
                ),
                SizedBox(width: 2.w),
              ],
            ),
          ),
          SizedBox(height: 2.h),

          Expanded(
            child: Obx(
              () {
                if (controller.isGetProductsLoading.isTrue) {
                  return const LoadingWidget();
                } else if (controller.productsList.isEmpty) {
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
                  return ListView.separated(
                    itemCount: controller.productsList.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 7.w),
                    itemBuilder: (context, index) {
                      final product = controller.productsList[index];
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.GREY_COLOR,
                            width: 2,
                          ),
                        ),
                        child: Row(
                          children: [
                            CachedNetworkImage(
                              imageUrl: product.thumb ?? '',
                              width: 45.w,
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 2.h);
                    },
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
