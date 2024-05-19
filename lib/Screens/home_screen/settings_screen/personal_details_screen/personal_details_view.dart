import 'package:bombay_chowpati/Constants/app_strings.dart';
import 'package:bombay_chowpati/Constants/app_utils.dart';
import 'package:bombay_chowpati/Screens/home_screen/settings_screen/personal_details_screen/personal_details_controller.dart';
import 'package:bombay_chowpati/Widgets/button_widget.dart';
import 'package:bombay_chowpati/Widgets/custom_header_widget.dart';
import 'package:bombay_chowpati/Widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PersonalDetailsView extends GetView<PersonalDetailsController> {
  const PersonalDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Utils.unfocus(),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
        child: Column(
          children: [
            ///Header
            CustomHeaderWidget(
              title: AppStrings.personalDetails.tr,
              onBackPressed: () {
                Get.back(id: 1);
              },
            ),
            SizedBox(height: 2.h),

            ///Field
            Expanded(
              child: Form(
                key: controller.personalDetailsFormKey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: Column(
                      children: [
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
                        SizedBox(height: 5.h),

                        ///Edit Profile
                        Obx(() {
                          return ButtonWidget(
                            onPressed: () async {
                              await controller.checkEditProfile();
                            },
                            isLoading: controller.isPersonalDetailsLoading.isTrue,
                            buttonTitle: AppStrings.editProfile.tr,
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
