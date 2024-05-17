import 'package:bombay_chowpati/Screens/auth_screen/forgot_password_screen/forgot_password_controller.dart';
import 'package:get/get.dart';

class ForgotPasswordBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(ForgotPasswordController());
  }
}
