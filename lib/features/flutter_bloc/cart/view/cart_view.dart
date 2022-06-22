import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management/common/common.dart';
import 'package:state_management/features/flutter_bloc/flutter_bloc.dart';

class CartView extends StatelessWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: ((context, state) {
        if (state.items.isEmpty) return const CartEmpty();

        return CartContainer(
          listOfCart: Column(
            children: state.items
                .asMap()
                .entries
                .map(
                  (entry) => CartItem(
                    cart: entry.value,
                    onChange: (option) {
                      _onPressedItemOption(context, option, entry.value);
                    },
                  ),
                )
                .toList(),
          ),
          amout: state.amount,
          onPaymentPressed: () {
            _saveCart(context);
          },
        );
      }),
    );
  }

  void _onPressedItemOption(
    BuildContext context,
    CartItemOption option,
    Cart cart,
  ) {
    final bloc = context.read<CartBloc>();
    switch (option) {
      case CartItemOption.increase:
        bloc.add(CartItemAdded(cart));
        break;
      case CartItemOption.decrease:
        bloc.add(CartItemCountDecreased(cart));
        break;
      case CartItemOption.remove:
        bloc.add(CartItemRemoved(cart));
        break;
    }
  }

  void _saveCart(BuildContext context) async {
    final bloc = context.read<CartBloc>();

    _showDialog(context, bloc);
    bloc.add(CartProcessed());
  }

  void _showDialog(BuildContext context, CartBloc bloc) async {
    await showDialog<CartDialog>(
      context: context,
      useRootNavigator: false,
      barrierDismissible: false,
      builder: (BuildContext context) => const CartDialog(),
    );
    bloc.add(CartResetStatus());
  }
}
