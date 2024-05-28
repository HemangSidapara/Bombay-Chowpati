import 'package:bombay_chowpati/Screens/auth_screen/auth_bindings.dart';
import 'package:bombay_chowpati/Screens/auth_screen/auth_view.dart';
import 'package:bombay_chowpati/Screens/auth_screen/sign_in_screen/sign_in_bindings.dart';
import 'package:bombay_chowpati/Screens/auth_screen/sign_up_screen/sign_up_bindings.dart';
import 'package:bombay_chowpati/Screens/home_screen/cart_screen/cart_bindings.dart';
import 'package:bombay_chowpati/Screens/home_screen/dashboard_screen/dashboard_bindings.dart';
import 'package:bombay_chowpati/Screens/home_screen/favourite_screen/favourite_bindings.dart';
import 'package:bombay_chowpati/Screens/home_screen/home_bindings.dart';
import 'package:bombay_chowpati/Screens/home_screen/home_view.dart';
import 'package:bombay_chowpati/Screens/home_screen/settings_screen/settings_bindings.dart';
import 'package:bombay_chowpati/Screens/splash_screen/splash_bindings.dart';
import 'package:bombay_chowpati/Screens/splash_screen/splash_view.dart';
import 'package:bombay_chowpati/Screens/welcome_screen/welcome_bindings.dart';
import 'package:bombay_chowpati/Screens/welcome_screen/welcome_view.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

Duration transitionDuration = const Duration(milliseconds: 400);

class AppPages {
  static final pages = [
    ///Splash Screen
    GetPage(
      name: Routes.splashScreen,
      page: () => const SplashView(),
      binding: SplashBindings(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: transitionDuration,
    ),

    ///Welcome Screen
    GetPage(
      name: Routes.welcomeScreen,
      page: () => const WelcomeView(),
      binding: WelcomeBindings(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: transitionDuration,
    ),

    ///Auth Screen
    GetPage(
      name: Routes.authScreen,
      page: () => const AuthView(),
      binding: AuthBindings(),
      bindings: [
        SignInBindings(),
        SignUpBindings(),
      ],
      transition: Transition.rightToLeftWithFade,
      transitionDuration: transitionDuration,
    ),

    ///Home Screen
    GetPage(
      name: Routes.homeScreen,
      page: () => const HomeView(),
      binding: HomeBindings(),
      bindings: [
        DashboardBindings(),
        FavouriteBindings(),
        CartBindings(),
        SettingsBindings(),
      ],
      transition: Transition.rightToLeftWithFade,
      transitionDuration: transitionDuration,
    ),
  ];
}
