import 'package:bombay_chowpati/Constants/app_constance.dart';
import 'package:bombay_chowpati/Constants/app_strings.dart';
import 'package:bombay_chowpati/Constants/app_utils.dart';
import 'package:bombay_chowpati/Constants/app_validators.dart';
import 'package:bombay_chowpati/Network/models/auth_models/get_user_details_model.dart';
import 'package:bombay_chowpati/Network/services/auth_services/auth_services.dart';
import 'package:bombay_chowpati/Screens/home_screen/home_controller.dart';
import 'package:bombay_chowpati/Utils/app_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PersonalDetailsController extends GetxController {
  GlobalKey<FormState> personalDetailsFormKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  RxBool isPersonalDetailsLoading = false.obs;

  HomeController homeController = Get.find<HomeController>();

  @override
  void onInit() async {
    super.onInit();
    nameController.text = homeController.getUserDetails.value.name ?? '';
    emailController.text = homeController.getUserDetails.value.email ?? '';
    phoneController.text = homeController.getUserDetails.value.phone ?? '';
  }

  String? nameValidator(String? value) {
    if (value == null || value.isEmpty || value[0] == " ") {
      return AppStrings.pleaseEnterYourName.tr;
    }
    return null;
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty == true || value[0] == " ") {
      return AppStrings.pleaseEnterYourEmailAddress.tr;
    } else if (!AppValidators.emailValidator.hasMatch(value)) {
      return AppStrings.invalidEmailAddress.tr;
    }
    return null;
  }

  String? phoneValidator(String? value) {
    if (value == null || value.isEmpty == true || value[0] == " ") {
      return AppStrings.pleaseEnterPhoneNumber.tr;
    }
    return null;
  }

  Future<void> checkEditProfile() async {
    try {
      isPersonalDetailsLoading(true);
      final isValid = personalDetailsFormKey.currentState?.validate();

      if (isValid == true) {
        final response = await AuthServices.updateProfileService(
          name: nameController.text.trim(),
          email: emailController.text.trim(),
          phone: phoneController.text.trim(),
        );

        if (response.isSuccess) {
          Get.back(id: AppConstance.settingsNavigatorKey.getNavigatorId, closeOverlays: true);
          homeController.getUserDetails(GetUserDetailsModel.fromJson(response.response?.data));
          Utils.handleMessage(message: response.message);
        }
      }
    } finally {
      isPersonalDetailsLoading(false);
    }
  }
}
