import 'package:bombay_chowpati/Screens/home_screen/cart_screen/order_history_screen/order_history_controller.dart';
import 'package:get/get.dart';

class OrderHistoryBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(OrderHistoryController());
  }
}
