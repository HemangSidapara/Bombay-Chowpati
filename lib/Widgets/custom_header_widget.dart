import 'package:bombay_chowpati/Constants/app_assets.dart';
import 'package:bombay_chowpati/Constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomHeaderWidget extends StatelessWidget {
  final String title;
  final String? titleIcon;
  final double? titleIconSize;
  final void Function()? onBackPressed;
  final Widget? titleIconWidget;
  final Color? backIconBackgroundColor;

  const CustomHeaderWidget({
    super.key,
    required this.title,
    this.titleIcon,
    this.onBackPressed,
    this.titleIconSize,
    this.titleIconWidget,
    this.backIconBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (onBackPressed != null) ...[
          IconButton(
            onPressed: onBackPressed,
            style: IconButton.styleFrom(
              backgroundColor: backIconBackgroundColor ?? AppColors.SETTING_BG_COLOR,
              surfaceTintColor: backIconBackgroundColor ?? AppColors.SETTING_BG_COLOR,
              highlightColor: AppColors.PRIMARY_COLOR.withOpacity(0.13),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            icon: Image.asset(
              AppAssets.backIcon,
              width: 8.w,
            ),
          ),
          SizedBox(width: 2.w),
        ],
        Text(
          title,
          style: TextStyle(
            color: AppColors.PRIMARY_COLOR,
            fontSize: 20.sp,
            fontWeight: FontWeight.w900,
          ),
        ),
        SizedBox(width: 2.w),
        if (titleIconWidget != null) titleIconWidget!,
        if (titleIconWidget == null && titleIcon != null)
          Image.asset(
            titleIcon!,
            width: titleIconSize ?? 12.w,
          ),
      ],
    );
  }
}
