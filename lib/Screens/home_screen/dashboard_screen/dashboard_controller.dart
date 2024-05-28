import 'package:bombay_chowpati/Network/models/dashboard_models/get_products_model.dart' as get_products;
import 'package:bombay_chowpati/Network/services/dashboard_services/dashboard_service.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  RxBool isGetProductsLoading = false.obs;

  RxList<get_products.Data> productsList = RxList();

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
        productsList.addAll(productsModel.data ?? []);
      }
    } finally {
      isGetProductsLoading(false);
    }
  }
}
