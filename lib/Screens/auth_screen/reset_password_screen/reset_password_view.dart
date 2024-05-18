import 'package:bombay_chowpati/Constants/app_colors.dart';
import 'package:bombay_chowpati/Constants/app_strings.dart';
import 'package:bombay_chowpati/Constants/app_utils.dart';
import 'package:bombay_chowpati/Routes/app_pages.dart';
import 'package:bombay_chowpati/Screens/auth_screen/reset_password_screen/reset_password_controller.dart';
import 'package:bombay_chowpati/Widgets/button_widget.dart';
import 'package:bombay_chowpati/Widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Utils.unfocus(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 2.h),
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () {
                    Get.back(id: 0);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 6.w,
                  ),
                ),
              ),

              ///Password
              Flexible(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 7.w),
                  child: Form(
                    key: controller.resetPasswordFormKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 3.h),

                        ///Title
                        Padding(
                          padding: EdgeInsets.only(left: 2.w),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              AppStrings.resetPassword.tr,
                              style: TextStyle(
                                fontSize: 25.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.PRIMARY_COLOR,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 3.h),

                        ///Password
                        Obx(() {
                          return TextFieldWidget(
                            controller: controller.passwordController,
                            hintText: AppStrings.enterPassword.tr,
                            validator: controller.passwordValidator,
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.next,
                            obscureText: controller.isPasswordVisible.isFalse,
                            prefixIcon: Icon(
                              Icons.key_rounded,
                              color: AppColors.HINT_GREY_COLOR,
                              size: 6.w,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                controller.isPasswordVisible.toggle();
                              },
                              style: IconButton.styleFrom(
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              icon: Icon(
                                controller.isPasswordVisible.isTrue ? Icons.visibility_rounded : Icons.visibility_off_rounded,
                                color: controller.isPasswordVisible.isTrue ? AppColors.PRIMARY_COLOR : AppColors.HINT_GREY_COLOR,
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
                            controller: controller.confirmPasswordController,
                            hintText: AppStrings.enterConfirmPassword.tr,
                            validator: controller.confirmPasswordValidator,
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.next,
                            obscureText: controller.isConfirmPasswordVisible.isFalse,
                            prefixIcon: Icon(
                              Icons.key_rounded,
                              color: AppColors.HINT_GREY_COLOR,
                              size: 6.w,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                controller.isConfirmPasswordVisible.toggle();
                              },
                              style: IconButton.styleFrom(
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              icon: Icon(
                                controller.isConfirmPasswordVisible.isTrue ? Icons.visibility_rounded : Icons.visibility_off_rounded,
                                color: controller.isConfirmPasswordVisible.isTrue ? AppColors.PRIMARY_COLOR : AppColors.HINT_GREY_COLOR,
                                size: 5.5.w,
                              ),
                            ),
                            suffixIconConstraints: BoxConstraints(minWidth: 12.w),
                            maxLength: 20,
                          );
                        }),
                        SizedBox(height: 3.h),

                        Obx(() {
                          return ButtonWidget(
                            onPressed: () {
                              Get.offNamedUntil(
                                Routes.signInScreen,
                                id: 0,
                                (route) => route.settings.name == Routes.root,
                              );
                            },
                            isLoading: controller.isResetPasswordLoading.isTrue,
                            buttonTitle: AppStrings.reset.tr,
                          );
                        }),
                        SizedBox(height: 5.h),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
