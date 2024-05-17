import 'package:bombay_chowpati/Constants/api_keys.dart';
import 'package:bombay_chowpati/Constants/api_urls.dart';
import 'package:bombay_chowpati/Constants/app_constance.dart';
import 'package:bombay_chowpati/Constants/app_utils.dart';
import 'package:bombay_chowpati/Constants/get_storage.dart';
import 'package:bombay_chowpati/Network/api_base_helper.dart';
import 'package:bombay_chowpati/Network/models/auth_models/login_model.dart';
import 'package:bombay_chowpati/Network/response_model.dart';
import 'package:flutter/material.dart';

class AuthServices {
  static Future<ResponseModel> loginService({
    required String phone,
    required String password,
  }) async {
    final params = {
      ApiKeys.phone: phone,
      ApiKeys.password: password,
    };
    final response = await ApiBaseHelper.postHTTP(
      ApiUrls.loginApi,
      params: params,
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
}
