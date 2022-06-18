import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_management/common/common.dart';
import 'package:state_management/features/riverpod/riverpod.dart';

class CartView extends ConsumerWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartStateNotifierProvider);
    final notifier = ref.read(cartStateNotifierProvider.notifier);

    if (cartState.items.isEmpty) return const CartEmpty();

    return CartContainer(
      listOfCart: Column(
        children: cartState.items
            .asMap()
            .entries
            .map(
              (entry) => CartItem(
                cart: entry.value,
                onChange: (option) {
                  _onPressedItemOption(option, entry.value, notifier);
                },
              ),
            )
            .toList(),
      ),
      amout: ref.watch(cartAmountProvider),
      onPaymentPressed: () {
        _saveCart(context, notifier);
      },
    );
  }

  void _onPressedItemOption(
    CartItemOption option,
    Cart cart,
    CartStateNotifier notifier,
  ) {
    switch (option) {
      case CartItemOption.increase:
        notifier.add(cart);
        break;
      case CartItemOption.decrease:
        notifier.decrease(cart);
        break;
      case CartItemOption.remove:
        notifier.remove(cart);
        break;
    }
  }

  void _saveCart(BuildContext context, CartStateNotifier notifier) async {
    _showDialog(context);
    await notifier.process();
  }

  void _showDialog(BuildContext context) async {
    showDialog<CartDialog>(
      context: context,
      useRootNavigator: false,
      barrierDismissible: false,
      builder: (BuildContext context) => const CartDialog(),
    );
  }
}
