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
      if (element.quantity != '' && element.quantity != null) {
        totalAmount = totalAmount + "".grandTotalBySize(this, element.quantity, element.size, element.mrp, element.price).split(" ").last.toDouble();
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
    int totalQuantity = 0;
    for (var e in (cart as List<CartModel>)) {
      if (e.size == AppConstance.fiveLiter) {
        totalQuantity += (e.quantity?.toInt() ?? 0);
      }
    }
    if (quantity != null && size != null && mrp != null && price != null) {
      if (totalQuantity >= 2 || (size == AppConstance.fiveLiter && quantity.toInt() > 1) || (size == AppConstance.ml && quantity.toInt() > 6)) {
        return (price.toInt() * quantity.toInt()).toStringAsFixed(2);
      } else {
        return (mrp.toInt() * quantity.toInt()).toStringAsFixed(2);
      }
    }
    return "0.00";
  }
}
