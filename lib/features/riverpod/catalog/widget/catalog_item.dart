import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_management/common/common.dart';
import 'package:state_management/features/riverpod/riverpod.dart';

class CatalogItem extends ConsumerWidget {
  const CatalogItem({required this.catalog, Key? key}) : super(key: key);

  final Catalog catalog;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CatalogItemBase(
      key: Key('_item_${catalog.id.toString()}'),
      catalog: catalog,
      onPressed: () {
        ref.read(cartStateNotifierProvider.notifier).add(
              Cart(item: catalog, count: 1),
            );
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
