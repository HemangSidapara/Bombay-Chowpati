import 'package:bombay_chowpati/Screens/home_screen/settings_screen/privacy_policy_screen/privacy_policy_controller.dart';
import 'package:get/get.dart';

class PrivacyPolicyBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(PrivacyPolicyController());
  }
}
