// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:state_management/common/common.dart';
import 'package:state_management/features/flutter_bloc/flutter_bloc.dart';

void main() {
  group('Bloc: CartEvent', () {
    const fakeCart = Cart(
        item: Catalog(
          id: 1,
          name: 'name',
          price: 1,
          unit: '1kg',
          imageAsset: 'imageAsset',
        ),
        count: 1);

    group('CartItemAdded', () {
      test('supports value comparison', () {
        expect(CartItemAdded(fakeCart), CartItemAdded(fakeCart));
      });
    });

    group('CartItemCountDecreased', () {
      test('supports value comparison', () {
        expect(
          CartItemCountDecreased(fakeCart),
          CartItemCountDecreased(fakeCart),
        );
      });
    });

    group('CartItemRemoved', () {
      test('supports value comparison', () {
        expect(
          CartItemRemoved(fakeCart),
          CartItemRemoved(fakeCart),
        );
      });
    });

    group('CartProcessed', () {
      test('supports value comparison', () {
        expect(CartProcessed(), CartProcessed());
      });
    });

    group('CartResetStatus', () {
      test('supports value comparison', () {
        expect(CartResetStatus(), CartResetStatus());
      });
    });
  });
}
