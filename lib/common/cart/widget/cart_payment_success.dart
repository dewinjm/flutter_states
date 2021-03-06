import 'package:flutter/material.dart';
import 'package:state_management/common/common.dart';

class CartPaymentSuccess extends StatelessWidget {
  const CartPaymentSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Positioned(
          right: 0,
          top: 0,
          child: IconButton(
            key: const Key('_cart_payment_success_close_button'),
            onPressed: () => _onBack(context),
            splashRadius: 22,
            icon: const Icon(
              Icons.close,
              color: Palette.primary,
              size: Values.iconSize,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(Values.paddingDouble),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/success.png'),
              const SizedBox(height: Values.padding),
              const Text(
                'Payment success',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: Values.paddingSmall),
              const Text(
                'Thanks your!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _onBack(BuildContext context) {
    Navigator.of(context).pop(); //Close Dialog
    Navigator.of(context).pop(); //Go back page
  }
}
