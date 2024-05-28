import 'package:bombay_chowpati/Network/models/settings_models/terms_and_conditions_model.dart';
import 'package:bombay_chowpati/Network/services/settings_services/settings_service.dart';
import 'package:get/get.dart';

class TermsAndConditionsController extends GetxController {
  RxBool isLoadingTerms = true.obs;

  RxString termsAndConditionsTag = ''.obs;

  late int id;

  @override
  void onInit() async {
    super.onInit();
    await checkPrivacyPolicy();
  }

  Future<void> checkPrivacyPolicy() async {
    try {
      isLoadingTerms(true);
      final response = await SettingsService.termsAndConditionsService();

      if (response.isSuccess) {
        TermsAndConditionsModel termsAndConditionsModel = TermsAndConditionsModel.fromJson(response.response?.data);

        termsAndConditionsTag(termsAndConditionsModel.termsCondition ?? '');
      }
    } finally {
      isLoadingTerms(false);
    }
  }
}
