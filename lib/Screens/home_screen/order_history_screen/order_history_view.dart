import 'package:bombay_chowpati/Constants/app_assets.dart';
import 'package:bombay_chowpati/Constants/app_colors.dart';
import 'package:bombay_chowpati/Constants/app_constance.dart';
import 'package:bombay_chowpati/Constants/app_strings.dart';
import 'package:bombay_chowpati/Screens/home_screen/order_history_screen/order_history_controller.dart';
import 'package:bombay_chowpati/Widgets/button_widget.dart';
import 'package:bombay_chowpati/Widgets/custom_header_widget.dart';
import 'package:bombay_chowpati/Widgets/loading_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OrderHistoryView extends GetView<OrderHistoryController> {
  const OrderHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h).copyWith(bottom: 1.h),
            child: CustomHeaderWidget(
              title: AppStrings.orderHistory.tr,
              titleIconWidget: LottieBuilder.asset(
                AppAssets.favouriteAnim,
              ),
            ),
          ),

          Expanded(
            child: Obx(
              () {
                if (controller.isGetOrdersLoading.isTrue) {
                  return const Center(
                    child: LoadingWidget(),
                  );
                } else if (controller.orderList.isEmpty) {
                  return Center(
                    child: Text(
                      AppStrings.noDataFound.tr,
                      style: TextStyle(
                        color: AppColors.BLACK_COLOR,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                } else {
                  return CustomRefreshIndicator(
                    onRefresh: () async {
                      await controller.getOrdersApiCall();
                    },
                    builder: (BuildContext context, Widget child, IndicatorController indicatorController) {
                      return Stack(
                        alignment: Alignment.topCenter,
                        children: <Widget>[
                          LoadingWidget(width: 25.w),
                          Transform.translate(
                            offset: Offset(0.0, indicatorController.value * 100),
                            child: child,
                          ),
                        ],
                      );
                    },
                    child: AnimationLimiter(
                      child: ColoredBox(
                        color: AppColors.WHITE_COLOR,
                        child: ListView.separated(
                          itemCount: controller.orderList.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 1.h).copyWith(bottom: 4.h),
                          itemBuilder: (context, index) {
                            final order = controller.orderList[index];
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 400),
                              child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: FadeInAnimation(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.WHITE_COLOR,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12.withOpacity(0.09),
                                          blurRadius: 10,
                                          spreadRadius: 3,
                                          offset: const Offset(-5, 5),
                                        ),
                                      ],
                                    ),
                                    clipBehavior: Clip.hardEdge,
                                    padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ///Amount, Date & Status
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            ///Amount & Order Date
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                ///Amount
                                                Text(
                                                  "${AppConstance.rupeeSign} ${order.totalAmount ?? "0.00"}",
                                                  style: TextStyle(
                                                    color: AppColors.DARK_GREEN_COLOR,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16.sp,
                                                  ),
                                                ),
                                                Text(
                                                  AppStrings.totalAmount.tr.replaceAll(":", ""),
                                                  style: TextStyle(
                                                    color: AppColors.HINT_GREY_COLOR.withOpacity(0.7),
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15.sp,
                                                  ),
                                                ),

                                                ///Order Date
                                                Text(
                                                  order.createdDate != null ? DateFormat("MMMM dd, yyyy hh:mm").format(DateTime.parse(order.createdDate!).toLocal()) : "",
                                                  style: TextStyle(
                                                    color: AppColors.BLACK_COLOR,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16.sp,
                                                  ),
                                                ),
                                                Text(
                                                  AppStrings.orderDate.tr,
                                                  style: TextStyle(
                                                    color: AppColors.HINT_GREY_COLOR.withOpacity(0.7),
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15.sp,
                                                  ),
                                                ),
                                              ],
                                            ),

                                            ///Status & Cancel
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                ///Status
                                                Row(
                                                  children: [
                                                    Text(
                                                      order.status?.tr ?? "",
                                                      style: TextStyle(
                                                        color: AppColors.BLACK_COLOR,
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 16.sp,
                                                      ),
                                                    ),
                                                    SizedBox(width: 1.w),
                                                    Icon(
                                                      order.status == AppStrings.pending
                                                          ? FontAwesomeIcons.truck
                                                          : order.status == AppStrings.cancelled
                                                              ? Icons.cancel_rounded
                                                              : FontAwesomeIcons.solidCircleCheck,
                                                      color: order.status == AppStrings.pending
                                                          ? AppColors.WARNING_COLOR
                                                          : order.status == AppStrings.cancelled
                                                              ? AppColors.DARK_RED_COLOR
                                                              : AppColors.DARK_GREEN_COLOR,
                                                      size: order.status == AppStrings.cancelled ? 5.w : 4.w,
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  AppStrings.status.tr,
                                                  style: TextStyle(
                                                    color: AppColors.HINT_GREY_COLOR.withOpacity(0.7),
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15.sp,
                                                  ),
                                                ),

                                                if (order.status == AppStrings.pending)
                                                  Obx(() {
                                                    return ButtonWidget(
                                                      onPressed: () async {
                                                        if (order.orderId != null) {
                                                          await controller.cancelOrderApiCall(orderId: order.orderId!);
                                                        }
                                                      },
                                                      isLoading: controller.isCancelOrderLoading.value,
                                                      loaderColor: AppColors.DARK_RED_COLOR,
                                                      style: ElevatedButton.styleFrom(
                                                        backgroundColor: AppColors.WHITE_COLOR,
                                                        surfaceTintColor: AppColors.WHITE_COLOR,
                                                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                        elevation: 3,
                                                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                                                        minimumSize: Size(20.w, 3.5.h),
                                                        maximumSize: Size(20.w, 3.5.h),
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(5),
                                                          side: BorderSide(
                                                            color: AppColors.DARK_RED_COLOR,
                                                          ),
                                                        ),
                                                      ),
                                                      child: Text(
                                                        AppStrings.cancel.tr,
                                                        style: TextStyle(
                                                          color: AppColors.DARK_RED_COLOR,
                                                          fontSize: 14.sp,
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                              ],
                                            ),
                                          ],
                                        ),

                                        ///Address
                                        Text.rich(
                                          TextSpan(
                                            text: "",
                                            children: [
                                              WidgetSpan(
                                                child: Padding(
                                                  padding: EdgeInsets.only(right: 1.w),
                                                  child: Icon(
                                                    FontAwesomeIcons.locationDot,
                                                    color: AppColors.ORANGE_COLOR,
                                                    size: 3.5.w,
                                                  ),
                                                ),
                                              ),
                                              TextSpan(
                                                text: order.address ?? "",
                                                style: TextStyle(
                                                  color: AppColors.BLACK_COLOR,
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          color: AppColors.HINT_GREY_COLOR.withOpacity(0.5),
                                          thickness: 1,
                                        ),

                                        ///Products
                                        Flexible(
                                          child: SizedBox(
                                            height: 12.h,
                                            child: ListView.builder(
                                              itemCount: (order.orderMeta?.length ?? 0),
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, productIndex) {
                                                final product = order.orderMeta?[productIndex];
                                                return Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    ///Image
                                                    CachedNetworkImage(
                                                      cacheKey: product?.cover,
                                                      imageUrl: product?.cover ?? "",
                                                      width: 33.3.w,
                                                      progressIndicatorBuilder: (context, url, progress) {
                                                        return SizedBox(
                                                          height: 11.h,
                                                          child: Center(
                                                            child: LoadingWidget(width: 14.w),
                                                          ),
                                                        );
                                                      },
                                                      errorWidget: (context, url, error) {
                                                        return Icon(
                                                          FontAwesomeIcons.bug,
                                                          color: AppColors.DARK_RED_COLOR,
                                                          size: 5.w,
                                                        );
                                                      },
                                                    ),
                                                    SizedBox(width: 5.w),

                                                    ///Product Details
                                                    Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      children: [
                                                        ///Title
                                                        Text(
                                                          product?.title ?? "",
                                                          style: TextStyle(
                                                            color: AppColors.BLACK_COLOR,
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: 15.sp,
                                                          ),
                                                        ),

                                                        ///Size
                                                        Text(
                                                          product?.size ?? "",
                                                          style: TextStyle(
                                                            color: AppColors.DARK_GREEN_COLOR,
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: 15.sp,
                                                          ),
                                                        ),

                                                        ///Quantity
                                                        Text(
                                                          product?.quantity ?? "",
                                                          style: TextStyle(
                                                            color: AppColors.BLACK_COLOR,
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: 15.sp,
                                                          ),
                                                        ),
                                                        Text(
                                                          AppStrings.quantity.tr,
                                                          style: TextStyle(
                                                            color: AppColors.HINT_GREY_COLOR.withOpacity(0.7),
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: 13.sp,
                                                          ),
                                                        ),

                                                        ///Price
                                                        Text(
                                                          "${AppConstance.rupeeSign} ${product?.amount ?? "0.00"} / pc",
                                                          style: TextStyle(
                                                            color: AppColors.BLACK_COLOR,
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: 15.sp,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    if (productIndex < (order.orderMeta?.length ?? 0) - 1) ...[
                                                      SizedBox(width: 2.w),
                                                      VerticalDivider(
                                                        color: AppColors.HINT_GREY_COLOR.withOpacity(0.5),
                                                        thickness: 0.8,
                                                      ),
                                                    ],
                                                  ],
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 2.h);
                          },
                        ),
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
