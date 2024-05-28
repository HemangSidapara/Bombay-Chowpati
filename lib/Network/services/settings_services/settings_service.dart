import 'package:bombay_chowpati/Constants/api_urls.dart';
import 'package:bombay_chowpati/Constants/app_utils.dart';
import 'package:bombay_chowpati/Network/api_base_helper.dart';
import 'package:bombay_chowpati/Network/response_model.dart';
import 'package:flutter/material.dart';

class SettingsService {
  ///Privacy Policy
  static Future<ResponseModel> privacyPolicyService() async {
    final response = await ApiBaseHelper.getHTTP(
      ApiUrls.getPrivacyPolicyApi,
      showProgress: false,
      onError: (dioExceptions) {
        Utils.handleMessage(message: dioExceptions.message, isError: true);
      },
      onSuccess: (res) {
        if (res.isSuccess) {
          debugPrint("getPrivacyPolicyApi success ::: ${res.message}");
        } else {
          debugPrint("getPrivacyPolicyApi error ::: ${res.message}");
          Utils.handleMessage(message: res.message, isError: true);
        }
      },
    );
    return response;
  }

  ///Terms & Conditions
  static Future<ResponseModel> termsAndConditionsService() async {
    final response = await ApiBaseHelper.getHTTP(
      ApiUrls.getTermsConditionApi,
      showProgress: false,
      onError: (dioExceptions) {
        Utils.handleMessage(message: dioExceptions.message, isError: true);
      },
      onSuccess: (res) {
        if (res.isSuccess) {
          debugPrint("getTermsConditionApi success ::: ${res.message}");
        } else {
          debugPrint("getTermsConditionApi error ::: ${res.message}");
          Utils.handleMessage(message: res.message, isError: true);
        }
      },
    );
    return response;
  }
}
