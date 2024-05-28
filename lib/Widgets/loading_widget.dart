import 'package:bombay_chowpati/Constants/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoadingWidget extends StatelessWidget {
  final Color? loaderColor;

  const LoadingWidget({super.key, this.loaderColor});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      AppAssets.loaderAnim,
      width: 30.w,
    );
  }
}
