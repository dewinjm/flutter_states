import 'package:flutter/material.dart';
import 'package:state_management/common/common.dart';
import 'package:state_management/features/no_package/no_package.dart';

class CartDialog extends StatelessWidget {
  const CartDialog({required this.cartProvider, Key? key}) : super(key: key);
  final CartProvider cartProvider;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          Values.borderRadiusDouble,
        ),
      ),
      content: ValueListenableBuilder(
        valueListenable: cartProvider.cartNotifier,
        builder: (context, items, _) {
          switch (cartProvider.cartNotifier.value.cartStatus) {
            case CartStatus.initial:
              return Container(height: 10);
            case CartStatus.loading:
              return _buildProgress();
            case CartStatus.done:
              return const CartPaymentSuccess();
            default:
              return Container(height: 10);
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
