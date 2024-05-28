import 'package:bombay_chowpati/Screens/home_screen/settings_screen/terms_and_conditions_screen/terms_and_conditions_controller.dart';
import 'package:get/get.dart';

class TermsAndConditionsBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(TermsAndConditionsController());
  }
}
