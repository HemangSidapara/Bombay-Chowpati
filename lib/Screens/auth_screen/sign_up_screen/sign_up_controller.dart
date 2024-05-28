import 'package:bombay_chowpati/Constants/app_strings.dart';
import 'package:bombay_chowpati/Constants/app_utils.dart';
import 'package:bombay_chowpati/Constants/app_validators.dart';
import 'package:bombay_chowpati/Network/services/auth_services/auth_services.dart';
import 'package:bombay_chowpati/Screens/auth_screen/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  RxBool isPasswordVisible = false.obs;
  RxBool isConfirmPasswordVisible = false.obs;

  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  RxBool isSignUpLoading = false.obs;

  RxBool isTermsAndConditionsChecked = false.obs;

  String? nameValidator(String? value) {
    if (value == null || value.isEmpty == true) {
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

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.pleaseEnterPassword.tr;
    } else if (!AppValidators.passwordValidator.hasMatch(value)) {
      return AppStrings.passwordMustContain.tr;
    }
    return null;
  }

  String? confirmPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.pleaseEnterConfirmPassword.tr;
    } else if (value != passwordController.text) {
      return AppStrings.passwordDidNotMatch.tr;
    }
    return null;
  }

  Future<void> checkSignUp() async {
    try {
      isSignUpLoading(true);
      final isValid = signUpFormKey.currentState?.validate();

      if (isValid == true) {
        if (isTermsAndConditionsChecked.isTrue) {
          final response = await AuthServices.signUpService(
            name: nameController.text.trim(),
            email: emailController.text.trim(),
            phone: phoneController.text.trim(),
            password: passwordController.text,
            fcmToken: '',
          );

          if (response.isSuccess) {
            Get.find<AuthController>().tabController.animateTo(0);
          }
        } else {
          Utils.handleMessage(message: AppStrings.pleaseAcceptTermsAndConditions.tr, isError: true);
        }
      }
    } finally {
      isSignUpLoading(false);
    }
  }
}
