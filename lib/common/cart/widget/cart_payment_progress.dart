import 'package:flutter/material.dart';
import 'package:state_management/common/common.dart';

class CartPaymentProgress extends StatelessWidget {
  const CartPaymentProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          Values.borderRadiusDouble,
        ),
      ),
      content: const Padding(
        padding: EdgeInsets.all(Values.borderRadius),
        child: SizedBox(
          height: 96,
          width: 96,
          child: Center(child: CoreProgressIndicator()),
        ),
      ),
    );
  }
}
