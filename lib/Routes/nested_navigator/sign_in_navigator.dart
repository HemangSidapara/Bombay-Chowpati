import 'package:bombay_chowpati/Constants/app_constance.dart';
import 'package:bombay_chowpati/Routes/app_pages.dart';
import 'package:bombay_chowpati/Screens/auth_screen/forgot_password_screen/forgot_password_bindings.dart';
import 'package:bombay_chowpati/Screens/auth_screen/forgot_password_screen/forgot_password_view.dart';
import 'package:bombay_chowpati/Screens/auth_screen/reset_password_screen/reset_password_bindings.dart';
import 'package:bombay_chowpati/Screens/auth_screen/reset_password_screen/reset_password_view.dart';
import 'package:bombay_chowpati/Screens/auth_screen/sign_in_screen/sign_in_bindings.dart';
import 'package:bombay_chowpati/Screens/auth_screen/sign_in_screen/sign_in_view.dart';
import 'package:bombay_chowpati/Utils/app_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInNavigator extends StatelessWidget {
  const SignInNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(AppConstance.signInNavigatorKey.getNavigatorId),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case Routes.forgotPasswordScreen:
            return GetPageRoute(
              routeName: Routes.forgotPasswordScreen,
              page: () => const ForgotPasswordView(),
              binding: ForgotPasswordBindings(),
              transition: Transition.rightToLeftWithFade,
              transitionDuration: transitionDuration,
            );
          case Routes.resetPasswordScreen:
            return GetPageRoute(
              routeName: Routes.resetPasswordScreen,
              page: () => const ResetPasswordView(),
              binding: ResetPasswordBindings(),
              transition: Transition.rightToLeftWithFade,
              transitionDuration: transitionDuration,
            );
          default:
            return GetPageRoute(
              routeName: Routes.signInScreen,
              page: () => const SignInView(),
              binding: SignInBindings(),
              transition: Transition.rightToLeftWithFade,
              transitionDuration: transitionDuration,
            );
        }
      },
    );
  }
}
