import 'package:bombay_chowpati/Constants/app_constance.dart';
import 'package:bombay_chowpati/Constants/app_strings.dart';
import 'package:bombay_chowpati/Constants/app_utils.dart';
import 'package:bombay_chowpati/Constants/get_storage.dart';
import 'package:bombay_chowpati/Network/services/auth_services/auth_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  RxBool isResetPasswordLoading = false.obs;

  GlobalKey<FormState> resetPasswordFormKey = GlobalKey<FormState>();

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  RxBool isPasswordVisible = false.obs;
  RxBool isConfirmPasswordVisible = false.obs;

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.pleaseEnterPassword.tr;
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

  Future<void> resetPasswordApiCall() async {
    try {
      isResetPasswordLoading(true);

      final isValidate = resetPasswordFormKey.currentState?.validate();

      if (isValidate == true) {
        if (getData(AppConstance.forgotPhoneNumber) != null && getData(AppConstance.forgotPhoneNumber) != "") {
          final response = await AuthServices.resetPasswordService(
            phone: getData(AppConstance.forgotPhoneNumber) ?? "",
            password: passwordController.text,
          );

          if (response.isSuccess) {
            Get.back(id: 0);
            Utils.handleMessage(message: response.message);
          }
        } else {
          Utils.handleMessage(message: AppStrings.somethingWentWrongPleaseReVerifyPhoneNumber.tr, isError: true);
        }
      }
    } finally {
      isResetPasswordLoading(false);
    }
  }
}
