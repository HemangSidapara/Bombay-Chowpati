import 'package:bombay_chowpati/Network/models/settings_models/privacy_policy_model.dart';
import 'package:bombay_chowpati/Network/services/settings_services/settings_service.dart';
import 'package:get/get.dart';

class PrivacyPolicyController extends GetxController {
  RxBool isLoadingPrivacy = true.obs;

  RxString privacyPolicyTag = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    await checkPrivacyPolicy();
  }

  Future<void> checkPrivacyPolicy() async {
    try {
      isLoadingPrivacy(true);
      final response = await SettingsService.privacyPolicyService();

      if (response.isSuccess) {
        PrivacyPolicyModel privacyPolicyModel = PrivacyPolicyModel.fromJson(response.response?.data);

        privacyPolicyTag(privacyPolicyModel.privacyPolicy ?? '');
      }
    } finally {
      isLoadingPrivacy(false);
    }
  }
}
