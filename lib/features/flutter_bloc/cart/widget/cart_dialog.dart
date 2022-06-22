import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management/common/common.dart';
import 'package:state_management/features/flutter_bloc/flutter_bloc.dart';

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
      content: BlocBuilder<CartBloc, CartState>(
        builder: ((context, state) {
          switch (state.cartStatus) {
            case CartStatus.initial:
              return Container(height: 10);
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
