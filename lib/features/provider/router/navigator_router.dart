import 'package:flutter/material.dart';
import 'package:state_management/features/provider/cart/cart.dart';
import 'package:state_management/features/provider/catalog/catalog.dart';

class NavigatorRouter {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static String initial = CatalogPage.route;

  static Map<String, WidgetBuilder> routes() {
    return {
      '/': (context) => const CatalogPage(),
      '/cart': (context) => const CartPage(),
    };
  }
}
