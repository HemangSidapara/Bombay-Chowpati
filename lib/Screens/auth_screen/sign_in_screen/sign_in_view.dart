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
    return GestureDetector(
      onTap: () => Utils.unfocus(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Form(
          key: controller.signInFormKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 7.h),

                ///Email/Phone number
                TextFieldWidget(
                  controller: controller.emailPhoneController,
                  hintText: AppStrings.enterEmailPhoneNumber.tr,
                  validator: controller.emailPhoneValidator,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  maxLength: 50,
                ),
                SizedBox(height: 1.5.h),

                ///Password
                Obx(() {
                  return TextFieldWidget(
                    controller: controller.passwordController,
                    hintText: AppStrings.enterPassword.tr,
                    obscureText: controller.isPasswordVisible.isFalse,
                    validator: controller.passwordValidator,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                    maxLength: 20,
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
                      Utils.unfocus();
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

                ///Login
                Obx(() {
                  return ButtonWidget(
                    onPressed: () async {
                      await controller.checkSignIn();
                    },
                    isLoading: controller.isSignInLoading.isTrue,
                    buttonTitle: AppStrings.login.tr,
                  );
                }),
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
                    SocialLoginWidget(image: AppAssets.googleIcon),

                    ///Apple
                    SocialLoginWidget(image: AppAssets.appleIcon),

                    ///Facebook
                    SocialLoginWidget(image: AppAssets.facebookIcon),
                  ],
                ),
                SizedBox(height: 5.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget SocialLoginWidget({void Function()? onPressed, required String image}) {
    return ElevatedButton(
      onPressed: () {
        Utils.unfocus();
        onPressed?.call();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.TEXTFIELD_COLOR,
        elevation: 4,
        padding: EdgeInsets.zero,
        fixedSize: Size(15.w, 15.w),
      ),
      child: Image.asset(
        image,
        width: 8.w,
        height: 8.w,
      ),
    );
  }
}
