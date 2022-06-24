import 'package:state_management/common/cart/model/cart.dart';
import 'package:state_management/common/cart/service/service.dart';

class CartServiceImpl implements CartService {
  @override
  List<Cart> addOrUpdateItem(Cart cartItem, List<Cart> currentItems) {
    final List<Cart> items = List.from(currentItems);

    if (items.where((e) => e.item.id == cartItem.item.id).isNotEmpty) {
      final index = items.indexWhere((e) => e.item == cartItem.item);
      final item = items[index];
      final count = item.count + 1;

      items[index] = item.copyWith(
        count: count,
        amount: (item.item.price * count),
      );
    } else {
      items.add(
        Cart(item: cartItem.item, count: 1, amount: cartItem.item.price),
      );
    }

    return items;
  }

  @override
  List<Cart> decreaseItemCount(Cart cartItem, List<Cart> currentItems) {
    final List<Cart> items = List.from(currentItems);
    final index = items.indexWhere((e) => e.item == cartItem.item);
    final item = items[index];
    final count = item.count - 1;

    items[index] = item.copyWith(
      count: count,
      amount: (item.item.price * count),
    );

    return items;
  }

  @override
  List<Cart> removeItem(Cart cartItem, List<Cart> currentItems) {
    final List<Cart> items = List.from(currentItems);
    if (items.contains(cartItem)) items.remove(cartItem);

    return items;
  }

  @override
  double calculateAmount(List<Cart> currentItems) {
    if (currentItems.isEmpty) return 0.0;

    return currentItems
        .map((item) => item.amount ?? 0)
        .reduce((value, current) => value + current);
  }
}
