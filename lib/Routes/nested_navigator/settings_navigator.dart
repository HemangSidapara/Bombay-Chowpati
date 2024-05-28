import 'package:bombay_chowpati/Constants/app_constance.dart';
import 'package:bombay_chowpati/Routes/app_pages.dart';
import 'package:bombay_chowpati/Screens/home_screen/settings_screen/change_password_screen/change_password_bindings.dart';
import 'package:bombay_chowpati/Screens/home_screen/settings_screen/change_password_screen/change_password_view.dart';
import 'package:bombay_chowpati/Screens/home_screen/settings_screen/personal_details_screen/personal_details_bindings.dart';
import 'package:bombay_chowpati/Screens/home_screen/settings_screen/personal_details_screen/personal_details_view.dart';
import 'package:bombay_chowpati/Screens/home_screen/settings_screen/privacy_policy_screen/privacy_policy_bindings.dart';
import 'package:bombay_chowpati/Screens/home_screen/settings_screen/privacy_policy_screen/privacy_policy_view.dart';
import 'package:bombay_chowpati/Screens/home_screen/settings_screen/settings_bindings.dart';
import 'package:bombay_chowpati/Screens/home_screen/settings_screen/settings_view.dart';
import 'package:bombay_chowpati/Screens/home_screen/settings_screen/terms_and_conditions_screen/terms_and_conditions_bindings.dart';
import 'package:bombay_chowpati/Screens/home_screen/settings_screen/terms_and_conditions_screen/terms_and_conditions_view.dart';
import 'package:bombay_chowpati/Utils/app_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsNavigator extends StatelessWidget {
  const SettingsNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(AppConstance.settingsNavigatorKey.getNavigatorId),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case Routes.personalDetailsScreen:
            return GetPageRoute(
              routeName: Routes.personalDetailsScreen,
              page: () => const PersonalDetailsView(),
              binding: PersonalDetailsBindings(),
              transition: Transition.rightToLeftWithFade,
              transitionDuration: transitionDuration,
            );
          case Routes.changePasswordScreen:
            return GetPageRoute(
              routeName: Routes.changePasswordScreen,
              page: () => const ChangePasswordView(),
              binding: ChangePasswordBindings(),
              transition: Transition.rightToLeftWithFade,
              transitionDuration: transitionDuration,
            );
          case Routes.privacyPolicyScreen:
            return GetPageRoute(
              routeName: Routes.privacyPolicyScreen,
              page: () => const PrivacyPolicyView(),
              binding: PrivacyPolicyBindings(),
              transition: Transition.rightToLeftWithFade,
              transitionDuration: transitionDuration,
            );
          case Routes.termsAndConditionsScreen:
            return GetPageRoute(
              routeName: Routes.termsAndConditionsScreen,
              page: () => const TermsAndConditionsView(),
              binding: TermsAndConditionsBindings(),
              transition: Transition.rightToLeftWithFade,
              transitionDuration: transitionDuration,
            );
          default:
            return GetPageRoute(
              routeName: Routes.settingScreen,
              page: () => const SettingsView(),
              binding: SettingsBindings(),
              transition: Transition.rightToLeftWithFade,
              transitionDuration: transitionDuration,
            );
        }
      },
    );
  }
}
