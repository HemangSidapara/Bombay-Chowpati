import 'package:bombay_chowpati/Screens/home_screen/favourite_screen/favourite_controller.dart';
import 'package:get/get.dart';

class FavouriteBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(FavouriteController());
  }
}
