import 'package:bombay_chowpati/Constants/app_constance.dart';
import 'package:bombay_chowpati/Constants/app_strings.dart';
import 'package:bombay_chowpati/Constants/app_utils.dart';
import 'package:bombay_chowpati/Constants/app_validators.dart';
import 'package:bombay_chowpati/Network/services/auth_services/auth_services.dart';
import 'package:bombay_chowpati/Utils/app_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  GlobalKey<FormState> changePasswordFormKey = GlobalKey<FormState>();

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  RxBool isOldPasswordVisible = false.obs;
  RxBool isNewPasswordVisible = false.obs;
  RxBool isConfirmNewPasswordVisible = false.obs;

  RxBool isChangePasswordLoading = false.obs;

  String? oldPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.pleaseEnterYourOldPassword.tr;
    }
    return null;
  }

  String? newPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.pleaseEnterNewPassword.tr;
    } else if (!AppValidators.passwordValidator.hasMatch(value)) {
      return AppStrings.passwordMustContain.tr;
    } else if (value == oldPasswordController.text) {
      return AppStrings.oldAndNewPasswordMustBeDifferent.tr;
    }
    return null;
  }

  String? confirmNewPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.pleaseConfirmNewPassword.tr;
    } else if (value != newPasswordController.text) {
      return AppStrings.passwordDidNotMatch.tr;
    }
    return null;
  }

  Future<void> checkChangePassword() async {
    try {
      isChangePasswordLoading(true);
      final isValid = changePasswordFormKey.currentState?.validate();

      if (isValid == true) {
        final response = await AuthServices.changePasswordService(
          oldPassword: oldPasswordController.text,
          newPassword: newPasswordController.text,
        );

        if (response.isSuccess) {
          Get.back(id: AppConstance.settingsNavigatorKey.getNavigatorId, closeOverlays: true);
          Utils.handleMessage(message: response.message);
        }
      }
    } finally {
      isChangePasswordLoading(false);
    }
  }
}
