import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_management/common/common.dart';
import 'package:state_management/features/riverpod/cart/cart.dart';

class CartDialog extends ConsumerWidget {
  const CartDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartStateNotifierProvider);

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          Values.borderRadiusDouble,
        ),
      ),
      content: Builder(
        builder: (context) {
          switch (cartState.cartStatus) {
            case CartStatus.initial:
              return Container(height: 10);
            case CartStatus.loading:
              return _buildProgress();
            case CartStatus.done:
              return const CartPaymentSuccess();
          }
        },
      ),
    );
  }

  Widget _buildProgress() {
    return const Padding(
      padding: EdgeInsets.all(Values.borderRadius),
      child: SizedBox(
        height: 96,
        width: 96,
        child: Center(child: CoreProgressIndicator()),
      ),
    );
  }
}
