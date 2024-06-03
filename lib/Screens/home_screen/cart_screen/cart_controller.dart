import 'package:bombay_chowpati/Network/models/cart_models/cart_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  RxList<CartModel> cartList = RxList();
  RxString totalPayableAmount = "".obs;
}
