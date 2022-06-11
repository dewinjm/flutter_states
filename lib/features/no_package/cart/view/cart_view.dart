import 'package:flutter/material.dart';
import 'package:state_management/common/common.dart';
import 'package:state_management/features/no_package/no_package.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  late CartState cartState;

  @override
  Widget build(BuildContext context) {
    cartState = CartState.of(context);
    final cartNotifier = cartState.cartNotifier;

    return ValueListenableBuilder(
      valueListenable: cartNotifier,
      builder: (context, items, _) {
        if (cartNotifier.items.isEmpty) return const CartEmpty();

        return CartContainer(
          listOfCart: Column(
            children: cartNotifier.items
                .asMap()
                .entries
                .map((entry) => CartItem(
                      cart: entry.value,
                      onChange: (option) => _onPressedItemOption(
                        option,
                        entry.value,
                      ),
                    ))
                .toList(),
          ),
          amout: cartNotifier.amount,
          onPaymentPressed: () => _saveCart(),
        );
      },
    );
  }

  void _onPressedItemOption(CartItemOption option, Cart cart) {
    switch (option) {
      case CartItemOption.increase:
        cartState.cartNotifier.add(cart);
        break;
      case CartItemOption.decrease:
        cartState.cartNotifier.decrease(cart);
        break;
      case CartItemOption.remove:
        cartState.cartNotifier.remove(cart);
        break;
    }
  }

  void _saveCart() async {
    _showDialogProgress(context);

    final isSuccessful = await cartState.process();
    if (isSuccessful) _showDialogSuccessful();
  }

  void _showDialogProgress(BuildContext context) async {
    showDialog<CartPaymentProgress>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const CartPaymentProgress();
      },
    );
  }

  void _showDialogSuccessful() async {
    Navigator.pop(context);
    Navigator.pop(context);

    showDialog<CartPaymentSuccess>(
      context: context,
      builder: (BuildContext context) => const CartPaymentSuccess(),
    );
  }
}
