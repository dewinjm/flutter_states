import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:state_management/common/common.dart';

part 'cart_state.dart';

class CartProvider with ChangeNotifier {
  CartProvider({required this.cartRepository, required this.cartService});

  final CartRepository cartRepository;
  final CartService cartService;
  CartState state = const CartState.initial();

  void add(Cart cart) {
    final items = cartService.addOrUpdateItem(cart, state.items);
    state = state.copyWith(items: items, amount: _calculateAmount(items));

    notifyListeners();
  }

  void decrease(Cart cart) {
    final items = cartService.decreaseItemCount(cart, state.items);
    state = state.copyWith(items: items, amount: _calculateAmount(items));
    notifyListeners();
  }

  void remove(Cart cart) {
    final items = cartService.removeItem(cart, state.items);
    state = state.copyWith(items: items, amount: _calculateAmount(items));
    notifyListeners();
  }

  double _calculateAmount(List<Cart> items) {
    return cartService.calculateAmount(items);
  }

  Future<void> process() async {
    state = state.copyWith(cartStatus: CartStatus.loading);
    notifyListeners();

    try {
      final isSuccessful = await cartRepository.send(cartItems: state.items);

      if (isSuccessful) {
        state = state.copyWith(
          items: [],
          cartStatus: CartStatus.done,
          amount: 0,
        );
        notifyListeners();
      }
    } catch (ex) {
      state = state.copyWith(cartStatus: CartStatus.error);
      notifyListeners();
    }
  }

  void resetStatus() {
    state = state.copyWith(
      items: [],
      cartStatus: CartStatus.initial,
      amount: 0,
    );
    notifyListeners();
  }
}
