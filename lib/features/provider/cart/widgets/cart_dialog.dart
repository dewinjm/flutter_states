import 'package:flutter/material.dart';
import 'package:state_management/common/common.dart';
import 'package:state_management/features/provider/provider.dart';

class CartDialog extends StatelessWidget {
  const CartDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          Values.borderRadiusDouble,
        ),
      ),
      content: Consumer<CartProvider>(
        builder: ((context, provider, child) {
          switch (provider.state.cartStatus) {
            case CartStatus.loading:
              return _buildProgress();
            case CartStatus.done:
              return const CartPaymentSuccess();
            default:
              return Container(height: 10);
          }
        }),
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
