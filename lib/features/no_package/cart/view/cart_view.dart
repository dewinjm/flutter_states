import 'package:flutter/material.dart';
import 'package:state_management/common/common.dart';
import 'package:state_management/features/no_package/no_package.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  late CartProvider cartProvider;

  @override
  Widget build(BuildContext context) {
    cartProvider = CartProvider.of(context);
    final cartNotifier = cartProvider.cartNotifier;

    return ValueListenableBuilder(
      valueListenable: cartNotifier,
      builder: (context, items, _) {
        if (cartNotifier.value.items.isEmpty) return const CartEmpty();

        return CartContainer(
          listOfCart: Column(
            children: cartNotifier.value.items
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
          amout: cartNotifier.value.amount,
          onPaymentPressed: () => _saveCart(),
        );
      },
    );
  }

  void _onPressedItemOption(CartItemOption option, Cart cart) {
    switch (option) {
      case CartItemOption.increase:
        cartProvider.cartNotifier.add(cart);
        break;
      case CartItemOption.decrease:
        cartProvider.cartNotifier.decrease(cart);
        break;
      case CartItemOption.remove:
        cartProvider.cartNotifier.remove(cart);
        break;
    }
  }

  void _saveCart() async {
    _showDialog();
    await cartProvider.process();
  }

  void _showDialog() async {
    await showDialog<CartDialog>(
      context: context,
      barrierDismissible: false,
      useRootNavigator: false,
      builder: (BuildContext context) => CartDialog(
        cartProvider: cartProvider,
      ),
    );
    cartProvider.cartNotifier.resetStatus();
  }
}
