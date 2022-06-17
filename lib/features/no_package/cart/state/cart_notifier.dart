import 'package:flutter/material.dart';
import 'package:state_management/common/cart/cart.dart';

enum CartStatus {
  initial,
  loading,
  done,
}

class CartNotifier extends ValueNotifier<List<Cart>> {
  CartNotifier(super.value);

  double _amount = 0;
  double get amount => _amount;

  CartStatus status = CartStatus.initial;

  void add(Cart cart) {
    if (value.where((e) => e.item.id == cart.item.id).isNotEmpty) {
      final index = value.indexWhere((e) => e.item == cart.item);
      final item = value[index];
      final count = item.count + 1;

      value[index] = item.copyWith(
        count: count,
        amount: (item.item.price * count),
      );
    } else {
      value.add(Cart(item: cart.item, count: 1, amount: cart.item.price));
    }

    _calculateAmount();
    notifyListeners();
  }

  void decrease(Cart cart) {
    final index = value.indexWhere((e) => e.item == cart.item);
    final item = value[index];
    final count = item.count - 1;

    value[index] = item.copyWith(
      count: count,
      amount: (item.item.price * count),
    );

    _calculateAmount();
    notifyListeners();
  }

  void remove(Cart cart) {
    if (value.contains(cart)) {
      value.remove(cart);
    }

    _calculateAmount();
    notifyListeners();
  }

  void _calculateAmount() {
    if (value.isEmpty) {
      _amount = 0;
      return;
    }

    _amount = value
        .map((item) => item.amount ?? 0)
        .reduce((value, current) => value + current);
  }

  void clear() {
    value.clear();
    _amount = 0;
    notifyListeners();
  }

  void setStatus(CartStatus status) {
    this.status = status;
    notifyListeners();
  }

  void resetStatus() {
    status == CartStatus.initial;
    notifyListeners();
  }
}
