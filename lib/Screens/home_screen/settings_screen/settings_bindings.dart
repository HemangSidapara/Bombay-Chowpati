import 'package:bombay_chowpati/Screens/home_screen/settings_screen/settings_controller.dart';
import 'package:get/get.dart';

class SettingsBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(SettingsController());
  }
}
