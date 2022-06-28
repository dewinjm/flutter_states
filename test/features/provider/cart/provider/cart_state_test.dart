// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:state_management/common/common.dart';
import 'package:state_management/features/provider/cart/provider/provider.dart';

void main() {
  group('Bloc: CartState', () {
    test('supports value comparison', () {
      expect(CartState.initial(), CartState.initial());
      expect(
        CartState(items: const [], amount: 10, cartStatus: CartStatus.done),
        CartState(items: const [], amount: 10, cartStatus: CartStatus.done),
      );
    });

    test('supports copyWith', () {
      final state = CartState.initial();

      final cartItems = [
        Cart(
          item: Catalog(
            id: 1,
            name: 'name',
            price: 2,
            unit: '1lb',
            imageAsset: 'assets',
          ),
          count: 2,
        ),
      ];

      expect(
        state.copyWith(items: cartItems),
        CartState(items: cartItems, amount: 0, cartStatus: CartStatus.initial),
      );
    });
  });
}
