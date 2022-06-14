import 'package:flutter/material.dart';
import 'package:state_management/common/widget/widget.dart';
import 'package:state_management/features/provider/cart/provider/provider.dart';

class CatalogBadge extends StatelessWidget {
  const CatalogBadge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, state, child) {
        final count = state.items.length;

        if (count <= 0) {
          return const SizedBox();
        } else {
          return CoreBadge(count: state.items.length);
        }
      },
    );
  }
}
