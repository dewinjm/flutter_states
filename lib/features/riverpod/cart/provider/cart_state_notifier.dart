import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_management/common/common.dart'
    show Cart, CartRepository, CartRepositoryImpl;
import 'package:state_management/features/riverpod/riverpod.dart';

final cartRepositoryProvider = Provider.autoDispose<CartRepository>(
  (ref) => CartRepositoryImpl(),
);

class CartStateNotifier extends StateNotifier<CartState> {
  final CartRepository cartRepository;

  CartStateNotifier(AutoDisposeStateNotifierProviderRef ref)
      : cartRepository = ref.read(cartRepositoryProvider),
        super(const CartState(items: [], cartStatus: CartStatus.initial));

  void add(Cart cart) {
    final List<Cart> items = List.from(state.items);

    if (items.where((e) => e.item.id == cart.item.id).isNotEmpty) {
      final index = items.indexWhere((e) => e.item == cart.item);
      final item = items[index];
      final count = item.count + 1;

      items[index] = item.copyWith(
        count: count,
        amount: (item.item.price * count),
      );
    } else {
      items.add(Cart(item: cart.item, count: 1, amount: cart.item.price));
    }

    state = state.copyWith(items: items);
  }

  void decrease(Cart cart) {
    final List<Cart> items = List.from(state.items);
    final index = items.indexWhere((e) => e.item == cart.item);
    final item = items[index];
    final count = item.count - 1;

    items[index] = item.copyWith(
      count: count,
      amount: (item.item.price * count),
    );

    state = state.copyWith(items: items);
  }

  void remove(Cart cart) {
    final List<Cart> items = List.from(state.items);
    if (items.contains(cart)) {
      items.remove(cart);
    }

    state = state.copyWith(items: items);
  }

  Future<bool> process() async {
    state = state.copyWith(cartStatus: CartStatus.loading);

    final isSuccessful = await cartRepository.send(cartItems: state.items);

    if (isSuccessful) {
      state = state.copyWith(items: [], cartStatus: CartStatus.done);
    }

    return isSuccessful;
  }

  void clear() {
    state = state.copyWith(items: [], cartStatus: CartStatus.initial);
  }
}
