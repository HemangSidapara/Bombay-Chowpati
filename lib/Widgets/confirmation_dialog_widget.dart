import 'package:bombay_chowpati/Constants/app_colors.dart';
import 'package:bombay_chowpati/Constants/app_strings.dart';
import 'package:bombay_chowpati/Widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Future<void> showConfirmationDialog({
  required BuildContext context,
  required void Function() onConfirm,
  String? title,
  String? confirmText,
  IconData? icon,
}) async {
  await showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'string',
    transitionDuration: const Duration(milliseconds: 350),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween(
          begin: const Offset(0, 1),
          end: const Offset(0, 0),
        ).animate(animation),
        child: child,
      );
    },
    pageBuilder: (context, animation, secondaryAnimation) {
      return _ConfirmationDialogWidget(
        title: title,
        onConfirm: onConfirm,
        confirmText: confirmText,
        icon: icon,
      );
    },
  );
}

class _ConfirmationDialogWidget extends StatefulWidget {
  final Function()? onConfirm;
  final String? title;
  final String? confirmText;
  final IconData? icon;

  const _ConfirmationDialogWidget({
    this.onConfirm,
    this.title,
    this.confirmText,
    this.icon,
  });

  @override
  State<_ConfirmationDialogWidget> createState() => _ConfirmationDialogWidgetState();
}

class _ConfirmationDialogWidgetState extends State<_ConfirmationDialogWidget> {
  RxBool isLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: AppColors.SECONDARY_COLOR,
      surfaceTintColor: AppColors.SECONDARY_COLOR,
      contentPadding: EdgeInsets.symmetric(horizontal: 2.w),
      content: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.WHITE_COLOR,
        ),
        constraints: BoxConstraints(maxHeight: 30.h, minHeight: 25.h, minWidth: 80.w, maxWidth: 80.w),
        clipBehavior: Clip.hardEdge,
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              widget.icon ?? Icons.logout_rounded,
              size: 8.w,
              color: AppColors.PRIMARY_COLOR,
            ),
            SizedBox(height: 1.h),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  widget.title ?? AppStrings.areYouSureYouWantToExitTheApp.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.BLACK_COLOR,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
            SizedBox(height: 1.h),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ///No
                ElevatedButton(
                  onPressed: () {
                    Get.back(closeOverlays: true);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.DARK_GREEN_COLOR,
                    minimumSize: Size(27.w, 5.h),
                    maximumSize: Size(35.w, 5.h),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    AppStrings.no.tr,
                    style: TextStyle(
                      color: AppColors.SECONDARY_COLOR,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                ///Yes
                Obx(() {
                  return ButtonWidget(
                    onPressed: () async {
                      try {
                        isLoading(true);
                        await widget.onConfirm?.call();
                      } finally {
                        isLoading(false);
                      }
                    },
                    isLoading: isLoading.isTrue,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.DARK_RED_COLOR,
                      minimumSize: Size(27.w, 5.h),
                      maximumSize: Size(35.w, 5.h),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      widget.confirmText ?? AppStrings.yesExit.tr,
                      style: TextStyle(
                        color: AppColors.SECONDARY_COLOR,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                      ),
                    ),
                  );
                }),
              ],
            ),
            SizedBox(height: 1.h),
          ],
        ),
      ),
    );
  }
}
