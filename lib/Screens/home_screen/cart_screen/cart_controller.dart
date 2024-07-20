import 'package:bombay_chowpati/Constants/api_keys.dart';
import 'package:bombay_chowpati/Constants/app_constance.dart';
import 'package:bombay_chowpati/Constants/app_strings.dart';
import 'package:bombay_chowpati/Constants/app_utils.dart';
import 'package:bombay_chowpati/Constants/get_storage.dart';
import 'package:bombay_chowpati/Network/models/cart_models/cart_model.dart';
import 'package:bombay_chowpati/Network/models/cart_models/get_address_model.dart' as address_model;
import 'package:bombay_chowpati/Network/models/cart_models/get_pincodes_model.dart' as pincodes_model;
import 'package:bombay_chowpati/Network/services/cart_services/cart_service.dart';
import 'package:bombay_chowpati/Screens/home_screen/home_controller.dart';
import 'package:bombay_chowpati/Screens/home_screen/order_history_screen/order_history_controller.dart';
import 'package:bombay_chowpati/Utils/app_formatter.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  RxList<CartModel> cartList = RxList();
  RxString totalPayableAmount = "".obs;

  RxBool isGetAddressLoading = false.obs;
  RxBool isAddEditDefaultAddressLoading = false.obs;
  RxList<address_model.Data> addressList = RxList();
  RxString selectedAddressId = "".obs;

  RxList<String> pinCodesList = RxList();

  @override
  void onInit() async {
    super.onInit();
    await getAddressApiCall();
  }

  ///Address validator
  String? addressValidator(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.pleaseEnterAddress.tr;
    }
    return null;
  }

  ///Pin-code validator
  String? pinCodeValidator(int? value) {
    if (value == null || value == -1) {
      return AppStrings.pleaseSelectPinCode.tr;
    }
    return null;
  }

  ///Address validator
  String? phoneNumberValidator(String? value) {
    if (value != null && value.isNotEmpty == true && value.length != 10) {
      return AppStrings.pleaseEnterValidPhoneNumber.tr;
    }
    return null;
  }

  Future<void> getAddressApiCall() async {
    try {
      isGetAddressLoading(true);
      final response = await CartService.getAddressService();

      if (response.isSuccess) {
        address_model.GetAddressModel addressModel = address_model.GetAddressModel.fromJson(response.response?.data);

        addressList.clear();
        addressList.addAll(addressModel.data ?? []);
        selectedAddressId(addressList.firstWhereOrNull((e) => e.isDefault == true)?.addressId ?? "");
      }
    } finally {
      isGetAddressLoading(false);
    }
  }

  Future<void> addAddressApiCall({
    required String address,
    required String pinCode,
    String? phone,
  }) async {
    try {
      isAddEditDefaultAddressLoading(true);
      final response = await CartService.addAddressService(
        address: address,
        pinCode: pinCode,
        phone: phone,
      );

      if (response.isSuccess) {
        await getAddressApiCall();
        Get.back();
        Utils.handleMessage(message: response.message);
      }
    } finally {
      isAddEditDefaultAddressLoading(false);
    }
  }

  Future<void> makeDefaultAddressApiCall({
    required String addressId,
  }) async {
    try {
      isAddEditDefaultAddressLoading(true);
      final response = await CartService.makeDefaultAddressService(addressId: addressId);

      if (response.isSuccess) {
        await getAddressApiCall();
        Get.back();
        Utils.handleMessage(message: response.message);
      }
    } finally {
      isAddEditDefaultAddressLoading(false);
    }
  }

  Future<void> editAddressApiCall({
    required String addressId,
    required String address,
    required String pinCode,
    String? phone,
  }) async {
    try {
      isAddEditDefaultAddressLoading(true);
      final response = await CartService.editAddressService(
        addressId: addressId,
        address: address,
        pinCode: pinCode,
        phone: phone,
      );

      if (response.isSuccess) {
        Utils.handleMessage(message: response.message);
        getAddressApiCall();
      }
    } finally {
      isAddEditDefaultAddressLoading(false);
    }
  }

  Future<void> deleteAddressApiCall({
    required String addressId,
  }) async {
    final response = await CartService.deleteAddressService(
      addressId: addressId,
    );

    if (response.isSuccess) {
      await getAddressApiCall();
      Get.back();
      Utils.handleMessage(message: response.message);
    }
  }

  Future<void> createOrderApiCall() async {
    int noOfFiveLiter = 0;
    int noOfML = 0;
    for (var element in cartList) {
      element.sizes?.forEach((e) {
        if (e.size == AppConstance.fiveLiter) {
          noOfFiveLiter++;
        }
        if (e.size == AppConstance.ml) {
          noOfML += (e.quantity?.toInt() ?? 0);
        }
      });
    }

    if (noOfFiveLiter > 0 || noOfML > 6) {
      List<Map<String, String>> orderMeta = [];
      for (var element in cartList) {
        if (element.sizes != null) {
          for (var e in element.sizes!) {
            orderMeta.add({
              ApiKeys.pid: element.productId ?? "",
              ApiKeys.pMetaId: e.productDataId ?? "",
              ApiKeys.quantity: e.quantity ?? "",
              ApiKeys.amount: "".grandTotalBySize(cartList, e.quantity, e.size, e.mrp, e.price).split("₹ ").last,
            });
          }
        }
      }

      final response = await CartService.createOrderService(
        addressId: selectedAddressId.value,
        totalAmount: totalPayableAmount.value,
        orderMeta: orderMeta,
      );

      if (response.isSuccess) {
        cartList.clear();
        removeData(AppConstance.cartStorage);
        Get.find<HomeController>().onBottomItemChange(index: 1);
        Get.find<OrderHistoryController>().getOrdersApiCall();
        Utils.handleMessage(message: response.message);
      }
    } else {
      if (noOfFiveLiter == 0 && noOfML < 7) {
        Utils.handleMessage(message: AppStrings.pleaseAddAtLeast1ItemOf5Liter.tr, isError: true);
      }
    }
  }

  Future<void> getPinCodesApiCall() async {
    final response = await CartService.getPinCodesService();

    if (response.isSuccess) {
      pincodes_model.GetPincodesModel pinCodesModel = pincodes_model.GetPincodesModel.fromJson(response.response?.data);

      pinCodesList.clear();
      pinCodesList.addAll(pinCodesModel.data?.map((e) => e.pinCode ?? "").toList() ?? []);
    }
  }
}
