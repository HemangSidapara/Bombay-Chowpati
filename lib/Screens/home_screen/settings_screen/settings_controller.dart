import 'package:bombay_chowpati/Constants/app_constance.dart';
import 'package:bombay_chowpati/Constants/get_storage.dart';
import 'package:bombay_chowpati/Network/services/utils_services/get_package_info_service.dart';
import 'package:bombay_chowpati/Routes/app_pages.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  RxString appVersion = ''.obs;

  RxBool isGujaratiLang = false.obs;
  RxBool isHindiLang = false.obs;
  RxBool isUpdateLoading = false.obs;
  RxInt downloadedProgress = 0.obs;

  RxBool isLogOutLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    if (getString(AppConstance.languageCode) == 'gu') {
      isGujaratiLang.value = true;
      isHindiLang.value = false;
    } else if (getString(AppConstance.languageCode) == 'hi') {
      isGujaratiLang.value = false;
      isHindiLang.value = true;
    } else if (getString(AppConstance.languageCode) == 'en') {
      isGujaratiLang.value = false;
      isHindiLang.value = false;
    } else {
      isGujaratiLang.value = false;
      isHindiLang.value = false;
    }
    appVersion.value = (await GetPackageInfoService.instance.getInfo()).version;
  }

  Future<void> checkLogOut() async {
    clearData();
    Get.offAllNamed(Routes.authScreen);
  }
}
