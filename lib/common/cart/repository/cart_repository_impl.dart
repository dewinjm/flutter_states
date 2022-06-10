import 'package:state_management/common/common.dart';

class CartRepositoryImpl implements CartRepository {
  @override
  Future<bool> send({required List<Cart> cartItems}) async {
    if (cartItems.isEmpty) return false;

    return Future.delayed(
      const Duration(seconds: Values.timeProcess),
      () => true,
    );
  }
}
