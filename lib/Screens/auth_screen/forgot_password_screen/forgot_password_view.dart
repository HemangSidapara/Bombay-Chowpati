import 'package:bombay_chowpati/Constants/app_colors.dart';
import 'package:bombay_chowpati/Constants/app_strings.dart';
import 'package:bombay_chowpati/Constants/app_utils.dart';
import 'package:bombay_chowpati/Routes/app_pages.dart';
import 'package:bombay_chowpati/Screens/auth_screen/forgot_password_screen/forgot_password_controller.dart';
import 'package:bombay_chowpati/Widgets/button_widget.dart';
import 'package:bombay_chowpati/Widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  ForgotPasswordController controller = Get.find<ForgotPasswordController>();

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

              ///Field
              Flexible(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 7.w),
                  child: Form(
                    key: controller.forgotPasswordFormKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 5.h),

                        ///Title
                        Padding(
                          padding: EdgeInsets.only(left: 2.w),
                          child: Text(
                            AppStrings.forgotPassword.tr,
                            style: TextStyle(
                              fontSize: 25.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.PRIMARY_COLOR,
                            ),
                          ),
                        ),
                        SizedBox(height: 3.h),

                        ///Email
                        TextFieldWidget(
                          controller: controller.emailController,
                          hintText: AppStrings.enterYourEmailAddress.tr,
                          validator: controller.emailValidator,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          prefixIcon: Icon(
                            Icons.email_rounded,
                            color: AppColors.HINT_GREY_COLOR,
                            size: 6.w,
                          ),
                          maxLength: 50,
                        ),
                        SizedBox(height: 2.h),

                        ///Note & OTP | Resend
                        Obx(
                          () {
                            return AnimatedCrossFade(
                              crossFadeState: controller.isCodeSent.isTrue ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                              duration: const Duration(milliseconds: 300),
                              firstChild: Column(
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      text: "* ",
                                      style: TextStyle(
                                        color: AppColors.PRIMARY_COLOR,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: AppStrings.weWillSendYouAMessageToSetOrResetYourNewPassword.tr,
                                          style: TextStyle(
                                            color: AppColors.BLACK_COLOR,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 3.h),
                                ],
                              ),
                              secondChild: Column(
                                children: [
                                  Pinput(
                                    controller: controller.otpController,
                                    length: 4,
                                    validator: controller.confirmationCodeValidator,
                                    scrollPadding: EdgeInsets.symmetric(vertical: 13.h),
                                    onCompleted: (value) async {},
                                    focusedPinTheme: PinTheme(
                                      height: 12.w,
                                      width: 12.w,
                                      textStyle: TextStyle(
                                        color: AppColors.PRIMARY_COLOR,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.SECONDARY_COLOR,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: AppColors.PRIMARY_COLOR,
                                          width: 1.5,
                                        ),
                                      ),
                                    ),
                                    defaultPinTheme: PinTheme(
                                      height: 12.w,
                                      width: 12.w,
                                      textStyle: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.PRIMARY_COLOR,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.SECONDARY_COLOR,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: AppColors.LIGHT_GREY_COLOR,
                                          width: 1.5,
                                        ),
                                      ),
                                    ),
                                    errorText: AppStrings.invalidCode.tr,
                                  ),
                                  SizedBox(height: 2.h),
                                  TextButton(
                                    onPressed: () {},
                                    style: TextButton.styleFrom(
                                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    child: Text(
                                      AppStrings.resend.tr,
                                      style: TextStyle(
                                        color: AppColors.FACEBOOK_BLUE_COLOR,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 2.h),
                                ],
                              ),
                            );
                          },
                        ),

                        ///Send Code & Verify
                        Obx(() {
                          return ButtonWidget(
                            onPressed: controller.isCodeSent.isTrue
                                ? () {
                                    controller.isCodeSent.toggle();
                                    Get.toNamed(Routes.resetPasswordScreen, id: 0);
                                  }
                                : () {
                                    controller.isCodeSent.toggle();
                                  },
                            buttonTitle: controller.isCodeSent.isTrue ? AppStrings.verify.tr : AppStrings.sendCode.tr,
                            buttonColor: controller.isCodeSent.isTrue ? AppColors.WARNING_COLOR.withOpacity(0.8) : null,
                          );
                        }),
                        SizedBox(height: 5.h),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
