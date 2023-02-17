import 'package:flutter/material.dart';
import 'package:state_management/common/common.dart';

class CartPayment extends StatelessWidget {
  const CartPayment({
    required this.amout,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final String amout;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: 150,
      decoration: BoxDecoration(
        color: Palette.primary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(Values.borderRadiusDouble),
          topRight: Radius.circular(Values.borderRadiusDouble),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 8,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(Values.padding),
        child: Column(
          children: [
            Text(
              'Total: \$$amout',
              style: const TextStyle(
                color: Palette.form,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: Values.padding),
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: Values.layoutmMaxWidth,
              ),
              child: ElevatedButton(
                key: const Key('_cart_payment_button'),
                onPressed: () => onPressed(),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      Values.borderRadius,
                    ),
                  ),
                  backgroundColor: Palette.accent,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Values.padding,
                    vertical: 22,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.shopping_cart_sharp,
                        size: 22,
                      ),
                      SizedBox(width: 8),
                      Text('PAYOUT'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
