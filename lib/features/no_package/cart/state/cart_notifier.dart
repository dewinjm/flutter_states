part of 'cart_provider.dart';

class CartNotifier extends ValueNotifier<CartState> {
  CartNotifier() : super(const CartState.initial());

  void add(Cart cart) {
    final List<Cart> items = List.from(value.items);

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

    value = value.copyWith(items: items, amount: _calculateAmount(items));
    notifyListeners();
  }

  void decrease(Cart cart) {
    final List<Cart> items = List.from(value.items);
    final index = items.indexWhere((e) => e.item == cart.item);
    final item = items[index];
    final count = item.count - 1;

    items[index] = item.copyWith(
      count: count,
      amount: (item.item.price * count),
    );

    value = value.copyWith(items: items, amount: _calculateAmount(items));
    notifyListeners();
  }

  void remove(Cart cart) {
    final List<Cart> items = List.from(value.items);
    if (items.contains(cart)) {
      items.remove(cart);
    }

    value = value.copyWith(items: items, amount: _calculateAmount(items));
    notifyListeners();
  }

  double _calculateAmount(List<Cart> items) {
    if (items.isEmpty) return 0.0;

    return items
        .map((item) => item.amount ?? 0)
        .reduce((value, current) => value + current);
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
