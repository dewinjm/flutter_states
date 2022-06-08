import 'package:state_management/common/cart/model/cart.dart';
import 'package:state_management/common/cart/repository/repository.dart';

class CartRepositoryImpl implements CartRepository {
  @override
  Future<bool> send({required List<Cart> cartItems}) async {
    if (cartItems.isEmpty) return false;

    return Future.delayed(
      const Duration(milliseconds: 800),
      () => true,
    );
  }
}
