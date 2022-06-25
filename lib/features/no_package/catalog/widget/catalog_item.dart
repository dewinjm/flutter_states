import 'package:flutter/material.dart';
import 'package:state_management/common/common.dart';
import 'package:state_management/features/no_package/no_package.dart';

class CatalogItem extends StatelessWidget {
  const CatalogItem({required this.catalog, Key? key}) : super(key: key);

  final Catalog catalog;

  @override
  Widget build(BuildContext context) {
    final cartNotifier = CatalogProvider.of(context).cartNotifier;

    return CatalogItemBase(
      key: Key('_item_${catalog.id.toString()}'),
      catalog: catalog,
      onPressed: () {
        cartNotifier.add(Cart(item: catalog, count: 1));

        _messageBar(context);
      },
    );
  }

  void _messageBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        duration: const Duration(milliseconds: 900),
        content: Row(
          children: [
            const Icon(Icons.plus_one, color: Palette.form),
            Text('${catalog.name} added'),
          ],
        ),
      ),
    );
  }
}
