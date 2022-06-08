import 'package:flutter_test/flutter_test.dart';
import 'package:state_management/common/cart/repository/repository.dart';
import 'package:state_management/common/common.dart';

void main() {
  group('CartRepository', () {
    late CartRepository cartRepository;

    setUp(() {
      cartRepository = CartRepositoryImpl();
    });

    group('Send', () {
      const fakeCartItems = [
        Cart(
          item: Catalog(
              id: 1,
              name: 'Item #1',
              unit: '1lb',
              price: 5,
              imageAsset: 'fake_path'),
          count: 10,
        ),
        Cart(
          item: Catalog(
              id: 2,
              name: 'Item  #2',
              unit: '1lb',
              price: 5,
              imageAsset: 'fake_path'),
          count: 10,
        ),
      ];

      test('Should return true when send data is successful', () async {
        final result = await cartRepository.send(cartItems: fakeCartItems);
        expect(result, isTrue);
      });

      test('Should return false when cartItems value is empty', () async {
        final resul = await cartRepository.send(cartItems: []);
        expect(resul, isFalse);
      });
    });
  });
}
