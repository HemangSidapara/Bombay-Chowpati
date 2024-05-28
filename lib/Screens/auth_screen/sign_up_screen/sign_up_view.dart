import 'package:bombay_chowpati/Constants/app_colors.dart';
import 'package:bombay_chowpati/Constants/app_constance.dart';
import 'package:bombay_chowpati/Constants/app_strings.dart';
import 'package:bombay_chowpati/Constants/app_utils.dart';
import 'package:bombay_chowpati/Routes/app_pages.dart';
import 'package:bombay_chowpati/Screens/auth_screen/auth_controller.dart';
import 'package:bombay_chowpati/Screens/auth_screen/sign_up_screen/sign_up_controller.dart';
import 'package:bombay_chowpati/Utils/app_formatter.dart';
import 'package:bombay_chowpati/Widgets/button_widget.dart';
import 'package:bombay_chowpati/Widgets/textfield_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Utils.unfocus(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Form(
          key: controller.signUpFormKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 3.h),

                ///Title
                Padding(
                  padding: EdgeInsets.only(left: 2.w),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppStrings.register.tr,
                      style: TextStyle(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.PRIMARY_COLOR,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 3.h),

                ///Name
                TextFieldWidget(
                  controller: controller.nameController,
                  hintText: AppStrings.enterYourName.tr,
                  validator: controller.nameValidator,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  maxLength: 50,
                ),
                SizedBox(height: 1.5.h),

                ///Email
                TextFieldWidget(
                  controller: controller.emailController,
                  hintText: AppStrings.enterEmailAddress.tr,
                  validator: controller.emailValidator,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  maxLength: 50,
                ),
                SizedBox(height: 1.5.h),

                ///Phone
                TextFieldWidget(
                  controller: controller.phoneController,
                  hintText: AppStrings.enterPhoneNumber.tr,
                  validator: controller.phoneValidator,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  maxLength: 10,
                ),
                SizedBox(height: 1.5.h),

                ///Password
                Obx(() {
                  return TextFieldWidget(
                    controller: controller.passwordController,
                    hintText: AppStrings.enterPassword.tr,
                    validator: controller.passwordValidator,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                    obscureText: controller.isPasswordVisible.isFalse,
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
                SizedBox(height: 1.h),

                ///Term & Conditions
                Obx(() {
                  return Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.isTermsAndConditionsChecked.toggle();
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 350),
                          decoration: BoxDecoration(
                            color: controller.isTermsAndConditionsChecked.isTrue ? AppColors.PRIMARY_COLOR : AppColors.SECONDARY_COLOR,
                            border: Border.all(
                              color: AppColors.PRIMARY_COLOR,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(0.2.w),
                            child: AnimatedOpacity(
                              opacity: controller.isTermsAndConditionsChecked.isTrue ? 1 : 0,
                              duration: const Duration(milliseconds: 300),
                              child: Icon(
                                Icons.check_rounded,
                                color: AppColors.WHITE_COLOR,
                                size: 4.w,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 2.w),
                      InkWell(
                        onTap: () {
                          Get.toNamed(Routes.termsAndConditionsScreen, id: AppConstance.signUpNavigatorKey.getNavigatorId);
                          // Get.to(
                          //   id: AppConstance.signUpNavigatorKey.getNavigatorId,
                          //   () => const TermsAndConditionsView(),
                          //   binding: TermsAndConditionsBindings(),
                          //   arguments: AppConstance.signUpNavigatorKey.getNavigatorId,
                          //   transition: Transition.rightToLeftWithFade,
                          // );
                        },
                        child: Text(
                          AppStrings.iAgreeWithTermsAndConditions.tr,
                          style: TextStyle(
                            color: AppColors.BLACK_COLOR,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  );
                }),
                SizedBox(height: 3.h),

                ///Create account
                Obx(() {
                  return ButtonWidget(
                    onPressed: () async {
                      await controller.checkSignUp();
                    },
                    isLoading: controller.isSignUpLoading.isTrue,
                    buttonTitle: AppStrings.createAccount.tr,
                  );
                }),
                SizedBox(height: 1.h),
                Text.rich(
                  TextSpan(
                    text: AppStrings.alreadyAMember.tr,
                    style: TextStyle(
                      color: AppColors.BLACK_COLOR,
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                    ),
                    children: [
                      TextSpan(
                        text: AppStrings.login.tr,
                        recognizer: TapGestureRecognizer()..onTap = () => Get.find<AuthController>().tabController.animateTo(0),
                        style: TextStyle(
                          color: AppColors.PRIMARY_COLOR,
                          fontWeight: FontWeight.w700,
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 3.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
