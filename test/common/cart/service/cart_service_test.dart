import 'package:flutter_test/flutter_test.dart';
import 'package:state_management/common/common.dart';

void main() {
  group('CartService', () {
    late CartService cartService;

    setUp(() {
      cartService = CartServiceImpl();
    });

    group('addOrUpdateItem', () {
      const mockCart = Cart(
        count: 1,
        amount: 2,
        item: Catalog(
          id: 1,
          name: 'name',
          price: 2,
          unit: 'unit',
          imageAsset: 'imageAsset',
        ),
      );

      test('should add new item', () {
        List<Cart> items = cartService.addOrUpdateItem(mockCart, []);

        expect(items.isNotEmpty, isTrue);
        expect(items.length, equals(1));
      });

      test('should update item count when added item exists', () {
        List<Cart> items = cartService.addOrUpdateItem(mockCart, [mockCart]);

        expect(items.isNotEmpty, isTrue);
        expect(items.length, equals(1));
        expect(items[0].amount, equals(4));
      });
    });

    group('decreaseItemCount', () {
      const mockCart = Cart(
        count: 1,
        amount: 2,
        item: Catalog(
          id: 1,
          name: 'name #1',
          price: 2,
          unit: 'unit',
          imageAsset: 'imageAsset',
        ),
      );

      const mockList = [
        Cart(
          count: 4,
          amount: 8,
          item: Catalog(
            id: 1,
            name: 'name #1',
            price: 2,
            unit: 'unit',
            imageAsset: 'imageAsset',
          ),
        ),
        Cart(
          count: 1,
          amount: 3,
          item: Catalog(
            id: 2,
            name: 'name #2',
            price: 3,
            unit: 'unit',
            imageAsset: 'imageAsset',
          ),
        ),
      ];

      test('should reduce item count', () {
        List<Cart> items = cartService.decreaseItemCount(mockCart, mockList);

        expect(items.length, equals(2));
        expect(items[0].amount, equals(6));
        expect(items[1].amount, equals(3));
      });
    });

    group('removeItem', () {
      const mockList = [
        Cart(
          count: 4,
          amount: 8,
          item: Catalog(
            id: 1,
            name: 'name #1',
            price: 2,
            unit: 'unit',
            imageAsset: 'imageAsset',
          ),
        ),
      ];
      test('should remove item', () {
        List<Cart> items = cartService.removeItem(mockList[0], mockList);
        expect(items.isEmpty, isTrue);
      });
    });

    group('calculateAmount', () {
      const mockList = [
        Cart(
          count: 2,
          amount: 3,
          item: Catalog(
            id: 1,
            name: 'name #1',
            price: 1.5,
            unit: 'unit',
            imageAsset: 'imageAsset',
          ),
        ),
        Cart(
          count: 3,
          amount: 11.76,
          item: Catalog(
            id: 2,
            name: 'name #2',
            price: 3.92,
            unit: 'unit',
            imageAsset: 'imageAsset',
          ),
        ),
      ];

      test('should return the sum of the amount of the elements', () {
        final amount = cartService.calculateAmount(mockList);
        expect(amount, equals(14.76));
      });
    });
  });
}
