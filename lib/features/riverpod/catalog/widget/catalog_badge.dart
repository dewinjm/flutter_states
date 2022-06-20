import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_management/common/common.dart';
import 'package:state_management/features/riverpod/riverpod.dart';

class CatalogBadge extends ConsumerWidget {
  const CatalogBadge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(builder: (context, ref, child) {
      final cartState = ref.watch(cartStateNotifierProvider);

      if (cartState.items.isEmpty) {
        return const SizedBox();
      } else {
        return CoreBadge(count: cartState.items.length);
      }
    });
  }
}
