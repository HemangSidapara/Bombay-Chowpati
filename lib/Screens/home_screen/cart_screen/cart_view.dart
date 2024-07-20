import 'package:bombay_chowpati/Constants/app_assets.dart';
import 'package:bombay_chowpati/Constants/app_colors.dart';
import 'package:bombay_chowpati/Constants/app_constance.dart';
import 'package:bombay_chowpati/Constants/app_strings.dart';
import 'package:bombay_chowpati/Constants/app_utils.dart';
import 'package:bombay_chowpati/Constants/get_storage.dart';
import 'package:bombay_chowpati/Network/models/cart_models/cart_model.dart';
import 'package:bombay_chowpati/Screens/home_screen/cart_screen/cart_controller.dart';
import 'package:bombay_chowpati/Screens/home_screen/home_controller.dart';
import 'package:bombay_chowpati/Utils/app_formatter.dart';
import 'package:bombay_chowpati/Widgets/button_widget.dart';
import 'package:bombay_chowpati/Widgets/confirmation_dialog_widget.dart';
import 'package:bombay_chowpati/Widgets/custom_header_widget.dart';
import 'package:bombay_chowpati/Widgets/loading_widget.dart';
import 'package:bombay_chowpati/Widgets/text_with_tooltip_widget.dart';
import 'package:bombay_chowpati/Widgets/textfield_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CartView extends GetView<CartController> {
  CartView({super.key});

  final RxBool _isRemoving = false.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return PopScope(
        canPop: false,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.WHITE_COLOR,
          bottomSheet: Get.find<CartController>().cartList.isEmpty
              ? null
              : Stack(
                  children: [
                    ///Remove
                    GestureDetector(
                      onTap: () {
                        controller.cartList.clear();
                        removeData(AppConstance.cartStorage);
                      },
                      child: SizedBox(
                        height: 25.h,
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

                    ///Details
                    AnimatedPositioned(
                      left: _isRemoving.isTrue ? -23.w : 0,
                      right: _isRemoving.isTrue ? 23.w : 0,
                      duration: const Duration(milliseconds: 300),
                      child: SizedBox(
                        height: 25.h,
                        child: Material(
                          color: AppColors.SECONDARY_COLOR,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              ///Total products
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

                              ///Payment details & Address
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5.w),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ///Total Payable Amount
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        ///Total Payable
                                        Text(
                                          AppStrings.totalPayableAmount.tr,
                                          style: TextStyle(
                                            color: AppColors.BLACK_COLOR,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15.sp,
                                          ),
                                        ),
                                        SizedBox(width: 2.w),

                                        ///Amount
                                        Obx(() {
                                          return Text(
                                            "₹ ${controller.totalPayableAmount.value}",
                                            style: TextStyle(
                                              color: AppColors.DARK_GREEN_COLOR,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          );
                                        }),
                                      ],
                                    ),
                                    SizedBox(height: 0.5.h),

                                    ///Address
                                    Obx(() {
                                      return Flexible(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () async {
                                                controller.getPinCodesApiCall();
                                                await showBottomSheetAddress(
                                                  context: context,
                                                  selectAddressId: controller.selectedAddressId.value,
                                                );
                                              },
                                              style: ElevatedButton.styleFrom(
                                                elevation: 4,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(99),
                                                  side: BorderSide(
                                                    color: AppColors.PRIMARY_COLOR,
                                                    width: 1.5,
                                                  ),
                                                ),
                                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                padding: EdgeInsets.zero,
                                                minimumSize: Size(8.w, 8.w),
                                                maximumSize: Size(8.w, 8.w),
                                              ),
                                              child: Icon(
                                                FontAwesomeIcons.locationDot,
                                                color: AppColors.ORANGE_COLOR,
                                                size: 4.w,
                                              ),
                                            ),
                                            SizedBox(width: 2.5.w),
                                            Flexible(
                                              child: GestureDetector(
                                                onTap: () async {
                                                  controller.getPinCodesApiCall();
                                                  await showBottomSheetAddress(
                                                    context: context,
                                                    selectAddressId: controller.selectedAddressId.value,
                                                  );
                                                },
                                                child: controller.addressList.isNotEmpty
                                                    ? TextWithTooltipWidget(
                                                        child: Text(
                                                          "${controller.addressList.firstWhereOrNull((element) => element.addressId == controller.selectedAddressId.value)?.address ?? ""}, ${controller.addressList.firstWhereOrNull((element) => element.addressId == controller.selectedAddressId.value)?.pinCode ?? ""}${controller.addressList.firstWhereOrNull((element) => element.addressId == controller.selectedAddressId.value)?.phone != null && controller.addressList.firstWhereOrNull((element) => element.addressId == controller.selectedAddressId.value)?.phone?.isNotEmpty == true ? ", +91 ${controller.addressList.firstWhereOrNull((element) => element.addressId == controller.selectedAddressId.value)?.phone ?? ""}" : ""}",
                                                          overflow: TextOverflow.ellipsis,
                                                          maxLines: 2,
                                                          style: TextStyle(
                                                            color: AppColors.BLACK_COLOR,
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: 15.sp,
                                                          ),
                                                        ),
                                                      )
                                                    : Text(
                                                        AppStrings.addressNotAddedYet.tr,
                                                        style: TextStyle(
                                                          color: AppColors.TEXT_BLACK_COLOR,
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: 15.sp,
                                                        ),
                                                      ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                              ),
                              SizedBox(height: 1.h),

                              ///Create Order
                              Expanded(
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(color: AppColors.GREY_COLOR, width: 0.3),
                                      bottom: BorderSide(color: AppColors.GREY_COLOR, width: 0.3),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ///Add address
                                        TextButton(
                                          onPressed: () async {
                                            controller.getPinCodesApiCall();
                                            await showBottomSheetAddNewAddress(context: context);
                                          },
                                          style: TextButton.styleFrom(
                                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                            padding: EdgeInsets.zero,
                                            maximumSize: Size(35.w, 3.h),
                                            minimumSize: Size(35.w, 3.h),
                                            elevation: 4,
                                          ),
                                          child: Text(
                                            AppStrings.addNewAddress.tr,
                                            style: TextStyle(
                                              color: AppColors.DARK_RED_COLOR,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),

                                        ///Place Order
                                        ButtonWidget(
                                          onPressed: () async {
                                            if (controller.selectedAddressId.isNotEmpty) {
                                              await showConfirmationDialog(
                                                context: context,
                                                title: AppStrings.areYouSureYouWantToPlaceOrderWithSelectedItems.tr,
                                                confirmText: AppStrings.confirm.tr,
                                                icon: FontAwesomeIcons.truckFast,
                                                onConfirm: () async {
                                                  Get.back();
                                                  await controller.createOrderApiCall();
                                                },
                                              );
                                            } else {
                                              Utils.handleMessage(message: AppStrings.pleaseSelectOrAddAddress, isError: true);
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColors.WARNING_COLOR,
                                            minimumSize: Size(35.w, 4.h),
                                            maximumSize: Size(45.w, 4.h),
                                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                            elevation: 4,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                          ),
                                          child: Text(
                                            AppStrings.placeOrder.tr,
                                            style: TextStyle(
                                              color: AppColors.SECONDARY_COLOR,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16.sp,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
          body: Padding(
            padding: EdgeInsets.only(bottom: 2.h),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                ///Header
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: CustomHeaderWidget(
                    title: AppStrings.cart.tr,
                    titleIcon: AppAssets.cartAnim,
                    titleIconSize: 10.w,
                  ),
                ),
                SizedBox(height: 2.h),

                ///Cart data
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
                        return AnimationLimiter(
                          child: ColoredBox(
                            color: AppColors.WHITE_COLOR,
                            child: ListView.separated(
                              itemCount: controller.cartList.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 1.h).copyWith(bottom: controller.cartList.isNotEmpty ? 26.h : 2.h),
                              itemBuilder: (context, index) {
                                Rx<CartModel> product = controller.cartList[index].obs;

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
                                        padding: EdgeInsets.only(top: 1.h),
                                        child: Column(
                                          children: [
                                            ///Name
                                            Tooltip(
                                              message: product.value.title,
                                              child: Text(
                                                "◆ ${product.value.title ?? ""} ◆",
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: AppColors.BLACK_COLOR,
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),

                                            ///Image
                                            Center(
                                              child: CachedNetworkImage(
                                                cacheKey: product.value.image,
                                                imageUrl: product.value.image ?? '',
                                                fit: BoxFit.contain,
                                                width: 36.1.w,
                                                progressIndicatorBuilder: (context, url, progress) {
                                                  return LoadingWidget(width: 20.w);
                                                },
                                                errorWidget: (context, url, error) {
                                                  return Icon(
                                                    FontAwesomeIcons.bug,
                                                    color: AppColors.DARK_RED_COLOR,
                                                    size: 5.w,
                                                  );
                                                },
                                              ),
                                            ),

                                            ///Product Details
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                ///Size, MRP, Amount & Add
                                                for (int i = 0; i < (product.value.sizes?.length ?? 0); i++) ...[
                                                  SizedBox(
                                                    width: 43.w,
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        ///Size
                                                        Obx(() {
                                                          return DecoratedBox(
                                                            decoration: BoxDecoration(
                                                              border: Border.all(
                                                                color: AppColors.TEXT_BLACK_COLOR,
                                                                width: 1.5,
                                                              ),
                                                              borderRadius: BorderRadius.circular(7),
                                                            ),
                                                            child: Padding(
                                                              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                                                              child: Text(
                                                                product.value.sizes?[i].size ?? " ",
                                                                style: TextStyle(
                                                                  color: AppColors.BLACK_COLOR,
                                                                  fontSize: 15.sp,
                                                                  fontWeight: FontWeight.w500,
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        }),
                                                        SizedBox(height: 1.h),

                                                        ///MRP & Amount
                                                        Center(
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              ///MRP
                                                              Obx(() {
                                                                RxInt totalQuantityFiveLiterInCart = 0.obs;
                                                                RxInt totalQuantityMLInCart = 0.obs;
                                                                for (var element in controller.cartList) {
                                                                  element.sizes?.forEach((e) {
                                                                    if (e.size == AppConstance.fiveLiter) {
                                                                      totalQuantityFiveLiterInCart.value += (e.quantity?.toInt() ?? 0);
                                                                    }
                                                                  });
                                                                }
                                                                for (var element in controller.cartList) {
                                                                  element.sizes?.forEach((e) {
                                                                    if (e.size == AppConstance.ml) {
                                                                      totalQuantityMLInCart.value += (e.quantity?.toInt() ?? 0);
                                                                    }
                                                                  });
                                                                }
                                                                return Text.rich(
                                                                  TextSpan(
                                                                    text: AppStrings.mrp.tr,
                                                                    children: [
                                                                      TextSpan(
                                                                        text: '₹ ${totalQuantityFiveLiterInCart.value >= 2 || totalQuantityMLInCart.value > 6 || (product.value.sizes?[i].size == AppConstance.fiveLiter && (product.value.sizes?[i].quantity?.toInt() ?? 0) > 1) || (product.value.sizes?[i].size == AppConstance.ml && (product.value.sizes?[i].quantity?.toInt() ?? 0) > 6) ? (product.value.sizes?[i].price) : (product.value.sizes?[i].mrp)}',
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

                                                              ///Total Amount
                                                              Obx(() {
                                                                return Text.rich(
                                                                  TextSpan(
                                                                    text: AppStrings.totalAmount.tr,
                                                                    children: [
                                                                      TextSpan(
                                                                        text: "\n₹ ${product.value.sizes?[i].amount}",
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
                                                        ),
                                                        SizedBox(height: 1.5.h),

                                                        ///Add
                                                        Obx(() {
                                                          if (controller.cartList.isNotEmpty && product.value.sizes?[i].quantity != null && product.value.sizes?[i].quantity?.toInt() != 0) {
                                                            return Center(
                                                              child: DecoratedBox(
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
                                                                      height: 4.5.h,
                                                                      child: TextButton(
                                                                        style: TextButton.styleFrom(
                                                                          padding: EdgeInsets.zero,
                                                                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                                          shape: const RoundedRectangleBorder(
                                                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                                                                          ),
                                                                        ),
                                                                        onPressed: () {
                                                                          product.value.sizes?[i].setQuantity = "${(product.value.sizes?[i].quantity?.toInt() ?? 1) - 1}";
                                                                          product.value.sizes?[i].setAmount = "0.00".grandTotalBySize(controller.cartList, product.value.sizes?[i].quantity, product.value.sizes?[i].size, product.value.sizes?[i].mrp, product.value.sizes?[i].price);
                                                                          if (product.value.sizes?.every((element) => element.quantity == "0" || element.quantity == null || element.quantity?.isEmpty == true) == true) {
                                                                            controller.cartList.removeWhere((element) => element.productId == product.value.productId);
                                                                          } else {
                                                                            if (product.value.sizes?.any((element) => element.productDataId == product.value.sizes?[i].productDataId) == true) {
                                                                              final sizeData = product.value.sizes?.firstWhereOrNull((element) => element.productDataId == product.value.sizes?[i].productDataId);
                                                                              if (sizeData?.quantity == "0" || sizeData?.quantity == null || sizeData?.quantity?.isEmpty == true) {
                                                                                controller.cartList.firstWhereOrNull((element) => element.productId == product.value.productId)?.removeSizes = sizeData?.productDataId;
                                                                              }
                                                                            }
                                                                          }
                                                                          for (var element in controller.cartList) {
                                                                            element.sizes?.forEach((e) {
                                                                              e.setAmount = "0.00".grandTotalBySize(controller.cartList, e.quantity, e.size, e.mrp, e.price);
                                                                            });
                                                                          }
                                                                          product.update((val) {
                                                                            controller.totalPayableAmount.value = controller.cartList.grandTotal();
                                                                            setData(AppConstance.cartStorage, controller.cartList.map((element) => element.toJson()).toList());
                                                                            controller.cartList.refresh();
                                                                          });
                                                                        },
                                                                        child: Icon(
                                                                          Icons.remove_rounded,
                                                                          color: AppColors.DARK_RED_COLOR,
                                                                        ),
                                                                      ).paddingZero,
                                                                    ),

                                                                    ///Count
                                                                    Obx(() {
                                                                      return SizedBox(
                                                                        width: 10.w,
                                                                        child: Text(
                                                                          product.value.sizes?[i].quantity ?? '',
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
                                                                      height: 4.5.h,
                                                                      width: 13.w,
                                                                      child: TextButton(
                                                                        onPressed: () {
                                                                          product.value.sizes?[i].setQuantity = "${(product.value.sizes?[i].quantity?.toInt() ?? 0) + 1}";
                                                                          product.value.sizes?[i].setAmount = "0.00".grandTotalBySize(controller.cartList, product.value.sizes?[i].quantity, product.value.sizes?[i].size, product.value.sizes?[i].mrp, product.value.sizes?[i].price);
                                                                          for (var element in controller.cartList) {
                                                                            element.sizes?.forEach((e) {
                                                                              e.setAmount = "0.00".grandTotalBySize(controller.cartList, e.quantity, e.size, e.mrp, e.price);
                                                                              controller.cartList.refresh();
                                                                            });
                                                                          }
                                                                          product.update((val) {
                                                                            controller.totalPayableAmount.value = controller.cartList.grandTotal();
                                                                            setData(AppConstance.cartStorage, controller.cartList.map((element) => element.toJson()).toList());
                                                                            controller.cartList.refresh();
                                                                          });
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
                                                              ),
                                                            );
                                                          } else {
                                                            return const SizedBox();
                                                          }
                                                        }),
                                                        SizedBox(height: 2.h),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ],
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
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  Future<void> showBottomSheetAddress({
    required BuildContext context,
    required String selectAddressId,
  }) async {
    RxInt selectedAddressIndex = controller.addressList.indexWhere((element) => element.addressId == selectAddressId).obs;
    RxBool isEdited = false.obs;

    GlobalKey<FormState> editAddressFormKey = GlobalKey<FormState>();
    RxString editAddressId = "".obs;
    TextEditingController addressController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();
    RxInt selectedPinCodeIndex = (-1).obs;

    await showModalBottomSheet(
      context: context,
      constraints: BoxConstraints(maxWidth: 100.w, minWidth: 100.w, maxHeight: 90.h, minHeight: 0.h),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      isScrollControlled: true,
      useRootNavigator: true,
      clipBehavior: Clip.hardEdge,
      backgroundColor: AppColors.WHITE_COLOR,
      builder: (context) {
        final keyboardPadding = MediaQuery.of(context).viewInsets.bottom;
        return GestureDetector(
          onTap: () => Utils.unfocus(),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.WHITE_COLOR,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ///Back & Edit/Select
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ///Back
                        Obx(() {
                          return IconButton(
                            onPressed: controller.isAddEditDefaultAddressLoading.isTrue
                                ? () {}
                                : () {
                                    Utils.unfocus();
                                    if (isEdited.isTrue) {
                                      isEdited.toggle();
                                    } else {
                                      Get.back();
                                    }
                                  },
                            icon: Obx(() {
                              return AnimatedCrossFade(
                                firstChild: Icon(
                                  FontAwesomeIcons.xmark,
                                  color: AppColors.PRIMARY_COLOR,
                                  size: 6.w,
                                ),
                                secondChild: Icon(
                                  FontAwesomeIcons.angleLeft,
                                  color: AppColors.PRIMARY_COLOR,
                                  size: 6.w,
                                ),
                                duration: const Duration(milliseconds: 300),
                                crossFadeState: isEdited.isTrue ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                              );
                            }),
                          );
                        }),

                        ///Edit/Select
                        TextButton(
                          onPressed: () async {
                            Utils.unfocus();
                            if (isEdited.isTrue) {
                              final isValidate = editAddressFormKey.currentState?.validate();

                              if (isValidate == true) {
                                await controller
                                    .editAddressApiCall(
                                  addressId: editAddressId.value,
                                  address: addressController.text.trim(),
                                  pinCode: controller.pinCodesList[selectedPinCodeIndex.value],
                                  phone: phoneNumberController.text.isNotEmpty ? phoneNumberController.text.trim() : null,
                                )
                                    .then((value) {
                                  isEdited(false);
                                  editAddressId("");
                                });
                              }
                            } else {
                              await controller.makeDefaultAddressApiCall(addressId: controller.addressList[selectedAddressIndex.value].addressId ?? "");
                            }
                          },
                          child: Obx(() {
                            return AnimatedCrossFade(
                              firstChild: controller.isAddEditDefaultAddressLoading.isTrue
                                  ? LoadingWidget(width: 8.w)
                                  : Text(
                                      AppStrings.select.tr,
                                      style: TextStyle(
                                        color: AppColors.DARK_GREEN_COLOR,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                              secondChild: controller.isAddEditDefaultAddressLoading.isTrue
                                  ? LoadingWidget(width: 10.w)
                                  : Text(
                                      AppStrings.edit.tr,
                                      style: TextStyle(
                                        color: AppColors.WARNING_COLOR,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                              duration: const Duration(milliseconds: 300),
                              crossFadeState: isEdited.isTrue ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                            );
                          }),
                        ),
                      ],
                    ),
                  ),

                  ///Title & Subtitle
                  Padding(
                    padding: EdgeInsets.only(left: 15.w, right: 5.w),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ///Title
                          Obx(() {
                            return AnimatedCrossFade(
                              firstChild: Text(
                                AppStrings.addresses.tr,
                                style: TextStyle(
                                  color: AppColors.BLACK_COLOR,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              secondChild: Text(
                                AppStrings.editAddress.tr,
                                style: TextStyle(
                                  color: AppColors.BLACK_COLOR,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              duration: const Duration(milliseconds: 300),
                              crossFadeState: isEdited.isTrue ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                            );
                          }),

                          ///Subtitle
                          Obx(() {
                            return AnimatedCrossFade(
                              firstChild: Text(
                                AppStrings.selectAddressToPlaceOrder.tr,
                                style: TextStyle(
                                  color: AppColors.BLACK_COLOR,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              secondChild: Text(
                                AppStrings.changeAnAddressDetails.tr,
                                style: TextStyle(
                                  color: AppColors.BLACK_COLOR,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              duration: const Duration(milliseconds: 300),
                              crossFadeState: isEdited.isTrue ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: AppColors.BLACK_COLOR,
                    thickness: 0.5,
                  ),

                  ///Address List
                  Obx(() {
                    return Flexible(
                      child: AnimatedCrossFade(
                        firstChild: Obx(
                          () {
                            if (controller.isGetAddressLoading.isTrue) {
                              return SizedBox(
                                height: 20.h,
                                child: const Center(
                                  child: LoadingWidget(),
                                ),
                              );
                            } else if (controller.addressList.isEmpty) {
                              return SizedBox(
                                height: 20.h,
                                child: Center(
                                  child: Text(
                                    AppStrings.noDataFound.tr,
                                    style: TextStyle(
                                      color: AppColors.BLACK_COLOR,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return ListView.separated(
                                itemCount: controller.addressList.length,
                                shrinkWrap: true,
                                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                                itemBuilder: (context, index) {
                                  final addressDetails = controller.addressList[index];
                                  return GestureDetector(
                                    onTap: () {
                                      selectedAddressIndex(index);
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        ///Address
                                        Flexible(
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              ///Checkmark
                                              Obx(() {
                                                return AnimatedContainer(
                                                  duration: const Duration(milliseconds: 300),
                                                  decoration: BoxDecoration(
                                                    color: selectedAddressIndex.value == index ? AppColors.DARK_GREEN_COLOR : AppColors.WHITE_COLOR,
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: selectedAddressIndex.value == index ? AppColors.DARK_GREEN_COLOR : AppColors.BLACK_COLOR,
                                                      width: 1,
                                                    ),
                                                  ),
                                                  padding: EdgeInsets.all(1.w),
                                                  child: Icon(
                                                    Icons.check_rounded,
                                                    color: AppColors.WHITE_COLOR,
                                                    size: 4.w,
                                                  ),
                                                );
                                              }),
                                              SizedBox(width: 2.w),
                                              Flexible(
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    ///Address
                                                    Flexible(
                                                      child: TextWithTooltipWidget(
                                                        child: Text(
                                                          addressDetails.address ?? "",
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

                                                    ///PinCode
                                                    Row(
                                                      children: [
                                                        Text(
                                                          addressDetails.pinCode ?? "",
                                                          style: TextStyle(
                                                            color: AppColors.BLACK_COLOR,
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 15.sp,
                                                          ),
                                                        ),
                                                        if (addressDetails.phone != null && addressDetails.phone?.isNotEmpty == true) ...[
                                                          SizedBox(
                                                            height: 2.h,
                                                            child: VerticalDivider(
                                                              color: AppColors.HINT_GREY_COLOR,
                                                              thickness: 1,
                                                            ),
                                                          ),
                                                          Text(
                                                            "+91 ${addressDetails.phone ?? ""}",
                                                            style: TextStyle(
                                                              color: AppColors.BLACK_COLOR,
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 15.sp,
                                                            ),
                                                          ),
                                                        ],
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 2.w),

                                        ///Edit & Delete
                                        Row(
                                          children: [
                                            ///Edit
                                            ElevatedButton(
                                              onPressed: () {
                                                editAddressId(addressDetails.addressId ?? "");
                                                addressController.text = addressDetails.address ?? "";
                                                phoneNumberController.text = addressDetails.phone ?? "";
                                                selectedPinCodeIndex.value = controller.pinCodesList.indexWhere((element) => element == addressDetails.pinCode);
                                                isEdited(true);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: AppColors.WARNING_COLOR,
                                                padding: EdgeInsets.zero,
                                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                minimumSize: Size(8.w, 8.w),
                                                maximumSize: Size(8.w, 8.w),
                                                elevation: 4,
                                              ),
                                              child: Icon(
                                                Icons.edit_rounded,
                                                size: 4.w,
                                                color: AppColors.WHITE_COLOR,
                                              ),
                                            ),
                                            SizedBox(width: 2.w),

                                            ///Delete
                                            ElevatedButton(
                                              onPressed: () async {
                                                Get.back(closeOverlays: true);
                                                if (selectedAddressIndex.value != index) {
                                                  await showConfirmationDialog(
                                                    context: context,
                                                    title: AppStrings.areYouSureYouWantToDeleteSelectedAddress.tr,
                                                    confirmText: AppStrings.yesDelete.tr,
                                                    icon: Icons.delete_forever_rounded,
                                                    onConfirm: () async {
                                                      await controller.deleteAddressApiCall(addressId: addressDetails.addressId ?? "");
                                                    },
                                                  );
                                                } else {
                                                  Utils.handleMessage(message: AppStrings.defaultAddressCantBeDeleted.tr, isError: true);
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: AppColors.DARK_RED_COLOR,
                                                padding: EdgeInsets.zero,
                                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                minimumSize: Size(8.w, 8.w),
                                                maximumSize: Size(8.w, 8.w),
                                                elevation: 4,
                                              ),
                                              child: Icon(
                                                Icons.delete_forever_rounded,
                                                size: 4.w,
                                                color: AppColors.WHITE_COLOR,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return Divider(
                                    color: AppColors.SECONDARY_COLOR,
                                    thickness: 1.5,
                                  );
                                },
                              );
                            }
                          },
                        ),
                        secondChild: SingleChildScrollView(
                          child: Form(
                            key: editAddressFormKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(height: 2.h),

                                ///Address
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                                  child: TextFieldWidget(
                                    controller: addressController,
                                    hintText: AppStrings.enterAddress.tr,
                                    textFieldWidth: 80.w,
                                    maxLength: 150,
                                    validator: controller.addressValidator,
                                  ),
                                ),
                                SizedBox(height: 1.2.h),

                                ///Pin-code
                                Obx(() {
                                  return DropdownButtonFormField(
                                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                                    validator: controller.pinCodeValidator,
                                    value: selectedPinCodeIndex.value == -1 ? null : selectedPinCodeIndex.value,
                                    onChanged: (value) {
                                      if (value != null) {
                                        selectedPinCodeIndex(value);
                                      } else {
                                        selectedPinCodeIndex(-1);
                                      }
                                    },
                                    hint: Text(
                                      AppStrings.selectPinCode.tr,
                                      style: TextStyle(
                                        color: AppColors.HINT_GREY_COLOR,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    icon: Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      color: AppColors.GREY_COLOR,
                                      size: 5.w,
                                    ),
                                    dropdownColor: AppColors.WHITE_COLOR,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: AppColors.TEXTFIELD_COLOR,
                                      errorStyle: TextStyle(
                                        color: AppColors.ERROR_COLOR,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                          color: AppColors.ERROR_COLOR,
                                          width: 1,
                                        ),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                          color: AppColors.ERROR_COLOR,
                                          width: 1,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: AppColors.TRANSPARENT,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: AppColors.TRANSPARENT,
                                        ),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: AppColors.TRANSPARENT,
                                        ),
                                      ),
                                      errorMaxLines: 2,
                                      isDense: true,
                                      contentPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h).copyWith(right: 1.5.w),
                                    ),
                                    selectedItemBuilder: selectedPinCodeIndex.value == -1
                                        ? null
                                        : (context) {
                                            return [
                                              for (int i = 0; i < controller.pinCodesList.length; i++)
                                                Text(
                                                  controller.pinCodesList[i],
                                                  style: TextStyle(
                                                    color: selectedPinCodeIndex.value == i ? AppColors.PRIMARY_COLOR : AppColors.BLACK_COLOR,
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                            ];
                                          },
                                    items: [
                                      for (int i = 0; i < controller.pinCodesList.length; i++)
                                        DropdownMenuItem(
                                          value: i,
                                          child: Text(
                                            controller.pinCodesList[i],
                                            style: TextStyle(
                                              color: AppColors.BLACK_COLOR,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                    ],
                                  );
                                }),
                                SizedBox(height: 2.h),

                                ///Address
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5.w).copyWith(bottom: keyboardPadding != 0 ? 22.h : 0),
                                  child: TextFieldWidget(
                                    controller: phoneNumberController,
                                    hintText: AppStrings.enterPhoneNumberOptional.tr,
                                    textFieldWidth: 80.w,
                                    maxLength: 10,
                                    keyboardType: TextInputType.number,
                                    validator: controller.phoneNumberValidator,
                                  ),
                                ),
                                SizedBox(height: 5.h),
                              ],
                            ),
                          ),
                        ),
                        duration: const Duration(milliseconds: 300),
                        crossFadeState: isEdited.isTrue ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                      ),
                    );
                  }),
                  SizedBox(height: 5.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> showBottomSheetAddNewAddress({
    required BuildContext context,
  }) async {
    GlobalKey<FormState> addNewAddressFormKey = GlobalKey<FormState>();
    TextEditingController addressController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();
    RxInt selectedPinCodeIndex = (-1).obs;
    await showModalBottomSheet(
      context: context,
      constraints: BoxConstraints(maxWidth: 100.w, minWidth: 100.w, maxHeight: 90.h, minHeight: 0.h),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      isScrollControlled: true,
      useRootNavigator: true,
      clipBehavior: Clip.hardEdge,
      backgroundColor: AppColors.WHITE_COLOR,
      builder: (context) {
        final keyboardPadding = MediaQuery.of(context).viewInsets.bottom;
        return GestureDetector(
          onTap: Utils.unfocus,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.WHITE_COLOR,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h),
              child: Form(
                key: addNewAddressFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ///Title & Back
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ///Title
                          Text(
                            AppStrings.addNewAddress.tr,
                            style: TextStyle(
                              color: AppColors.BLACK_COLOR,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          ///Back
                          IconButton(
                            onPressed: () {
                              Utils.unfocus();
                              Get.back();
                            },
                            icon: Icon(
                              FontAwesomeIcons.xmark,
                              color: AppColors.PRIMARY_COLOR,
                              size: 6.w,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: AppColors.BLACK_COLOR,
                      thickness: 0.5,
                    ),
                    SizedBox(height: 2.h),

                    ///Address
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: TextFieldWidget(
                        controller: addressController,
                        hintText: AppStrings.enterAddress.tr,
                        textFieldWidth: 80.w,
                        maxLength: 150,
                        validator: controller.addressValidator,
                      ),
                    ),
                    SizedBox(height: 1.2.h),

                    ///Pin-code
                    Obx(() {
                      return DropdownButtonFormField(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        validator: controller.pinCodeValidator,
                        value: selectedPinCodeIndex.value == -1 ? null : selectedPinCodeIndex.value,
                        onChanged: (value) {
                          if (value != null) {
                            selectedPinCodeIndex(value);
                          } else {
                            selectedPinCodeIndex(-1);
                          }
                        },
                        hint: Text(
                          AppStrings.selectPinCode.tr,
                          style: TextStyle(
                            color: AppColors.HINT_GREY_COLOR,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: AppColors.GREY_COLOR,
                          size: 5.w,
                        ),
                        dropdownColor: AppColors.WHITE_COLOR,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.TEXTFIELD_COLOR,
                          errorStyle: TextStyle(
                            color: AppColors.ERROR_COLOR,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: AppColors.ERROR_COLOR,
                              width: 1,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: AppColors.ERROR_COLOR,
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: AppColors.TRANSPARENT,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: AppColors.TRANSPARENT,
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: AppColors.TRANSPARENT,
                            ),
                          ),
                          errorMaxLines: 2,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h).copyWith(right: 1.5.w),
                        ),
                        selectedItemBuilder: selectedPinCodeIndex.value == -1
                            ? null
                            : (context) {
                                return [
                                  for (int i = 0; i < controller.pinCodesList.length; i++)
                                    Text(
                                      controller.pinCodesList[i],
                                      style: TextStyle(
                                        color: selectedPinCodeIndex.value == i ? AppColors.PRIMARY_COLOR : AppColors.BLACK_COLOR,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                ];
                              },
                        items: [
                          for (int i = 0; i < controller.pinCodesList.length; i++)
                            DropdownMenuItem(
                              value: i,
                              child: Text(
                                controller.pinCodesList[i],
                                style: TextStyle(
                                  color: AppColors.BLACK_COLOR,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                        ],
                      );
                    }),
                    SizedBox(height: 2.h),

                    ///Phone Number
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w).copyWith(bottom: keyboardPadding != 0 ? 17.h : 0),
                      child: TextFieldWidget(
                        controller: phoneNumberController,
                        hintText: AppStrings.enterPhoneNumberOptional.tr,
                        textFieldWidth: 80.w,
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        validator: controller.phoneNumberValidator,
                      ),
                    ),
                    SizedBox(height: 5.h),

                    ///Add
                    Obx(() {
                      return ButtonWidget(
                        onPressed: () async {
                          final isValidate = addNewAddressFormKey.currentState?.validate();
                          if (isValidate == true) {
                            await controller.addAddressApiCall(
                              address: addressController.text.trim(),
                              pinCode: controller.pinCodesList[selectedPinCodeIndex.value],
                              phone: phoneNumberController.text.isNotEmpty ? phoneNumberController.text.trim() : null,
                            );
                          }
                        },
                        isLoading: controller.isAddEditDefaultAddressLoading.isTrue,
                        fixedSize: Size(90.w, 6.h),
                        buttonTitle: AppStrings.add.tr,
                      );
                    }),
                    SizedBox(height: 3.h),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
