import 'package:flutter/material.dart';
import 'package:state_management/common/constant/constant.dart';

class CartEmpty extends StatelessWidget {
  const CartEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(Values.padding),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: Values.layoutmMaxWidth,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.shopping_cart_sharp,
                color: Palette.form,
                size: 92,
              ),
              const SizedBox(height: Values.padding),
              const Text(
                'Your cart is empty',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Palette.form,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Please go back and select your favorites items.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Palette.form,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: Values.paddingDouble),
              SizedBox(
                width: size.width,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        Values.borderRadius,
                      ),
                    ),
                    backgroundColor: Palette.accent,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Values.padding,
                      vertical: 22,
                    ),
                    child: Text('GO BACK'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
