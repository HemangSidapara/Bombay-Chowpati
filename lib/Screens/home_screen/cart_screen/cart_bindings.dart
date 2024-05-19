import 'package:bombay_chowpati/Screens/home_screen/cart_screen/cart_controller.dart';
import 'package:get/get.dart';

class CartBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(CartController());
  }
}
