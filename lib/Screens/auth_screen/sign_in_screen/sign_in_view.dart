import 'package:bombay_chowpati/Constants/app_assets.dart';
import 'package:bombay_chowpati/Constants/app_colors.dart';
import 'package:bombay_chowpati/Constants/app_strings.dart';
import 'package:bombay_chowpati/Constants/app_utils.dart';
import 'package:bombay_chowpati/Routes/app_pages.dart';
import 'package:bombay_chowpati/Screens/auth_screen/sign_in_screen/sign_in_controller.dart';
import 'package:bombay_chowpati/Widgets/button_widget.dart';
import 'package:bombay_chowpati/Widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w).copyWith(bottom: context.getKeyboardPadding != 0 ? 12.h : 0),
      child: Form(
        key: controller.signInFormKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 7.h),

              ///Phone number
              TextFieldWidget(
                controller: controller.phoneController,
                hintText: AppStrings.enterEmailPhoneNumber.tr,
                validator: controller.phoneValidator,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: 2.h),

              ///Password
              Obx(() {
                return TextFieldWidget(
                  controller: controller.passwordController,
                  hintText: AppStrings.enterPassword.tr,
                  obscureText: controller.isPasswordVisible.isFalse,
                  validator: controller.passwordValidator,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.next,
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
                );
              }),

              ///Forgot Password
              Align(
                alignment: Alignment.bottomLeft,
                child: TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.forgotPasswordScreen, id: 0);
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    AppStrings.forgotPassword.tr,
                    style: TextStyle(
                      color: AppColors.PRIMARY_COLOR,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 2.h),

              ///Send Code
              ButtonWidget(
                onPressed: () {},
                buttonTitle: AppStrings.login.tr,
              ),
              SizedBox(height: 2.h),

              ///Or
              Text(
                AppStrings.or.tr,
                style: TextStyle(
                  color: AppColors.BLACK_COLOR,
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                ),
              ),
              SizedBox(height: 5.h),

              ///Social Login
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ///Google
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.TEXTFIELD_COLOR,
                      elevation: 4,
                      padding: EdgeInsets.zero,
                      fixedSize: Size(15.w, 15.w),
                    ),
                    child: Image.asset(
                      AppAssets.googleIcon,
                      width: 8.w,
                      height: 8.w,
                    ),
                  ),

                  ///Apple
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.TEXTFIELD_COLOR,
                      elevation: 4,
                      padding: EdgeInsets.zero,
                      fixedSize: Size(15.w, 15.w),
                    ),
                    child: Image.asset(
                      AppAssets.appleIcon,
                      width: 8.w,
                      height: 8.w,
                    ),
                  ),

                  ///Facebook
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.TEXTFIELD_COLOR,
                      elevation: 4,
                      padding: EdgeInsets.zero,
                      fixedSize: Size(15.w, 15.w),
                    ),
                    child: Image.asset(
                      AppAssets.facebookIcon,
                      width: 8.w,
                      height: 8.w,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5.h),
            ],
          ),
        ),
      ),
    );
  }
}
