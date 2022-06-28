import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_management/common/cart/service/service.dart';
import 'package:state_management/common/common.dart'
    show Cart, CartRepository, CartRepositoryImpl;
import 'package:state_management/features/riverpod/riverpod.dart';

final cartRepositoryProvider = Provider.autoDispose<CartRepository>(
  (ref) => CartRepositoryImpl(),
);

final cartServiceProvider = Provider.autoDispose<CartService>(
  (ref) => CartServiceImpl(),
);

class CartStateNotifier extends StateNotifier<CartState> {
  CartStateNotifier(AutoDisposeStateNotifierProviderRef ref)
      : cartRepository = ref.read(cartRepositoryProvider),
        cartService = ref.read(cartServiceProvider),
        super(const CartState(items: [], cartStatus: CartStatus.initial));

  final CartRepository cartRepository;
  final CartService cartService;

  void add(Cart cart) {
    final items = cartService.addOrUpdateItem(cart, state.items);
    state = state.copyWith(items: items);
  }

  void decrease(Cart cart) {
    final items = cartService.decreaseItemCount(cart, state.items);
    state = state.copyWith(items: items);
  }

  void remove(Cart cart) {
    final items = cartService.removeItem(cart, state.items);
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
