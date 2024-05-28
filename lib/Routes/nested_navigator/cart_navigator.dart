import 'package:bombay_chowpati/Constants/app_constance.dart';
import 'package:bombay_chowpati/Routes/app_pages.dart';
import 'package:bombay_chowpati/Screens/home_screen/cart_screen/cart_bindings.dart';
import 'package:bombay_chowpati/Screens/home_screen/cart_screen/cart_view.dart';
import 'package:bombay_chowpati/Screens/home_screen/cart_screen/order_history_screen/order_history_bindings.dart';
import 'package:bombay_chowpati/Screens/home_screen/cart_screen/order_history_screen/order_history_view.dart';
import 'package:bombay_chowpati/Utils/app_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartNavigator extends StatelessWidget {
  const CartNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(AppConstance.cartNavigatorKey.getNavigatorId),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case Routes.orderHistoryScreen:
            return GetPageRoute(
              routeName: Routes.orderHistoryScreen,
              page: () => const OrderHistoryView(),
              binding: OrderHistoryBindings(),
              transition: Transition.rightToLeftWithFade,
              transitionDuration: transitionDuration,
            );
          default:
            return GetPageRoute(
              routeName: Routes.cartScreen,
              page: () => const CartView(),
              binding: CartBindings(),
              transition: Transition.rightToLeftWithFade,
              transitionDuration: transitionDuration,
            );
        }
      },
    );
  }
}
