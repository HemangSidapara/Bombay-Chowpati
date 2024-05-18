import 'package:bombay_chowpati/Constants/app_strings.dart';
import 'package:bombay_chowpati/Constants/app_validators.dart';
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
}
