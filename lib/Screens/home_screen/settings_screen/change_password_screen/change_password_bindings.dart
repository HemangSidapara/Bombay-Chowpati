import 'package:bombay_chowpati/Screens/home_screen/settings_screen/change_password_screen/change_password_controller.dart';
import 'package:get/get.dart';

class ChangePasswordBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(ChangePasswordController());
  }
}
