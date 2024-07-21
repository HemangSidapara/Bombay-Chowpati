import 'package:bombay_chowpati/Constants/api_keys.dart';
import 'package:bombay_chowpati/Constants/api_urls.dart';
import 'package:bombay_chowpati/Constants/app_constance.dart';
import 'package:bombay_chowpati/Constants/app_utils.dart';
import 'package:bombay_chowpati/Constants/get_storage.dart';
import 'package:bombay_chowpati/Network/api_base_helper.dart';
import 'package:bombay_chowpati/Network/models/auth_models/login_model.dart';
import 'package:bombay_chowpati/Network/response_model.dart';
import 'package:bombay_chowpati/Routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthServices {
  ///Login
  static Future<ResponseModel> loginService({
    required String userId,
    required String password,
  }) async {
    final params = {
      ApiKeys.userId: userId,
      ApiKeys.password: password,
    };
    final response = await ApiBaseHelper.postHTTP(
      ApiUrls.loginApi,
      params: params,
      showProgress: false,
      onError: (dioExceptions) {
        Utils.handleMessage(message: dioExceptions.message, isError: true);
      },
      onSuccess: (res) async {
        if (res.isSuccess) {
          LoginModel loginModel = LoginModel.fromJson(res.response?.data);
          await setData(AppConstance.authorizationToken, loginModel.token);
          debugPrint("loginApi success :: ${loginModel.msg}");
          Utils.handleMessage(message: loginModel.msg);
        } else {
          debugPrint("loginApi error :: ${res.message}");
          Utils.handleMessage(message: res.message, isError: true);
        }
      },
    );

    return response;
  }

  ///SignUp
  static Future<ResponseModel> signUpService({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String fcmToken,
  }) async {
    final params = {
      ApiKeys.name: name,
      ApiKeys.email: email,
      ApiKeys.phone: phone,
      ApiKeys.password: password,
      ApiKeys.fcmToken: fcmToken,
    };
    final response = await ApiBaseHelper.postHTTP(
      ApiUrls.signUpApi,
      params: params,
      showProgress: false,
      onError: (dioExceptions) {
        Utils.handleMessage(message: dioExceptions.message, isError: true);
      },
      onSuccess: (res) async {
        if (res.isSuccess) {
          LoginModel loginModel = LoginModel.fromJson(res.response?.data);
          await setData(AppConstance.authorizationToken, loginModel.token);
          debugPrint("signUpApi success :: ${loginModel.msg}");
          Utils.handleMessage(message: loginModel.msg);
        } else {
          debugPrint("signUpApi error :: ${res.message}");
          Utils.handleMessage(message: res.message, isError: true);
        }
      },
    );

    return response;
  }

  ///Change password
  static Future<ResponseModel> changePasswordService({
    required String oldPassword,
    required String newPassword,
  }) async {
    final params = {
      ApiKeys.oldPassword: oldPassword,
      ApiKeys.newPassword: newPassword,
    };
    final response = await ApiBaseHelper.postHTTP(
      ApiUrls.changePasswordApi,
      params: params,
      showProgress: false,
      onError: (dioExceptions) {
        Utils.handleMessage(message: dioExceptions.message, isError: true);
      },
      onSuccess: (res) async {
        if (res.isSuccess) {
          debugPrint("changePasswordApi success :: ${res.message}");
        } else {
          debugPrint("changePasswordApi error :: ${res.message}");
          Utils.handleMessage(message: res.message, isError: true);
        }
      },
    );

    return response;
  }

  ///Get user details
  static Future<ResponseModel> getUserDetailsService() async {
    final response = await ApiBaseHelper.getHTTP(
      ApiUrls.getUserDetailApi,
      showProgress: false,
      onError: (dioExceptions) {
        Utils.handleMessage(message: dioExceptions.message, isError: true);
      },
      onSuccess: (res) async {
        if (res.isSuccess) {
          debugPrint("getUserDetailApi success :: ${res.message}");
        } else {
          debugPrint("getUserDetailApi error :: ${res.message}");
          if (res.message == "Invalid Token") {
            clearData();
            Get.offAllNamed(Routes.authScreen);
          }
          Utils.handleMessage(message: res.message, isError: true);
        }
      },
    );

    return response;
  }

  ///Update profile
  static Future<ResponseModel> updateProfileService({
    required String name,
    required String email,
    required String phone,
  }) async {
    final params = {
      ApiKeys.name: name,
      ApiKeys.email: email,
      ApiKeys.phone: phone,
    };
    final response = await ApiBaseHelper.postHTTP(
      ApiUrls.editProfileApi,
      showProgress: false,
      params: params,
      onError: (dioExceptions) {
        Utils.handleMessage(message: dioExceptions.message, isError: true);
      },
      onSuccess: (res) async {
        if (res.isSuccess) {
          debugPrint("editProfileApi success :: ${res.message}");
        } else {
          debugPrint("editProfileApi error :: ${res.message}");
          Utils.handleMessage(message: res.message, isError: true);
        }
      },
    );

    return response;
  }

  ///Logout
  static Future<ResponseModel> logoutService() async {
    final response = await ApiBaseHelper.getHTTP(
      ApiUrls.logoutApi,
      showProgress: false,
      onError: (dioExceptions) {
        Utils.handleMessage(message: dioExceptions.message, isError: true);
      },
      onSuccess: (res) async {
        if (res.isSuccess) {
          debugPrint("logoutApi success :: ${res.message}");
        } else {
          debugPrint("logoutApi error :: ${res.message}");
          Utils.handleMessage(message: res.message, isError: true);
        }
      },
    );

    return response;
  }

  ///Delete Account
  static Future<ResponseModel> deleteAccountService() async {
    final response = await ApiBaseHelper.deleteHTTP(
      ApiUrls.deleteAccountApi,
      showProgress: false,
      onError: (dioExceptions) {
        Utils.handleMessage(message: dioExceptions.message, isError: true);
      },
      onSuccess: (res) async {
        if (res.isSuccess) {
          debugPrint("deleteAccountApi success :: ${res.message}");
        } else {
          debugPrint("deleteAccountApi error :: ${res.message}");
          Utils.handleMessage(message: res.message, isError: true);
        }
      },
    );

    return response;
  }

  ///Check Phone Number
  static Future<ResponseModel> checkPhoneNumberService({
    required String phone,
  }) async {
    final response = await ApiBaseHelper.postHTTP(
      ApiUrls.checkPhoneApi,
      params: {
        ApiKeys.phone: phone,
      },
      showProgress: false,
      onError: (dioExceptions) {
        Utils.handleMessage(message: dioExceptions.message, isError: true);
      },
      onSuccess: (res) async {
        if (res.isSuccess) {
          debugPrint("checkPhoneApi isRegistered :: ${res.response?.data['isRegistered']}");
        } else {
          debugPrint("checkPhoneApi isRegistered :: ${res.response?.data['isRegistered']}");
        }
      },
    );

    return response;
  }

  ///Reset password
  static Future<ResponseModel> resetPasswordService({
    required String phone,
    required String password,
  }) async {
    final response = await ApiBaseHelper.postHTTP(
      ApiUrls.resetPasswordApi,
      params: {
        ApiKeys.phone: phone,
        ApiKeys.password: password,
      },
      showProgress: false,
      onError: (dioExceptions) {
        Utils.handleMessage(message: dioExceptions.message, isError: true);
      },
      onSuccess: (res) async {
        if (res.isSuccess) {
          debugPrint("resetPasswordApi success :: ${res.message}");
        } else {
          debugPrint("resetPasswordApi error :: ${res.message}");
          Utils.handleMessage(message: res.message, isError: true);
        }
      },
    );

    return response;
  }
}
