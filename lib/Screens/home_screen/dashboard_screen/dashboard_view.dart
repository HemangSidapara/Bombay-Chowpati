import 'package:bombay_chowpati/Constants/app_colors.dart';
import 'package:bombay_chowpati/Constants/app_strings.dart';
import 'package:bombay_chowpati/Constants/app_utils.dart';
import 'package:bombay_chowpati/Network/models/cart_models/cart_model.dart';
import 'package:bombay_chowpati/Network/models/dashboard_models/get_products_model.dart';
import 'package:bombay_chowpati/Screens/home_screen/cart_screen/cart_controller.dart';
import 'package:bombay_chowpati/Screens/home_screen/dashboard_screen/dashboard_controller.dart';
import 'package:bombay_chowpati/Screens/home_screen/dashboard_screen/hand_shaken_animation.dart';
import 'package:bombay_chowpati/Screens/home_screen/home_controller.dart';
import 'package:bombay_chowpati/Utils/app_formatter.dart';
import 'package:bombay_chowpati/Widgets/loading_widget.dart';
import 'package:bombay_chowpati/Widgets/textfield_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DashboardView extends GetView<DashboardController> {
  DashboardView({super.key});

  final RxBool _isRemoving = false.obs;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Utils.unfocus(),
      child: Obx(() {
        return Scaffold(
          backgroundColor: AppColors.WHITE_COLOR,
          bottomSheet: Get.find<CartController>().cartList.isEmpty
              ? null
              : Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.cartController.cartList.clear();
                      },
                      child: SizedBox(
                        height: 8.h,
                        child: Material(
                          color: AppColors.DARK_RED_COLOR,
                          child: Padding(
                            padding: EdgeInsets.only(left: 3.w),
                            child: Align(
                              alignment: Alignment.centerLeft,
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
                      left: _isRemoving.isTrue ? 23.w : 0,
                      right: _isRemoving.isTrue ? -23.w : 0,
                      duration: const Duration(milliseconds: 300),
                      child: Material(
                        color: AppColors.SECONDARY_COLOR,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ///Items
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.5.h).copyWith(bottom: 0.8.h, right: 2.w),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  ///Clear cart & Items
                                  Row(
                                    children: [
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
                                      SizedBox(width: 3.w),

                                      ///Item Count
                                      Text(
                                        '${controller.cartController.cartList.length} ${controller.cartController.cartList.length > 1 ? AppStrings.productsAdded.tr : AppStrings.productAdded.tr}',
                                        style: TextStyle(
                                          color: AppColors.BLACK_COLOR,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 2.w),

                                  ///View Cart
                                  TextButton(
                                    onPressed: () {
                                      Get.find<HomeController>().onBottomItemChange(index: 2);
                                    },
                                    style: TextButton.styleFrom(
                                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          AppStrings.viewCart.tr,
                                          style: TextStyle(
                                            color: AppColors.DARK_GREEN_COLOR,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15.sp,
                                          ),
                                        ),
                                        Icon(
                                          Icons.keyboard_arrow_right_rounded,
                                          size: 5.w,
                                          color: AppColors.DARK_GREEN_COLOR,
                                        ),
                                      ],
                                    ),
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

                ///Searchbar
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 7.w),
                  child: TextFieldWidget(
                    contentPadding: EdgeInsets.only(left: 2.w, right: 3.w, top: 1.h, bottom: 1.h),
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      color: AppColors.WARNING_COLOR,
                      size: 5.w,
                    ),
                    prefixIconConstraints: BoxConstraints(maxHeight: 5.h, maxWidth: 8.w, minWidth: 8.w),
                    suffixIcon: InkWell(
                      onTap: () {
                        Utils.unfocus();
                        controller.searchController.clear();
                        controller.searchProductName(controller.searchController.text);
                      },
                      child: Icon(
                        Icons.close_rounded,
                        color: AppColors.WARNING_COLOR,
                        size: 5.w,
                      ),
                    ),
                    suffixIconConstraints: BoxConstraints(maxHeight: 5.h, maxWidth: 12.w, minWidth: 12.w),
                    hintText: AppStrings.search.tr,
                    controller: controller.searchController,
                    onChanged: (value) {
                      controller.searchProductName(value);
                    },
                  ),
                ),
                SizedBox(height: 2.h),

                ///Data
                Expanded(
                  child: Obx(
                    () {
                      if (controller.isGetProductsLoading.isTrue) {
                        return const LoadingWidget();
                      } else if (controller.searchedProductsList.isEmpty) {
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
                          itemCount: controller.searchedProductsList.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 1.h).copyWith(bottom: controller.cartController.cartList.isNotEmpty ? 10.h : 2.h),
                          itemBuilder: (context, index) {
                            final product = controller.searchedProductsList[index];
                            Rx<CartModel?> productInCart = controller.cartController.cartList.firstWhereOrNull((element) => element.productId == product.pid).obs;

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
                              height: 30.h,
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
                                        cacheKey: product.thumb,
                                        imageUrl: product.thumb ?? '',
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
                                              message: product.title,
                                              child: Text(
                                                "◆ ${product.title ?? ""}",
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

                                          ///Size
                                          DropdownButtonFormField(
                                            value: 0,
                                            hint: Text(
                                              AppStrings.selectSize.tr,
                                              style: TextStyle(
                                                color: AppColors.HINT_COLOR,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16.sp,
                                              ),
                                            ),
                                            decoration: InputDecoration(
                                              isCollapsed: true,
                                              contentPadding: EdgeInsets.only(left: 3.w, top: 0.8.h, right: 2.w, bottom: 0.8.h),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(8),
                                                borderSide: BorderSide(
                                                  color: AppColors.HINT_COLOR,
                                                  width: 0.8,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(8),
                                                borderSide: BorderSide(
                                                  color: AppColors.HINT_COLOR,
                                                  width: 0.8,
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(8),
                                                borderSide: BorderSide(
                                                  color: AppColors.HINT_COLOR,
                                                  width: 0.8,
                                                ),
                                              ),
                                              disabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(8),
                                                borderSide: BorderSide(
                                                  color: AppColors.HINT_COLOR,
                                                  width: 0.8,
                                                ),
                                              ),
                                            ),
                                            icon: Icon(
                                              Icons.keyboard_arrow_down_rounded,
                                              color: AppColors.GREY_COLOR,
                                              size: 5.w,
                                            ),
                                            dropdownColor: AppColors.SECONDARY_COLOR,
                                            borderRadius: BorderRadius.circular(12),
                                            items: [
                                              for (int i = 0; i < (product.productData?.length ?? 0); i++)
                                                DropdownMenuItem(
                                                  value: i,
                                                  child: Text(
                                                    product.productData?[i].size ?? "",
                                                    style: TextStyle(
                                                      color: AppColors.BLACK_COLOR,
                                                      fontSize: 16.sp,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                            ],
                                            onChanged: (value) {
                                              if (value != null) {
                                                final tempData = product.productData?[value];
                                                controller.selectedProductData[index] = ProductData(
                                                  id: tempData?.id,
                                                  size: tempData?.size,
                                                  price: tempData?.price,
                                                  mrp: tempData?.mrp,
                                                );

                                                if (controller.cartController.cartList.isNotEmpty) {
                                                  productInCart(
                                                    CartModel(
                                                      productId: product.pid,
                                                      productDataId: controller.selectedProductData[index]?.id,
                                                      size: controller.selectedProductData[index]?.size,
                                                      mrp: controller.selectedProductData[index]?.mrp,
                                                      price: controller.selectedProductData[index]?.price,
                                                      quantity: productInCart.value?.quantity,
                                                      image: product.thumb,
                                                      title: product.title,
                                                    ),
                                                  );
                                                  productInCart.update((val) => {});
                                                }
                                              }
                                            },
                                          ),
                                          SizedBox(height: 1.h),

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
                                                        text: '₹ ${(productInCart.value?.size == "5 Litre" && (productInCart.value?.quantity?.toInt() ?? 0) > 1) || (productInCart.value?.size == "750 ML" && (productInCart.value?.quantity?.toInt() ?? 0) > 6) ? controller.selectedProductData[index]?.price : controller.selectedProductData[index]?.mrp}',
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
                                                        text: '\n${'₹ 0.00'.grandTotalBySize(productInCart.value?.quantity, productInCart.value?.size, productInCart.value?.mrp, productInCart.value?.price)}',
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
                                            if (controller.cartController.cartList.isNotEmpty && productInCart.value?.quantity != null && productInCart.value?.quantity?.toInt() != 0) {
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
                                                          productInCart.value?.setQuantity = "${productInCart.value!.quantity!.toInt() - 1}";
                                                          if (productInCart.value!.quantity == "0") {
                                                            controller.cartController.cartList.removeWhere((element) => element.productId == product.pid);
                                                          }
                                                          productInCart.update((val) {});
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
                                                          productInCart.value?.quantity ?? '',
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
                                                          productInCart.value?.setQuantity = "${productInCart.value!.quantity!.toInt() + 1}";
                                                          productInCart.update((val) {});
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
                                              return ElevatedButton(
                                                onPressed: () {
                                                  controller.cartController.cartList.add(
                                                    CartModel(
                                                      productId: product.pid,
                                                      productDataId: controller.selectedProductData[index]?.id,
                                                      mrp: controller.selectedProductData[index]?.mrp,
                                                      price: controller.selectedProductData[index]?.price,
                                                      quantity: "1",
                                                      size: controller.selectedProductData[index]?.size,
                                                      image: product.thumb,
                                                      title: product.title,
                                                    ),
                                                  );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: AppColors.WHITE_COLOR,
                                                  surfaceTintColor: AppColors.WHITE_COLOR,
                                                  elevation: 4,
                                                  fixedSize: Size(41.w, 5.h),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(10),
                                                    side: BorderSide(
                                                      color: AppColors.DARK_GREEN_COLOR,
                                                      width: 1,
                                                    ),
                                                  ),
                                                ),
                                                child: Text(
                                                  AppStrings.add.tr,
                                                  style: TextStyle(
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColors.DARK_GREEN_COLOR,
                                                  ),
                                                ),
                                              );
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
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
