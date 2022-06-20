import 'package:flutter_riverpod/flutter_riverpod.dart'
    show Provider, StateNotifierProvider;
import 'package:state_management/features/riverpod/riverpod.dart';

final cartAmountProvider = Provider.autoDispose<double>((ref) {
  final cartState = ref.watch(cartStateNotifierProvider);

  if (cartState.items.isEmpty) return 0;
  return cartState.items
      .map((item) => item.amount ?? 0)
      .reduce((value, current) => value + current);
});

final cartStateNotifierProvider =
    StateNotifierProvider.autoDispose<CartStateNotifier, CartState>(
  (ref) => CartStateNotifier(ref),
);
