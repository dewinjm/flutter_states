import 'package:flutter/material.dart';
import 'package:state_management/common/cart/cart.dart';

class CartNotifier extends ValueNotifier<List<Cart>> {
  CartNotifier(super.value);

  final List<Cart> _items = [];
  double _amount = 0;

  List<Cart> get items => _items;
  double get amount => _amount;

  void add(Cart cart) {
    if (_items.where((e) => e.item.id == cart.item.id).isNotEmpty) {
      final index = _items.indexWhere((e) => e.item == cart.item);
      final item = _items[index];
      final count = item.count + 1;

      _items[index] = item.copyWith(
        count: count,
        amount: (item.item.price * count),
      );
    } else {
      _items.add(Cart(item: cart.item, count: 1, amount: cart.item.price));
    }

    _calculateAmount();
    notifyListeners();
  }

  void decrease(Cart cart) {
    final index = _items.indexWhere((e) => e.item == cart.item);
    final item = _items[index];
    final count = item.count - 1;

    _items[index] = item.copyWith(
      count: count,
      amount: (item.item.price * count),
    );

    _calculateAmount();
    notifyListeners();
  }

  void remove(Cart cart) {
    if (_items.contains(cart)) {
      _items.remove(cart);
    }

    _calculateAmount();
    notifyListeners();
  }

  void _calculateAmount() {
    if (_items.isEmpty) {
      _amount = 0;
      return;
    }

    _amount = _items
        .map((item) => item.amount ?? 0)
        .reduce((value, current) => value + current);
  }

  void clear() {
    _items.clear();
    _amount = 0;
    notifyListeners();
  }
}
