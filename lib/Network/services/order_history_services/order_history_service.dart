import 'package:bombay_chowpati/Constants/api_urls.dart';
import 'package:bombay_chowpati/Constants/app_utils.dart';
import 'package:bombay_chowpati/Network/api_base_helper.dart';
import 'package:bombay_chowpati/Network/response_model.dart';
import 'package:flutter/material.dart';

class OrderHistoryService {
  ///Get orders
  static Future<ResponseModel> getOrdersService() async {
    final response = await ApiBaseHelper.getHTTP(
      ApiUrls.getOrdersApi,
      showProgress: false,
      onError: (dioExceptions) {
        Utils.handleMessage(message: dioExceptions.message, isError: true);
      },
      onSuccess: (res) async {
        if (res.isSuccess) {
          debugPrint("getOrdersApi success :: ${res.message}");
        } else {
          debugPrint("getOrdersApi error :: ${res.message}");
          Utils.handleMessage(message: res.message, isError: true);
        }
      },
    );

    return response;
  }
}
