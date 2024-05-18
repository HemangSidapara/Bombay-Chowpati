import 'package:bombay_chowpati/Routes/app_pages.dart';
import 'package:bombay_chowpati/Screens/home_screen/settings_screen/personal_details_screen/personal_details_bindings.dart';
import 'package:bombay_chowpati/Screens/home_screen/settings_screen/personal_details_screen/personal_details_view.dart';
import 'package:bombay_chowpati/Screens/home_screen/settings_screen/settings_bindings.dart';
import 'package:bombay_chowpati/Screens/home_screen/settings_screen/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsNavigator extends StatelessWidget {
  const SettingsNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(1),
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
