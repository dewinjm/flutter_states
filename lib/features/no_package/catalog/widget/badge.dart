import 'package:flutter/material.dart';
import 'package:state_management/common/widget/widget.dart';
import 'package:state_management/features/no_package/no_package.dart';

class Badge extends StatelessWidget {
  const Badge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartNotifier = CatalogProvider.of(context).cartNotifier;

    return ValueListenableBuilder(
      valueListenable: cartNotifier,
      builder: (context, items, _) {
        final count = cartNotifier.value.items.length;

        if (count <= 0) {
          return const SizedBox();
        } else {
          return CoreBadge(count: count);
        }
      },
    );
  }
}
