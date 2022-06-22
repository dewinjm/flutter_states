import 'package:flutter/material.dart';
import 'package:state_management/common/common.dart';
import 'package:state_management/features/flutter_bloc/cart/view/cart_view.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  static MaterialPageRoute router() {
    return MaterialPageRoute(builder: ((_) => const CartPage()));
  }

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
