import 'package:flutter/material.dart';
import 'package:state_management/common/common.dart';
import 'package:state_management/features/no_package/catalog/state/state.dart';

class CatalogItem extends StatelessWidget {
  const CatalogItem({required this.catalog, Key? key}) : super(key: key);

  final Catalog catalog;

  @override
  Widget build(BuildContext context) {
    final cartNotifier = CatalogState.of(context).cartNotifier;

    return CoreCatalogItem(
      key: Key('_item_${catalog.id.toString()}'),
      catalog: catalog,
      onPressed: () {
        cartNotifier.add(
          Cart(item: catalog, count: 1),
        );
      },
    );
  }
}
