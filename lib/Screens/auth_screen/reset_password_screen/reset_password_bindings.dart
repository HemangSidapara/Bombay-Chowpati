import 'package:bombay_chowpati/Screens/auth_screen/reset_password_screen/reset_password_controller.dart';
import 'package:get/get.dart';

class ResetPasswordBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(ResetPasswordController());
  }
}
