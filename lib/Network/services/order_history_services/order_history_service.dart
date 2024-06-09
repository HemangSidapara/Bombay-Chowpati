import 'package:bombay_chowpati/Constants/api_keys.dart';
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

  ///Cancel order
  static Future<ResponseModel> cancelOrderService({
    required String orderId,
  }) async {
    final params = {
      ApiKeys.orderId: orderId,
    };
    final response = await ApiBaseHelper.postHTTP(
      ApiUrls.cancelOrderApi,
      showProgress: false,
      params: params,
      onError: (dioExceptions) {
        Utils.handleMessage(message: dioExceptions.message, isError: true);
      },
      onSuccess: (res) async {
        if (res.isSuccess) {
          debugPrint("cancelOrderApi success :: ${res.message}");
        } else {
          debugPrint("cancelOrderApi error :: ${res.message}");
          Utils.handleMessage(message: res.message, isError: true);
        }
      },
    );

    return response;
  }
}
