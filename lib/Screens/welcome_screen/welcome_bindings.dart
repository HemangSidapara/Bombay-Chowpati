import 'package:bombay_chowpati/Screens/welcome_screen/welcome_controller.dart';
import 'package:get/get.dart';

class WelcomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(WelcomeController());
  }
}
