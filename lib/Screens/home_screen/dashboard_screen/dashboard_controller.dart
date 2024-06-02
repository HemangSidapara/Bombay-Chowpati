import 'package:bombay_chowpati/Network/models/dashboard_models/get_products_model.dart' as get_products;
import 'package:bombay_chowpati/Network/services/dashboard_services/dashboard_service.dart';
import 'package:bombay_chowpati/Screens/home_screen/cart_screen/cart_controller.dart';
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
        productsList.addAll(productsModel.data ?? []);
        searchedProductsList.addAll(productsModel.data ?? []);
        for (var element in (productsModel.data ?? <get_products.Data>[])) {
          selectedProductData.add(element.productData?.firstOrNull);
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
