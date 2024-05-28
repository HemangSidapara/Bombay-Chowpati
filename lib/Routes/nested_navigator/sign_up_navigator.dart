import 'package:bombay_chowpati/Constants/app_constance.dart';
import 'package:bombay_chowpati/Routes/app_pages.dart';
import 'package:bombay_chowpati/Screens/auth_screen/sign_up_screen/sign_up_bindings.dart';
import 'package:bombay_chowpati/Screens/auth_screen/sign_up_screen/sign_up_view.dart';
import 'package:bombay_chowpati/Screens/home_screen/settings_screen/terms_and_conditions_screen/terms_and_conditions_bindings.dart';
import 'package:bombay_chowpati/Screens/home_screen/settings_screen/terms_and_conditions_screen/terms_and_conditions_view.dart';
import 'package:bombay_chowpati/Utils/app_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpNavigator extends StatelessWidget {
  const SignUpNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(AppConstance.signUpNavigatorKey.getNavigatorId),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case Routes.termsAndConditionsScreen:
            return GetPageRoute(
              routeName: Routes.termsAndConditionsScreen,
              page: () => const TermsAndConditionsView(),
              binding: TermsAndConditionsBindings(),
              settings: RouteSettings(
                name: Routes.termsAndConditionsScreen,
                arguments: AppConstance.signUpNavigatorKey.getNavigatorId,
              ),
              transition: Transition.rightToLeftWithFade,
              transitionDuration: transitionDuration,
            );
          default:
            return GetPageRoute(
              routeName: Routes.signUpScreen,
              page: () => const SignUpView(),
              binding: SignUpBindings(),
              transition: Transition.rightToLeftWithFade,
              transitionDuration: transitionDuration,
            );
        }
      },
    );
  }
}
