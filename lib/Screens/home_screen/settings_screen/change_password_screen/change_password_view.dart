import 'package:bombay_chowpati/Constants/app_colors.dart';
import 'package:bombay_chowpati/Constants/app_constance.dart';
import 'package:bombay_chowpati/Constants/app_strings.dart';
import 'package:bombay_chowpati/Constants/app_utils.dart';
import 'package:bombay_chowpati/Screens/home_screen/settings_screen/change_password_screen/change_password_controller.dart';
import 'package:bombay_chowpati/Utils/app_formatter.dart';
import 'package:bombay_chowpati/Widgets/button_widget.dart';
import 'package:bombay_chowpati/Widgets/custom_header_widget.dart';
import 'package:bombay_chowpati/Widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Utils.unfocus(),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w).copyWith(top: 0),
        child: Column(
          children: [
            ///Header
            CustomHeaderWidget(
              title: AppStrings.changePassword.tr,
              onBackPressed: () {
                Get.back(id: AppConstance.settingsNavigatorKey.getNavigatorId, closeOverlays: true);
              },
            ),
            SizedBox(height: 2.h),

            ///Field
            Expanded(
              child: Form(
                key: controller.changePasswordFormKey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: Column(
                      children: [
                        SizedBox(height: 3.h),

                        ///Old Password
                        Obx(() {
                          return TextFieldWidget(
                            controller: controller.oldPasswordController,
                            hintText: AppStrings.enterYourOldPassword.tr,
                            validator: controller.oldPasswordValidator,
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.next,
                            obscureText: controller.isOldPasswordVisible.isFalse,
                            prefixIcon: Icon(
                              Icons.key_rounded,
                              color: AppColors.HINT_GREY_COLOR,
                              size: 6.w,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                controller.isOldPasswordVisible.toggle();
                              },
                              style: IconButton.styleFrom(
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              icon: Icon(
                                controller.isOldPasswordVisible.isTrue ? Icons.visibility_rounded : Icons.visibility_off_rounded,
                                color: controller.isOldPasswordVisible.isTrue ? AppColors.PRIMARY_COLOR : AppColors.HINT_GREY_COLOR,
                                size: 5.5.w,
                              ),
                            ),
                            suffixIconConstraints: BoxConstraints(minWidth: 12.w),
                            maxLength: 20,
                          );
                        }),
                        SizedBox(height: 1.5.h),

                        ///New Password
                        Obx(() {
                          return TextFieldWidget(
                            controller: controller.newPasswordController,
                            hintText: AppStrings.enterNewPassword.tr,
                            validator: controller.newPasswordValidator,
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.next,
                            obscureText: controller.isNewPasswordVisible.isFalse,
                            prefixIcon: Icon(
                              Icons.password_rounded,
                              color: AppColors.HINT_GREY_COLOR,
                              size: 6.w,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                controller.isNewPasswordVisible.toggle();
                              },
                              style: IconButton.styleFrom(
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              icon: Icon(
                                controller.isNewPasswordVisible.isTrue ? Icons.visibility_rounded : Icons.visibility_off_rounded,
                                color: controller.isNewPasswordVisible.isTrue ? AppColors.PRIMARY_COLOR : AppColors.HINT_GREY_COLOR,
                                size: 5.5.w,
                              ),
                            ),
                            suffixIconConstraints: BoxConstraints(minWidth: 12.w),
                            maxLength: 20,
                          );
                        }),
                        SizedBox(height: 1.5.h),

                        ///Confirm Password
                        Obx(() {
                          return TextFieldWidget(
                            controller: controller.confirmNewPasswordController,
                            hintText: AppStrings.confirmNewPassword.tr,
                            validator: controller.confirmNewPasswordValidator,
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.next,
                            obscureText: controller.isConfirmNewPasswordVisible.isFalse,
                            prefixIcon: Icon(
                              Icons.lock_rounded,
                              color: AppColors.HINT_GREY_COLOR,
                              size: 6.w,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                controller.isConfirmNewPasswordVisible.toggle();
                              },
                              style: IconButton.styleFrom(
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              icon: Icon(
                                controller.isConfirmNewPasswordVisible.isTrue ? Icons.visibility_rounded : Icons.visibility_off_rounded,
                                color: controller.isConfirmNewPasswordVisible.isTrue ? AppColors.PRIMARY_COLOR : AppColors.HINT_GREY_COLOR,
                                size: 5.5.w,
                              ),
                            ),
                            suffixIconConstraints: BoxConstraints(minWidth: 12.w),
                            maxLength: 20,
                          );
                        }),
                        SizedBox(height: 5.h),

                        ///Change Button
                        Obx(() {
                          return ButtonWidget(
                            onPressed: () async {
                              await controller.checkChangePassword();
                            },
                            isLoading: controller.isChangePasswordLoading.isTrue,
                            buttonTitle: AppStrings.change.tr,
                          );
                        }),
                        SizedBox(height: 5.h),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
