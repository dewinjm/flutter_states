import 'package:flutter/material.dart';
import 'package:state_management/common/widget/widget.dart';
import 'package:state_management/features/no_package/catalog/state/state.dart';

class Badge extends StatelessWidget {
  const Badge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartNotifier = CatalogState.of(context).cartNotifier;

    return ValueListenableBuilder(
      valueListenable: cartNotifier,
      builder: (context, items, _) {
        return CoreBadge(count: cartNotifier.items.length);
      },
    );
  }
}