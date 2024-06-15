import 'package:bombay_chowpati/Constants/app_constance.dart';
import 'package:bombay_chowpati/Constants/get_storage.dart';
import 'package:bombay_chowpati/Network/models/cart_models/cart_model.dart';
import 'package:bombay_chowpati/Network/models/dashboard_models/get_products_model.dart' as get_products;
import 'package:bombay_chowpati/Network/services/dashboard_services/dashboard_service.dart';
import 'package:bombay_chowpati/Screens/home_screen/cart_screen/cart_controller.dart';
import 'package:bombay_chowpati/Utils/app_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  TextEditingController searchController = TextEditingController();

  RxBool isGetProductsLoading = false.obs;

  RxList<get_products.Data> productsList = RxList();
  RxList<get_products.Data> searchedProductsList = RxList();

  CartController cartController = Get.put(CartController());

  RxList<get_products.ProductData?> selectedProductData = RxList();

  @override
  void onInit() async {
    super.onInit();
    await getProductsApiCall();
  }

  Future<void> getProductsApiCall() async {
    try {
      isGetProductsLoading(true);
      final response = await DashboardService.getProductsService(fcmToken: 'Test');

      if (response.isSuccess) {
        get_products.GetProductsModel productsModel = get_products.GetProductsModel.fromJson(response.response?.data);

        productsList.clear();
        searchedProductsList.clear();
        selectedProductData.clear();
        cartController.cartList.clear();
        productsList.addAll(productsModel.data ?? []);
        searchedProductsList.addAll(productsModel.data ?? []);
        for (var element in (productsModel.data ?? <get_products.Data>[])) {
          selectedProductData.add(
            get_products.ProductData(
              productId: element.pid,
              id: element.productData?.firstOrNull?.id,
              mrp: element.productData?.firstOrNull?.mrp,
              price: element.productData?.firstOrNull?.price,
              size: element.productData?.firstOrNull?.size,
            ),
          );
        }
        if (getData(AppConstance.cartStorage) != null) {
          cartController.cartList.addAll((getData(AppConstance.cartStorage) as List<dynamic>).map((e) => CartModel.fromJson(e)));
          cartController.totalPayableAmount.value = cartController.cartList.grandTotal();
        }
        if (cartController.cartList.isNotEmpty) {
          for (var product in cartController.cartList) {
            final getIndex = selectedProductData.indexWhere((element) => element?.productId == product.productId);
            if (getIndex != -1) {
              selectedProductData.replaceRange(
                getIndex,
                getIndex + 1,
                [
                  get_products.ProductData(
                    productId: product.productId,
                    id: product.productDataId,
                    mrp: product.mrp,
                    price: product.price,
                    size: product.size,
                  ),
                ],
              );
            }
          }
        }
      }
    } finally {
      isGetProductsLoading(false);
    }
  }

  Future<void> searchProductName(String searchedValue) async {
    searchedProductsList.clear();
    if (searchedValue.isNotEmpty) {
      searchedProductsList.addAll(productsList.where((element) => element.title?.toLowerCase().contains(searchedValue.toLowerCase()) == true));
    } else {
      searchedProductsList.addAll(productsList);
    }
  }
}
