import 'package:flutter/widgets.dart';
import 'package:state_management/features/no_package/cart/state/cart_notifier.dart';

class CartState extends InheritedWidget {
  const CartState({
    required this.cartNotifier,
    required Widget child,
    Key? key,
  }) : super(child: child, key: key);

  final CartNotifier cartNotifier;

  static CartState of(BuildContext context) {
    return context.findAncestorWidgetOfExactType<CartState>()!;
  }

  @override
  bool updateShouldNotify(covariant CartState oldWidget) {
    return false;
  }
}
