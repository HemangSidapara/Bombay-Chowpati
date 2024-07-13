import 'package:bombay_chowpati/Constants/app_constance.dart';
import 'package:bombay_chowpati/Constants/app_navigator_keys.dart';
import 'package:bombay_chowpati/Network/models/cart_models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

extension GetId on String {
  int? get getNavigatorId {
    return AppNavigatorKeys.keys[this];
  }
}

extension GetArgs on BuildContext {
  dynamic get arguments {
    return ModalRoute.of(this)?.settings.arguments;
  }
}

extension StringToInt on String {
  int toInt() {
    return int.parse(this);
  }
}

extension StringToIsDouble on String {
  bool isDouble() {
    return contains('.');
  }
}

extension StringToIsInt on String {
  bool isInt() {
    return int.parse(split('.').last) == 0;
  }
}

extension StringToDouble on String {
  double toDouble() {
    return double.parse(this);
  }
}

extension EmptyToZero on String {
  String emptyToZero() {
    if (this == '') {
      return '0';
    } else {
      return this;
    }
  }
}

extension RupeesFormatterFromInt on int {
  String toRupees({String? symbol}) {
    return indianRupeesFormat(symbol: symbol).format(this);
  }
}

extension RupeesFormatterFromDouble on double {
  String toRupees({String? symbol}) {
    return indianRupeesFormat(symbol: symbol).format(this);
  }
}

extension RupeesFormatterFromString on String {
  String toRupees({String? symbol}) {
    if (this != '') {
      return indianRupeesFormat(symbol: symbol).format(int.parse(this));
    } else {
      return '00';
    }
  }
}

indianRupeesFormat({String? symbol}) => NumberFormat.currency(name: "INR", locale: 'en_IN', decimalDigits: 0, symbol: symbol ?? '');

extension RupeesGrandTotalFromList on RxList {
  String grandTotal() {
    double totalAmount = 0.00;
    for (var element in (this as RxList<CartModel>)) {
      if (element.sizes?.every((element) => element.quantity != '' && element.quantity != null) == true) {
        totalAmount = totalAmount +
            "".grandTotalBySize(this, element.sizes?.firstWhereOrNull((element) => element.size == AppConstance.fiveLiter)?.quantity, element.sizes?.firstWhereOrNull((element) => element.size == AppConstance.fiveLiter)?.size, element.sizes?.firstWhereOrNull((element) => element.size == AppConstance.fiveLiter)?.mrp, element.sizes?.firstWhereOrNull((element) => element.size == AppConstance.fiveLiter)?.price).split(" ").last.toDouble() +
            "".grandTotalBySize(this, element.sizes?.firstWhereOrNull((element) => element.size == AppConstance.ml)?.quantity, element.sizes?.firstWhereOrNull((element) => element.size == AppConstance.ml)?.size, element.sizes?.firstWhereOrNull((element) => element.size == AppConstance.ml)?.mrp, element.sizes?.firstWhereOrNull((element) => element.size == AppConstance.ml)?.price).split(" ").last.toDouble();
      }
    }
    return totalAmount.toStringAsFixed(2);
  }
}

extension NotContainsAndAddSubString on String {
  String notContainsAndAddSubstring(String requiredString) {
    if (contains(requiredString) == false) {
      return this + requiredString;
    } else {
      return this;
    }
  }
}

extension RupeesTotalFromSize on String {
  String grandTotalBySize(RxList? cart, String? quantity, String? size, String? mrp, String? price) {
    int totalQuantityFiveLiterInCart = 0;
    int totalQuantityMLInCart = 0;
    for (var e in (cart as List<CartModel>)) {
      if (e.sizes?.any((element) => element.size == AppConstance.fiveLiter) == true) {
        totalQuantityFiveLiterInCart += (e.sizes?.firstWhereOrNull((element) => element.size == AppConstance.fiveLiter)?.quantity?.toInt() ?? 0);
      }
    }
    for (var e in (cart as List<CartModel>)) {
      if (e.sizes?.any((element) => element.size == AppConstance.ml) == true) {
        totalQuantityMLInCart += (e.sizes?.firstWhereOrNull((element) => element.size == AppConstance.ml)?.quantity?.toInt() ?? 0);
      }
    }
    if (quantity != null && size != null && mrp != null && price != null) {
      if (totalQuantityFiveLiterInCart >= 2 || totalQuantityMLInCart > 6 || (size == AppConstance.fiveLiter && quantity.toInt() > 1) || (size == AppConstance.ml && quantity.toInt() > 6)) {
        return (price.toInt() * quantity.toInt()).toStringAsFixed(2);
      } else {
        return (mrp.toInt() * quantity.toInt()).toStringAsFixed(2);
      }
    }
    return "0.00";
  }
}
