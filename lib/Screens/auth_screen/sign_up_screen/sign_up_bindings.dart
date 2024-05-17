import 'package:bombay_chowpati/Screens/auth_screen/sign_up_screen/sign_up_controller.dart';
import 'package:get/get.dart';

class SignUpBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(SignUpController());
  }
}
