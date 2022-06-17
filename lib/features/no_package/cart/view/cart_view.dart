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
        if (cartNotifier.value.isEmpty) return const CartEmpty();

        return CartContainer(
          listOfCart: Column(
            children: cartNotifier.value
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
    _showDialog();

    final isSuccessful = await cartState.process();
    if (isSuccessful) cartState.cartNotifier.resetStatus();
  }

  void _showDialog() async {
    showDialog<CartDialog>(
      context: context,
      barrierDismissible: false,
      useRootNavigator: false,
      builder: (BuildContext context) => CartDialog(
        cartState: cartState,
      ),
    );
  }
}
