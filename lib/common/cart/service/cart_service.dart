import 'package:state_management/common/common.dart';

abstract class CartService {
  List<Cart> addOrUpdateItem(Cart cartItem, List<Cart> currentItems);
  List<Cart> decreaseItemCount(Cart cartItem, List<Cart> currentItems);
  List<Cart> removeItem(Cart cartItem, List<Cart> currentItems);
  double calculateAmount(List<Cart> currentItems);
}
