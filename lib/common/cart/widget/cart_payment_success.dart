import 'package:flutter/material.dart';
import 'package:state_management/common/common.dart';

class CartPaymentSuccess extends StatelessWidget {
  const CartPaymentSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          Values.borderRadiusDouble,
        ),
      ),
      content: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Positioned(
            right: 0,
            top: 0,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
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
      ),
    );
  }
}
