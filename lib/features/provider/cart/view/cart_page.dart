import 'package:flutter/material.dart';
import 'package:state_management/common/common.dart';
import 'package:state_management/features/provider/cart/view/view.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  static const String route = '/cart';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.primary,
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
        elevation: 0,
      ),
      body: const CartView(),
    );
  }
}
