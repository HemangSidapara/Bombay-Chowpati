import 'package:bombay_chowpati/Constants/api_keys.dart';
import 'package:bombay_chowpati/Constants/api_urls.dart';
import 'package:bombay_chowpati/Constants/app_utils.dart';
import 'package:bombay_chowpati/Network/api_base_helper.dart';
import 'package:bombay_chowpati/Network/response_model.dart';
import 'package:flutter/material.dart';

class DashboardService {
  ///Get Products
  static Future<ResponseModel> getProductsService({required String fcmToken}) async {
    final params = {
      ApiKeys.fcmToken: fcmToken,
    };
    final response = await ApiBaseHelper.postHTTP(
      ApiUrls.getProductsApi,
      showProgress: false,
      params: params,
      onError: (dioExceptions) {
        Utils.handleMessage(message: dioExceptions.message, isError: true);
      },
      onSuccess: (res) async {
        if (res.isSuccess) {
          debugPrint("getProductsApi success :: ${res.message}");
        } else {
          debugPrint("getProductsApi error :: ${res.message}");
          Utils.handleMessage(message: res.message, isError: true);
        }
      },
    );

    return response;
  }
}
