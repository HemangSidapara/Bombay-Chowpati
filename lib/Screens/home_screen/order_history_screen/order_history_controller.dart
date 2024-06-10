import 'package:bombay_chowpati/Network/models/order_history_models/get_orders_model.dart' as order_model;
import 'package:bombay_chowpati/Network/services/order_history_services/order_history_service.dart';
import 'package:get/get.dart';

class OrderHistoryController extends GetxController {
  RxBool isGetOrdersLoading = false.obs;
  RxBool isCancelOrderLoading = false.obs;

  RxList<order_model.Data> orderList = RxList();

  @override
  void onInit() async {
    super.onInit();
    await getOrdersApiCall();
  }

  Future<void> getOrdersApiCall() async {
    try {
      isGetOrdersLoading(true);
      final response = await OrderHistoryService.getOrdersService();

      if (response.isSuccess) {
        order_model.GetOrdersModel ordersModel = order_model.GetOrdersModel.fromJson(response.response?.data);

        orderList.clear();
        orderList.addAll(ordersModel.data ?? []);
      }
    } finally {
      isGetOrdersLoading(false);
    }
  }

  Future<void> cancelOrderApiCall({required String orderId}) async {
    try {
      isCancelOrderLoading(true);
      final response = await OrderHistoryService.cancelOrderService(orderId: orderId);

      if (response.isSuccess) {
        await getOrdersApiCall();
      }
    } finally {
      isCancelOrderLoading(false);
    }
  }
}
