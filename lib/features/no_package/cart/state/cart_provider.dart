import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:state_management/common/cart/cart.dart';
import 'package:flutter/material.dart';

part 'cart_state.dart';
part 'cart_notifier.dart';

class CartProvider extends InheritedWidget {
  const CartProvider({
    required this.cartNotifier,
    required this.cartRepository,
    required Widget child,
    Key? key,
  }) : super(child: child, key: key);

  final CartNotifier cartNotifier;
  final CartRepository cartRepository;

  Future<void> process() async {
    cartNotifier.process(cartRepository);
  }

  static CartProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CartProvider>()!;
  }

  @override
  bool updateShouldNotify(covariant CartProvider oldWidget) => false;
}
