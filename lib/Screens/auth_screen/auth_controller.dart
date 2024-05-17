import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  RxBool canPopSignInNavigator = true.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
  }
}
