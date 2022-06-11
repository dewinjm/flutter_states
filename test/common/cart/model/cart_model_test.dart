import 'package:flutter_test/flutter_test.dart';
import 'package:state_management/common/common.dart';

void main() {
  group('Cart Model', () {
    const fakeCart = Cart(
      item: Catalog(
          id: 1,
          name: 'Fake Name',
          unit: '1lb',
          price: 5,
          imageAsset: 'fake_path'),
      count: 10,
      amount: 5,
    );

    test('should return correct toString', () {
      expect(
        fakeCart.toString(),
        'Cart(Catalog(1, Fake Name, 5.0, 1lb, fake_path), 10, 5.0)',
      );
    });

    test('should return true when instance is the same', () {
      const instance = Cart(
        item: Catalog(
          id: 1,
          name: 'Fake Name',
          unit: '1lb',
          price: 5,
          imageAsset: 'fake_path',
        ),
        count: 10,
        amount: 5,
      );
      expect(instance == fakeCart, true);
    });

    test('should return correct model when use copyWith', () {
      expect(
        fakeCart.copyWith(count: 2).toString(),
        'Cart(Catalog(1, Fake Name, 5.0, 1lb, fake_path), 2, 5.0)',
      );

      const model = Catalog(
        id: 2,
        name: 'Name',
        unit: '2lb',
        price: 2.1,
        imageAsset: 'fake_path',
      );

      expect(
        fakeCart.copyWith(item: model).toString(),
        'Cart(Catalog(2, Name, 2.1, 2lb, fake_path), 10, 5.0)',
      );
      expect(
        fakeCart.copyWith(amount: 21).toString(),
        'Cart(Catalog(1, Fake Name, 5.0, 1lb, fake_path), 10, 21.0)',
      );
    });
  });
}
