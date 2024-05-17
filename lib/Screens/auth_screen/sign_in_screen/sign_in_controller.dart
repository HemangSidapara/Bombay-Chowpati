import 'package:bombay_chowpati/Constants/app_strings.dart';
import 'package:bombay_chowpati/Network/services/auth_services/auth_services.dart';
import 'package:bombay_chowpati/Routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool isPasswordVisible = false.obs;

  GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();

  RxBool isSignInLoading = false.obs;

  String? phoneValidator(String? value) {
    if (value == null || value.isEmpty == true) {
      return AppStrings.pleaseEnterEmailPhoneNumber.tr;
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty == true) {
      return AppStrings.pleaseEnterPassword.tr;
    }
    return null;
  }

  Future<void> checkSignIn() async {
    try {
      isSignInLoading(true);
      final isValid = signInFormKey.currentState?.validate();

      if (isValid == true) {
        final response = await AuthServices.loginService(
          phone: phoneController.text,
          password: passwordController.text,
        );

        if (response.isSuccess) {
          Get.offAllNamed(Routes.homeScreen);
        }
      }
    } finally {
      isSignInLoading(false);
    }
  }
}
