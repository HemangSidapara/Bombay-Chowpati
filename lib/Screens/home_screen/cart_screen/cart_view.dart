import 'package:bombay_chowpati/Constants/app_assets.dart';
import 'package:bombay_chowpati/Constants/app_colors.dart';
import 'package:bombay_chowpati/Constants/app_constance.dart';
import 'package:bombay_chowpati/Constants/app_strings.dart';
import 'package:bombay_chowpati/Network/models/cart_models/cart_model.dart';
import 'package:bombay_chowpati/Routes/app_pages.dart';
import 'package:bombay_chowpati/Screens/home_screen/cart_screen/cart_controller.dart';
import 'package:bombay_chowpati/Screens/home_screen/home_controller.dart';
import 'package:bombay_chowpati/Utils/app_formatter.dart';
import 'package:bombay_chowpati/Widgets/custom_header_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CartView extends GetView<CartController> {
  CartView({super.key});

  final RxBool _isRemoving = false.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: AppColors.WHITE_COLOR,
        bottomSheet: Get.find<CartController>().cartList.isEmpty
            ? null
            : Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.cartList.clear();
                    },
                    child: SizedBox(
                      height: 8.h,
                      child: Material(
                        color: AppColors.DARK_RED_COLOR,
                        child: Padding(
                          padding: EdgeInsets.only(right: 3.w),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              AppStrings.remove.tr,
                              style: TextStyle(
                                color: AppColors.WHITE_COLOR,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    left: _isRemoving.isTrue ? -23.w : 0,
                    right: _isRemoving.isTrue ? 23.w : 0,
                    duration: const Duration(milliseconds: 300),
                    child: Material(
                      color: AppColors.SECONDARY_COLOR,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ///Items
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.5.h).copyWith(bottom: 0.8.h, left: 2.w),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ///View Products
                                TextButton(
                                  onPressed: () {
                                    Get.find<HomeController>().onBottomItemChange(index: 0);
                                  },
                                  style: TextButton.styleFrom(
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.keyboard_arrow_left_rounded,
                                        size: 5.w,
                                        color: AppColors.DARK_GREEN_COLOR,
                                      ),
                                      Text(
                                        AppStrings.viewProducts.tr,
                                        style: TextStyle(
                                          color: AppColors.DARK_GREEN_COLOR,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 2.w),

                                ///Clear cart & Items
                                Row(
                                  children: [
                                    ///Item Count
                                    Text(
                                      '${controller.cartList.length} ${controller.cartList.length > 1 ? AppStrings.productsAdded.tr : AppStrings.productAdded.tr}',
                                      style: TextStyle(
                                        color: AppColors.BLACK_COLOR,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(width: 3.w),

                                    ///Clear cart
                                    IconButton(
                                      onPressed: () async {
                                        Future.delayed(
                                          const Duration(seconds: 3),
                                          () {
                                            if (_isRemoving.isTrue) {
                                              _isRemoving.toggle();
                                            }
                                          },
                                        );
                                        _isRemoving.toggle();
                                      },
                                      style: TextButton.styleFrom(
                                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        maximumSize: Size(6.w, 6.w),
                                        minimumSize: Size(6.w, 6.w),
                                        padding: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(99),
                                          side: BorderSide(
                                            color: AppColors.DARK_RED_COLOR,
                                            width: 1.5,
                                          ),
                                        ),
                                      ),
                                      icon: Icon(
                                        Icons.close_rounded,
                                        color: AppColors.DARK_RED_COLOR,
                                        size: 4.w,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: AppColors.GREY_COLOR,
                            thickness: 0.3,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 2.h),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              ///Header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 7.w),
                child: Row(
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
                        Get.toNamed(Routes.orderHistoryScreen, id: AppConstance.cartNavigatorKey.getNavigatorId);
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
              ),
              SizedBox(height: 2.h),

              Expanded(
                child: Obx(
                  () {
                    if (controller.cartList.isEmpty) {
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
                        itemCount: controller.cartList.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 1.h).copyWith(bottom: controller.cartList.isNotEmpty ? 10.h : 2.h),
                        itemBuilder: (context, index) {
                          Rx<CartModel> product = controller.cartList[index].obs;

                          return Container(
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
                            height: 20.h,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ///Image
                                SizedBox(
                                  width: 45.w,
                                  child: Center(
                                    child: CachedNetworkImage(
                                      cacheKey: product.value.image,
                                      imageUrl: product.value.image ?? '',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),

                                ///Product Details
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 1.h).copyWith(right: 4.w, bottom: 0, left: 2.w),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        ///Name
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Tooltip(
                                            message: product.value.title,
                                            child: Text(
                                              "◆ ${product.value.title ?? ""}",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: AppColors.BLACK_COLOR,
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 0.5.h),

                                        ///Amount
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            ///MRP
                                            Obx(() {
                                              return Text.rich(
                                                TextSpan(
                                                  text: AppStrings.mrp.tr,
                                                  children: [
                                                    TextSpan(
                                                      text: '₹ ${(product.value.size == "5 Litre" && (product.value.quantity?.toInt() ?? 0) > 1) || (product.value.size == "750 ML" && (product.value.quantity?.toInt() ?? 0) > 6) ? product.value.price : product.value.mrp}',
                                                      style: TextStyle(
                                                        color: AppColors.DARK_GREEN_COLOR,
                                                        fontSize: 16.sp,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                  ],
                                                  style: TextStyle(
                                                    color: AppColors.BLACK_COLOR,
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              );
                                            }),
                                            SizedBox(height: 0.5.h),

                                            ///Total Amount
                                            Obx(() {
                                              return Text.rich(
                                                TextSpan(
                                                  text: AppStrings.totalAmount.tr,
                                                  children: [
                                                    TextSpan(
                                                      text: '\n${'₹ 0.00'.grandTotalBySize(product.value.quantity, product.value.size, product.value.mrp, product.value.price)}',
                                                      style: TextStyle(
                                                        color: AppColors.DARK_GREEN_COLOR,
                                                        fontSize: 16.sp,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                  ],
                                                  style: TextStyle(
                                                    color: AppColors.BLACK_COLOR,
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              );
                                            }),
                                          ],
                                        ),
                                        SizedBox(height: 1.h),

                                        ///Add
                                        Obx(() {
                                          if (controller.cartList.isNotEmpty && product.value.quantity != null && product.value.quantity?.toInt() != 0) {
                                            return DecoratedBox(
                                              decoration: BoxDecoration(
                                                color: AppColors.WHITE_COLOR,
                                                borderRadius: BorderRadius.circular(12),
                                                border: Border.all(
                                                  color: AppColors.HINT_COLOR,
                                                  width: 0.8,
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black12.withOpacity(0.07),
                                                    blurRadius: 4,
                                                    spreadRadius: 0.4,
                                                    offset: const Offset(0, 5),
                                                  ),
                                                ],
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  ///-
                                                  SizedBox(
                                                    width: 13.w,
                                                    height: 5.h,
                                                    child: TextButton(
                                                      style: TextButton.styleFrom(
                                                        padding: EdgeInsets.zero,
                                                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                        shape: const RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        product.value.setQuantity = "${product.value.quantity!.toInt() - 1}";
                                                        if (product.value.quantity == "0") {
                                                          controller.cartList.removeWhere((element) => element.productId == product.value.productId);
                                                        }
                                                        product.update((val) {});
                                                      },
                                                      child: Icon(
                                                        Icons.remove_rounded,
                                                        color: AppColors.DARK_RED_COLOR,
                                                      ),
                                                    ).paddingZero,
                                                  ),

                                                  ///Count
                                                  Obx(() {
                                                    return Expanded(
                                                      child: Text(
                                                        product.value.quantity ?? '',
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          color: AppColors.BLACK_COLOR,
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: 16.sp,
                                                        ),
                                                      ),
                                                    );
                                                  }),

                                                  ///+
                                                  SizedBox(
                                                    height: 5.h,
                                                    width: 13.w,
                                                    child: TextButton(
                                                      onPressed: () {
                                                        product.value.setQuantity = "${product.value.quantity!.toInt() + 1}";
                                                        product.update((val) {});
                                                      },
                                                      style: TextButton.styleFrom(
                                                        padding: EdgeInsets.zero,
                                                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                        shape: const RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                        ),
                                                      ),
                                                      child: Icon(
                                                        Icons.add_rounded,
                                                        color: AppColors.DARK_GREEN_COLOR,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          } else {
                                            return const SizedBox();
                                          }
                                        }),
                                      ],
                                    ),
                                  ),
                                )
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
              )
            ],
          ),
        ),
      );
    });
  }
}
