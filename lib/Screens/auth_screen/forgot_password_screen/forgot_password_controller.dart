import 'dart:async';

import 'package:bombay_chowpati/Constants/app_constance.dart';
import 'package:bombay_chowpati/Constants/app_strings.dart';
import 'package:bombay_chowpati/Constants/app_utils.dart';
import 'package:bombay_chowpati/Constants/get_storage.dart';
import 'package:bombay_chowpati/Network/services/auth_services/auth_services.dart';
import 'package:bombay_chowpati/Routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  FirebaseAuth forgotPasswordAuth = FirebaseAuth.instance;

  GlobalKey<FormState> forgotPasswordFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();

  TextEditingController phoneNumberController = TextEditingController();
  String verificationId = "";
  int? resendOTPToken;
  TextEditingController otpController = TextEditingController();

  RxBool isCodeSent = false.obs;
  RxBool isSendCodeLoading = false.obs;
  RxBool isCodeVerifyingLoading = false.obs;

  RxInt otpExpireTime = 30.obs;
  RxBool isOTPExpired = false.obs;

  String? phoneValidator(String? value) {
    if (value == null || value.isEmpty == true) {
      return AppStrings.pleaseEnterYourPhoneNumber.tr;
    } else if (value.length != 10) {
      return AppStrings.invalidPhoneNumber.tr;
    }
    return null;
  }

  String? confirmationCodeValidator(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.pleaseEnterCode.tr;
    }
    return null;
  }

  Future<void> checkPhoneNumberApiCall() async {
    isSendCodeLoading(true);
    final isValidate = forgotPasswordFormKey.currentState?.validate();
    if (isValidate == true) {
      final response = await AuthServices.checkPhoneNumberService(
        phone: phoneNumberController.text.trim(),
      );

      if (response.isSuccess) {
        if (response.response?.data['isRegistered'] == true) {
          await sendOTP();
        } else {
          Utils.handleMessage(message: AppStrings.phoneNumberIsInvalid.tr, isError: true);
        }
      } else {
        isSendCodeLoading(false);
        Utils.handleMessage(message: AppStrings.phoneNumberIsInvalid.tr, isError: true);
      }
    }
  }

  Future<void> sendOTP() async {
    isSendCodeLoading(true);
    await forgotPasswordAuth.verifyPhoneNumber(
      phoneNumber: "+91 ${phoneNumberController.text.trim()}",
      forceResendingToken: resendOTPToken,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        isSendCodeLoading(false);
        debugPrint('verificationFailed :: ${e.message}');
        Utils.handleMessage(message: e.message, isError: true);
      },
      codeSent: (String verificationId, int? resendToken) {
        Timer.periodic(const Duration(seconds: 1), (timer) {
          otpExpireTime.value = 30 - timer.tick;
          if (timer.tick == 30) {
            timer.cancel();
            otpExpireTime(30);
            isOTPExpired(true);
          }
        });
        isCodeSent(true);
        otpExpireTime(30);
        isOTPExpired(false);
        isSendCodeLoading(false);
        this.verificationId = verificationId;
        resendOTPToken = resendToken;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<void> verifyOTP() async {
    try {
      isCodeVerifyingLoading(true);
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otpController.text.trim(),
      );
      await forgotPasswordAuth.signInWithCredential(credential);
      setData(AppConstance.forgotPhoneNumber, phoneNumberController.text.trim());
      Get.offNamed(Routes.resetPasswordScreen, id: 0);
      Utils.handleMessage(message: AppStrings.otpVerifiedSuccessfully.tr);
    } on FirebaseAuthException catch (e) {
      debugPrint("verifyOTP Failed :: ${e.message}");
      Utils.handleMessage(message: e.message, isError: true);
    } finally {
      isCodeVerifyingLoading(false);
    }
  }
}
