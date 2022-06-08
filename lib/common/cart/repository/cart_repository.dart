import 'package:state_management/common/cart/cart.dart';

abstract class CartRepository {
  Future<bool> send({required List<Cart> cartItems});
}
