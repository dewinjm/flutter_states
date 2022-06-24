part of 'cart_provider.dart';

class CartNotifier extends ValueNotifier<CartState> {
  CartNotifier({required this.cartService}) : super(const CartState.initial());

  final CartService cartService;

  void add(Cart cart) {
    final items = cartService.addOrUpdateItem(cart, value.items);
    value = value.copyWith(items: items, amount: _calculateAmount(items));
    notifyListeners();
  }

  void decrease(Cart cart) {
    final items = cartService.decreaseItemCount(cart, value.items);
    value = value.copyWith(items: items, amount: _calculateAmount(items));
    notifyListeners();
  }

  void remove(Cart cart) {
    final items = cartService.removeItem(cart, value.items);
    value = value.copyWith(items: items, amount: _calculateAmount(items));
    notifyListeners();
  }

  double _calculateAmount(List<Cart> items) {
    return cartService.calculateAmount(items);
  }

  Future<void> process(CartRepository cartRepository) async {
    value = value.copyWith(cartStatus: CartStatus.loading);
    notifyListeners();

    try {
      final isSuccessful = await cartRepository.send(cartItems: value.items);
      if (isSuccessful) {
        value = value.copyWith(
          items: [],
          cartStatus: CartStatus.done,
          amount: 0,
        );
        notifyListeners();
      }
    } catch (ex) {
      value = value.copyWith(cartStatus: CartStatus.error);
      notifyListeners();
    }
  }

  void resetStatus() {
    value = value.copyWith(
      items: [],
      cartStatus: CartStatus.initial,
      amount: 0,
    );
    notifyListeners();
  }
}
