import 'package:bombay_chowpati/Constants/app_strings.dart';
import 'package:bombay_chowpati/Constants/app_validators.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PersonalDetailsController extends GetxController {
  GlobalKey<FormState> personalDetailsFormKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  RxBool isPersonalDetailsLoading = false.obs;

  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.pleaseEnterYourName.tr;
    }
    return null;
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty == true) {
      return AppStrings.pleaseEnterYourEmailAddress.tr;
    } else if (!AppValidators.emailValidator.hasMatch(value)) {
      return AppStrings.invalidEmailAddress.tr;
    }
    return null;
  }

  String? phoneValidator(String? value) {
    if (value == null || value.isEmpty == true) {
      return AppStrings.pleaseEnterPhoneNumber.tr;
    }
    return null;
  }

  Future<void> checkEditProfile() async {
    try {
      isPersonalDetailsLoading(true);
      final isValid = personalDetailsFormKey.currentState?.validate();

      if (isValid == true) {}
    } finally {
      isPersonalDetailsLoading(false);
    }
  }
}
