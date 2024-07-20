import 'package:bombay_chowpati/Constants/api_keys.dart';
import 'package:bombay_chowpati/Constants/api_urls.dart';
import 'package:bombay_chowpati/Constants/app_utils.dart';
import 'package:bombay_chowpati/Network/api_base_helper.dart';
import 'package:bombay_chowpati/Network/response_model.dart';
import 'package:flutter/material.dart';

class CartService {
  ///Get address
  static Future<ResponseModel> getAddressService() async {
    final response = await ApiBaseHelper.getHTTP(
      ApiUrls.getAddressApi,
      showProgress: false,
      onError: (dioExceptions) {
        Utils.handleMessage(message: dioExceptions.message, isError: true);
      },
      onSuccess: (res) async {
        if (res.isSuccess) {
          debugPrint("getAddressApi success :: ${res.message}");
        } else {
          debugPrint("getAddressApi error :: ${res.message}");
          Utils.handleMessage(message: res.message, isError: true);
        }
      },
    );

    return response;
  }

  ///Add address
  static Future<ResponseModel> addAddressService({
    required String address,
    required String pinCode,
    String? phone,
  }) async {
    final params = {
      ApiKeys.address: address,
      ApiKeys.pinCode: pinCode,
      ApiKeys.phone: phone,
    };
    final response = await ApiBaseHelper.postHTTP(
      ApiUrls.addAddressApi,
      showProgress: false,
      params: params,
      onError: (dioExceptions) {
        Utils.handleMessage(message: dioExceptions.message, isError: true);
      },
      onSuccess: (res) async {
        if (res.isSuccess) {
          debugPrint("addAddressApi success :: ${res.message}");
        } else {
          debugPrint("addAddressApi error :: ${res.message}");
          Utils.handleMessage(message: res.message, isError: true);
        }
      },
    );

    return response;
  }

  ///Add address
  static Future<ResponseModel> makeDefaultAddressService({
    required String addressId,
  }) async {
    final params = {
      ApiKeys.addressId: addressId,
    };
    final response = await ApiBaseHelper.postHTTP(
      ApiUrls.makeDefaultAddressApi,
      showProgress: false,
      params: params,
      onError: (dioExceptions) {
        Utils.handleMessage(message: dioExceptions.message, isError: true);
      },
      onSuccess: (res) async {
        if (res.isSuccess) {
          debugPrint("makeDefaultAddressApi success :: ${res.message}");
        } else {
          debugPrint("makeDefaultAddressApi error :: ${res.message}");
          Utils.handleMessage(message: res.message, isError: true);
        }
      },
    );

    return response;
  }

  ///Edit address
  static Future<ResponseModel> editAddressService({
    required String addressId,
    required String address,
    required String pinCode,
    String? phone,
  }) async {
    final params = {
      ApiKeys.addressId: addressId,
      ApiKeys.address: address,
      ApiKeys.pinCode: pinCode,
      ApiKeys.phone: phone,
    };
    final response = await ApiBaseHelper.postHTTP(
      ApiUrls.editAddressApi,
      showProgress: false,
      params: params,
      onError: (dioExceptions) {
        Utils.handleMessage(message: dioExceptions.message, isError: true);
      },
      onSuccess: (res) async {
        if (res.isSuccess) {
          debugPrint("editAddressApi success :: ${res.message}");
        } else {
          debugPrint("editAddressApi error :: ${res.message}");
          Utils.handleMessage(message: res.message, isError: true);
        }
      },
    );

    return response;
  }

  ///Delete address
  static Future<ResponseModel> deleteAddressService({
    required String addressId,
  }) async {
    final params = {
      ApiKeys.addressId: addressId,
    };
    final response = await ApiBaseHelper.postHTTP(
      ApiUrls.deleteAddressApi,
      showProgress: false,
      params: params,
      onError: (dioExceptions) {
        Utils.handleMessage(message: dioExceptions.message, isError: true);
      },
      onSuccess: (res) async {
        if (res.isSuccess) {
          debugPrint("deleteAddressApi success :: ${res.message}");
        } else {
          debugPrint("deleteAddressApi error :: ${res.message}");
          Utils.handleMessage(message: res.message, isError: true);
        }
      },
    );

    return response;
  }

  ///Create order
  static Future<ResponseModel> createOrderService({
    required String addressId,
    required String totalAmount,
    required List<Map<String, String>> orderMeta,
  }) async {
    final params = {
      ApiKeys.addressId: addressId,
      ApiKeys.totalAmount: totalAmount,
      ApiKeys.orderMeta: orderMeta,
    };
    final response = await ApiBaseHelper.postHTTP(
      ApiUrls.createOrderApi,
      showProgress: false,
      params: params,
      onError: (dioExceptions) {
        Utils.handleMessage(message: dioExceptions.message, isError: true);
      },
      onSuccess: (res) async {
        if (res.isSuccess) {
          debugPrint("createOrderApi success :: ${res.message}");
        } else {
          debugPrint("createOrderApi error :: ${res.message}");
          Utils.handleMessage(message: res.message, isError: true);
        }
      },
    );

    return response;
  }

  ///Get pin-codes
  static Future<ResponseModel> getPinCodesService() async {
    final response = await ApiBaseHelper.getHTTP(
      ApiUrls.getPinCodesApi,
      showProgress: false,
      onError: (dioExceptions) {
        Utils.handleMessage(message: dioExceptions.message, isError: true);
      },
      onSuccess: (res) async {
        if (res.isSuccess) {
          debugPrint("getPinCodesApi success :: ${res.message}");
        } else {
          debugPrint("getPinCodesApi error :: ${res.message}");
          Utils.handleMessage(message: res.message, isError: true);
        }
      },
    );

    return response;
  }
}
