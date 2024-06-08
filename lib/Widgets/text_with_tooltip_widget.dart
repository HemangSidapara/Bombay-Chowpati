import 'package:bombay_chowpati/Constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TextWithTooltipWidget extends StatelessWidget {
  final Text child;

  const TextWithTooltipWidget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: child.data,
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      textStyle: TextStyle(
        color: AppColors.BLACK_COLOR,
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        color: AppColors.WHITE_COLOR,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.ROSEGOLD_COLOR,
          width: 1.8,
        ),
      ),
      child: child,
    );
  }
}
