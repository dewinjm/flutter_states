import 'package:flutter/material.dart';
import 'package:state_management/common/common.dart';
import 'package:state_management/features/provider/provider.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  late CartProvider cartProvider;

  @override
  Widget build(BuildContext context) {
    cartProvider = context.read<CartProvider>();

    return Consumer<CartProvider>(
      builder: (context, provider, child) {
        if (provider.items.isEmpty) {
          return const CartEmpty();
        }

        return CartContainer(
          listOfCart: Column(
            children: provider.items
                .asMap()
                .entries
                .map((entry) => CartItem(
                      cart: entry.value,
                      onChange: (option) {
                        _onPressedItemOption(option, entry.value);
                      },
                    ))
                .toList(),
          ),
          amout: provider.amount,
          onPaymentPressed: () => _saveCart(),
        );
      },
    );
  }

  void _onPressedItemOption(CartItemOption option, Cart cart) {
    switch (option) {
      case CartItemOption.increase:
        cartProvider.add(cart);
        break;
      case CartItemOption.decrease:
        cartProvider.decrease(cart);
        break;
      case CartItemOption.remove:
        cartProvider.remove(cart);
        break;
    }
  }

  void _saveCart() async {
    _showDialog();
    final isSuccesful = await cartProvider.process();
    if (isSuccesful) cartProvider.resetStatus();
  }

  void _showDialog() async {
    showDialog<CartDialog>(
      context: context,
      useRootNavigator: false,
      barrierDismissible: false,
      builder: (BuildContext context) => const CartDialog(),
    );
  }
}
