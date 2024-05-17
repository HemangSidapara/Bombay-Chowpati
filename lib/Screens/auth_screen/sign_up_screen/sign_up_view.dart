import 'package:bombay_chowpati/Constants/app_utils.dart';
import 'package:bombay_chowpati/Screens/auth_screen/sign_up_screen/sign_up_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => Utils.unfocus(),
        child: Scaffold(),
      ),
    );
  }
}
