import 'package:bombay_chowpati/Screens/home_screen/settings_screen/personal_details_screen/personal_details_controller.dart';
import 'package:get/get.dart';

class PersonalDetailsBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(PersonalDetailsController());
  }
}
