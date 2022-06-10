import 'package:flutter/widgets.dart';
import 'package:state_management/common/cart/cart.dart';
import 'package:state_management/features/no_package/cart/state/cart_notifier.dart';

class CartState extends InheritedWidget {
  const CartState({
    required this.cartNotifier,
    required this.cartRepository,
    required Widget child,
    Key? key,
  }) : super(child: child, key: key);

  final CartNotifier cartNotifier;
  final CartRepository cartRepository;

  Future<bool> process() async {
    final isSuccessful = await cartRepository.send(
      cartItems: cartNotifier.items,
    );

    if (isSuccessful) cartNotifier.clear();
    return isSuccessful;
  }

  static CartState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CartState>()!;
  }

  @override
  bool updateShouldNotify(covariant CartState oldWidget) {
    return false;
  }
}
