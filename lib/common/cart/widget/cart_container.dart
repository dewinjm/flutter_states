import 'package:flutter/material.dart';
import 'package:state_management/common/common.dart';

class CartContainer extends StatelessWidget {
  const CartContainer({
    required this.listOfCart,
    required this.amout,
    required this.onPaymentPressed,
    Key? key,
  }) : super(key: key);

  final Widget listOfCart;
  final double amout;
  final Function onPaymentPressed;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(Values.paddingSmall),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Palette.form,
                      borderRadius:
                          BorderRadius.circular(Values.borderRadiusDouble),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: Values.paddingDouble,
                          horizontal: Values.padding,
                        ),
                        child: listOfCart,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 180),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: CartPayment(
              amout: amout.toStringAsFixed(2),
              onPressed: onPaymentPressed,
            ),
          ),
        ],
      ),
    );
  }
}
