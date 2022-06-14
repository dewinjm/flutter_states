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
        builder: ((context, value, child) {
          switch (value.status) {
            case CartStatus.initial:
              return Container(height: 10);
            case CartStatus.loading:
              return _buildProgress();
            case CartStatus.done:
              return _buildSucessful(context);
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

  Widget _buildSucessful(context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Positioned(
          right: 0,
          top: 0,
          child: IconButton(
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
