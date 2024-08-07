import 'package:bombay_chowpati/Constants/app_colors.dart';
import 'package:bombay_chowpati/Constants/app_constance.dart';
import 'package:bombay_chowpati/Constants/app_strings.dart';
import 'package:bombay_chowpati/Constants/app_utils.dart';
import 'package:bombay_chowpati/Constants/get_storage.dart';
import 'package:bombay_chowpati/Network/models/cart_models/cart_model.dart';
import 'package:bombay_chowpati/Screens/home_screen/cart_screen/cart_controller.dart';
import 'package:bombay_chowpati/Screens/home_screen/dashboard_screen/dashboard_controller.dart';
import 'package:bombay_chowpati/Screens/home_screen/dashboard_screen/hand_shaken_animation.dart';
import 'package:bombay_chowpati/Screens/home_screen/home_controller.dart';
import 'package:bombay_chowpati/Utils/app_formatter.dart';
import 'package:bombay_chowpati/Widgets/loading_widget.dart';
import 'package:bombay_chowpati/Widgets/textfield_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
                    ///Remove
                    GestureDetector(
                      onTap: () {
                        controller.cartController.cartList.clear();
                        removeData(AppConstance.cartStorage);
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

                    ///Details
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
          body: Column(
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

              ///Offer
              SizedBox(
                height: 8.h,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 7.w).copyWith(bottom: 1.h),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.PRIMARY_COLOR,
                          width: 1.8,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                        child: Text(
                          AppStrings.offerOfferOffer.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.DARK_GREEN_COLOR,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

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
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppStrings.noDataFound.tr,
                            style: TextStyle(
                              color: AppColors.BLACK_COLOR,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              controller.searchController.clear();
                              await controller.getProductsApiCall();
                            },
                            child: Text(
                              AppStrings.refresh.tr,
                              style: TextStyle(
                                color: AppColors.FACEBOOK_BLUE_COLOR,
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return CustomRefreshIndicator(
                        onRefresh: () async {
                          controller.searchController.clear();
                          await controller.getProductsApiCall();
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
                              itemCount: controller.searchedProductsList.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 1.h).copyWith(bottom: controller.cartController.cartList.isNotEmpty ? 12.h : 4.h),
                              itemBuilder: (context, index) {
                                final product = controller.searchedProductsList[index];
                                Rx<CartModel?> productInCart = controller.cartController.cartList.firstWhereOrNull((element) => element.productId == product.pid).obs;
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
                                        padding: EdgeInsets.only(bottom: 2.h, top: 1.h, left: 2.w, right: 2.w),
                                        child: Column(
                                          children: [
                                            ///Name
                                            Tooltip(
                                              message: product.title,
                                              child: Text(
                                                "◆ ${product.title ?? ""} ◆",
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: AppColors.BLACK_COLOR,
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 0.5.h),

                                            ///Image
                                            Center(
                                              child: CachedNetworkImage(
                                                cacheKey: product.image,
                                                imageUrl: product.image ?? '',
                                                fit: BoxFit.contain,
                                                height: 18.h,
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
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                for (int i = 0; i < (product.productData?.length ?? 0); i++) ...[
                                                  SizedBox(
                                                    width: 40.w,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        ///Size
                                                        DecoratedBox(
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
                                                              product.productData?[i].size ?? " ",
                                                              style: TextStyle(
                                                                color: AppColors.BLACK_COLOR,
                                                                fontSize: 15.sp,
                                                                fontWeight: FontWeight.w500,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(height: 1.h),

                                                        ///MRP & Amount
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            ///MRP
                                                            Obx(() {
                                                              RxInt totalQuantityFiveLiterInCart = 0.obs;
                                                              RxInt totalQuantityMLInCart = 0.obs;
                                                              for (var element in controller.cartController.cartList) {
                                                                element.sizes?.forEach((e) {
                                                                  if (e.size == AppConstance.fiveLiter) {
                                                                    totalQuantityFiveLiterInCart.value += (e.quantity?.toInt() ?? 0);
                                                                  }
                                                                });
                                                              }
                                                              for (var element in controller.cartController.cartList) {
                                                                element.sizes?.forEach((e) {
                                                                  if (e.size == AppConstance.ml) {
                                                                    totalQuantityMLInCart.value += (e.quantity?.toInt() ?? 0);
                                                                  }
                                                                });
                                                              }
                                                              final sizeData = productInCart.value?.sizes?.firstWhereOrNull((element) => element.productDataId == product.productData?[i].id);
                                                              return Text.rich(
                                                                TextSpan(
                                                                  text: AppStrings.mrp.tr,
                                                                  children: [
                                                                    TextSpan(
                                                                      text: '₹ ${totalQuantityFiveLiterInCart.value >= 2 || totalQuantityMLInCart > 6 || (sizeData?.size == AppConstance.fiveLiter && (sizeData?.quantity?.toInt() ?? 0) > 1) || (sizeData?.size == AppConstance.ml && (sizeData?.quantity?.toInt() ?? 0) > 6) ? (product.productData?[i].price) : (product.productData?[i].mrp)}',
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
                                                              final sizeData = productInCart.value?.sizes?.firstWhereOrNull((element) => element.productDataId == product.productData?[i].id);
                                                              return Text.rich(
                                                                TextSpan(
                                                                  text: AppStrings.totalAmount.tr,
                                                                  children: [
                                                                    TextSpan(
                                                                      text: '\n${AppConstance.rupeeSign} ${sizeData?.amount ?? "0.00"}',
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
                                                          final sizeData = productInCart.value?.sizes?.firstWhereOrNull((element) => element.productDataId == product.productData?[i].id);
                                                          if (controller.cartController.cartList.isNotEmpty && sizeData?.quantity != null && sizeData?.quantity?.toInt() != 0) {
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
                                                                        sizeData?.setQuantity = "${(sizeData.quantity?.toInt() ?? 0) - 1}";
                                                                        sizeData?.setAmount = "0.00".grandTotalBySize(controller.cartController.cartList, sizeData.quantity, sizeData.size, sizeData.mrp, sizeData.price);
                                                                        if (productInCart.value?.sizes?.every((element) => element.quantity == "0" || element.quantity == null || element.quantity?.isEmpty == true) == true) {
                                                                          controller.cartController.cartList.removeWhere((element) => element.productId == product.pid);
                                                                        } else {
                                                                          if (productInCart.value?.sizes?.any((element) => element.productDataId == product.productData?[i].id) == true) {
                                                                            final sizeData = productInCart.value?.sizes?.firstWhereOrNull((element) => element.productDataId == product.productData?[i].id);
                                                                            if (sizeData?.quantity == "0" || sizeData?.quantity == null || sizeData?.quantity?.isEmpty == true) {
                                                                              controller.cartController.cartList.firstWhereOrNull((element) => element.productId == product.pid)?.removeSizes = sizeData?.productDataId;
                                                                            }
                                                                          }
                                                                        }
                                                                        for (var element in controller.cartController.cartList) {
                                                                          element.sizes?.forEach((e) {
                                                                            e.setAmount = "0.00".grandTotalBySize(controller.cartController.cartList, e.quantity, e.size, e.mrp, e.price);
                                                                          });
                                                                        }
                                                                        productInCart.update((val) {
                                                                          controller.cartController.totalPayableAmount.value = controller.cartController.cartList.grandTotal();
                                                                          setData(AppConstance.cartStorage, controller.cartController.cartList.map((element) => element.toJson()).toList());
                                                                          controller.cartController.cartList.refresh();
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
                                                                    final sizeData = productInCart.value?.sizes?.firstWhereOrNull((element) => element.productDataId == product.productData?[i].id);
                                                                    return SizedBox(
                                                                      width: 10.w,
                                                                      child: Text(
                                                                        sizeData?.quantity ?? '',
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
                                                                        sizeData?.setQuantity = "${(sizeData.quantity?.toInt() ?? 0) + 1}";
                                                                        sizeData?.setAmount = "0.00".grandTotalBySize(controller.cartController.cartList, sizeData.quantity, sizeData.size, sizeData.mrp, sizeData.price);
                                                                        for (var element in controller.cartController.cartList) {
                                                                          element.sizes?.forEach((e) {
                                                                            e.setAmount = "0.00".grandTotalBySize(controller.cartController.cartList, e.quantity, e.size, e.mrp, e.price);
                                                                            controller.cartController.cartList.refresh();
                                                                          });
                                                                        }
                                                                        productInCart.update((val) {
                                                                          controller.cartController.totalPayableAmount.value = controller.cartController.cartList.grandTotal();
                                                                          setData(AppConstance.cartStorage, controller.cartController.cartList.map((element) => element.toJson()).toList());
                                                                          controller.cartController.cartList.refresh();
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
                                                            );
                                                          } else {
                                                            return ElevatedButton(
                                                              onPressed: () {
                                                                if (controller.cartController.cartList.any((element) => element.productId == product.pid) == true) {
                                                                  controller.cartController.cartList.firstWhereOrNull((element) => element.productId == product.pid)?.setSizes = [
                                                                    SizeModel(
                                                                      productDataId: product.productData?[i].id,
                                                                      mrp: product.productData?[i].mrp,
                                                                      price: product.productData?[i].price,
                                                                      quantity: "1",
                                                                      amount: product.productData?[i].mrp,
                                                                      size: product.productData?[i].size,
                                                                    ),
                                                                  ];
                                                                  controller.cartController.cartList.refresh();
                                                                } else {
                                                                  controller.cartController.cartList.add(
                                                                    CartModel(
                                                                      productId: product.pid,
                                                                      title: product.title,
                                                                      image: product.image,
                                                                      sizes: [
                                                                        SizeModel(
                                                                          productDataId: product.productData?[i].id,
                                                                          mrp: product.productData?[i].mrp,
                                                                          price: product.productData?[i].price,
                                                                          quantity: "1",
                                                                          amount: product.productData?[i].mrp,
                                                                          size: product.productData?[i].size,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                }
                                                                for (var element in controller.cartController.cartList) {
                                                                  element.sizes?.forEach((e) {
                                                                    e.setAmount = "0.00".grandTotalBySize(controller.cartController.cartList, e.quantity, e.size, e.mrp, e.price);
                                                                  });
                                                                }
                                                                controller.cartController.totalPayableAmount.value = controller.cartController.cartList.grandTotal();
                                                                setData(AppConstance.cartStorage, controller.cartController.cartList.map((element) => element.toJson()).toList());
                                                              },
                                                              style: ElevatedButton.styleFrom(
                                                                backgroundColor: AppColors.WHITE_COLOR,
                                                                surfaceTintColor: AppColors.WHITE_COLOR,
                                                                elevation: 4,
                                                                fixedSize: Size(36.w, 5.h),
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
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
