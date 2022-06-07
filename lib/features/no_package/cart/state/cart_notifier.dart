import 'package:flutter/material.dart';
import 'package:state_management/common/cart/cart.dart';

class CartNotifier extends ValueNotifier<List<Cart>> {
  final double amount = 0;

  final List<Cart> _items = [];
  int _itemCount = 0;

  CartNotifier(super.value);

  List<Cart> get items => _items;

  int get itemCount => _itemCount;

  void add(Cart cart) {
    if (_items.contains(cart)) {
      final index = _items.indexWhere((e) => e.item == cart.item);
      _items[index] = cart.copyWith(count: cart.count + 1);
    } else {
      _items.add(Cart(item: cart.item, count: 1));
    }

    _itemCount += cart.count;
    notifyListeners();
  }

  void remove(Cart cart) {
    if (_items.contains(cart)) {
      _items.remove(cart);
      _itemCount -= cart.count;
    }
    notifyListeners();
  }
}
