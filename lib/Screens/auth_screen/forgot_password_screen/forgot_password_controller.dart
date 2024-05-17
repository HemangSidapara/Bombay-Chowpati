import 'package:bombay_chowpati/Constants/app_strings.dart';
import 'package:bombay_chowpati/Constants/app_validators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  GlobalKey<FormState> forgotPasswordFormKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  RxBool isCodeSent = false.obs;
  RxBool isCodeConfirm = false.obs;

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty == true) {
      return AppStrings.pleaseEnterYourEmailAddress.tr;
    } else if (!AppValidators.emailValidator.hasMatch(value)) {
      return AppStrings.invalidEmailAddress.tr;
    }
    return null;
  }

  String? confirmationCodeValidator(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.pleaseEnterCode.tr;
    }
    return null;
  }
}
