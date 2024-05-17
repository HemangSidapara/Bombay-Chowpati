import 'package:bombay_chowpati/Screens/auth_screen/auth_controller.dart';
import 'package:get/get.dart';

class AuthBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
  }
}
