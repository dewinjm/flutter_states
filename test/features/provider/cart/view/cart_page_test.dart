import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:state_management/common/common.dart';
import 'package:state_management/features/provider/provider.dart';

import '../../../../helpers/helpers.dart';

class _MockCartProvider extends Mock implements CartProvider {}

void main() {
  late _MockCartProvider cartProvider;

  const fakeCatalog = [
    Catalog(
      id: 1,
      name: 'fake name',
      price: 2.10,
      unit: '1lb',
      imageAsset: 'assets/images/tomatoes.png',
    ),
  ];

  group('Provider: CartPage', () {
    setUp(() {
      cartProvider = _MockCartProvider();
    });

    group('cart without items', () {
      Future<void> _pumpView(WidgetTester tester) async {
        await tester.pumpApp(
          MultiProvider(
            providers: [
              ChangeNotifierProvider<CartProvider>.value(
                value: cartProvider,
                child: const CatalogPage(),
              ),
            ],
            child: const CartPage(),
          ),
        );
      }

      testWidgets('should show CartEmpty widget when is empty', (tester) async {
        when((() => cartProvider.items)).thenReturn([]);
        await _pumpView(tester);

        expect(find.text('Cart'), findsOneWidget);
        expect(find.byType(CartView), findsOneWidget);
        expect(find.byType(CartEmpty), findsOneWidget);
      });
    });

    group('cart with items', () {
      final fakeCart = Cart(item: fakeCatalog[0], count: 1, amount: 2.10);

      Future<void> _pumpView(WidgetTester tester) async {
        final items = [Cart(item: fakeCatalog[0], count: 2, amount: 4.20)];

        when((() => cartProvider.items)).thenReturn(items);
        when((() => cartProvider.amount)).thenReturn(4.20);

        await tester.pumpApp(
          MultiProvider(
            providers: [
              ChangeNotifierProvider<CartProvider>.value(
                value: cartProvider,
              ),
            ],
            child: const MaterialApp(
              home: CartPage(),
            ),
          ),
        );
      }

      testWidgets(
        'should show list of CartItem widget when has items',
        (tester) async {
          await _pumpView(tester);

          expect(find.byType(CartContainer), findsOneWidget);
          expect(find.byType(CartItem), findsWidgets);
        },
      );

      testWidgets(
        'should increase count when press increase button',
        (tester) async {
          await _pumpView(tester);

          when((() => cartProvider.add(fakeCart))).thenAnswer((_) {});

          const key = Key('_cart_item_increase');
          expect(find.byKey(key), findsOneWidget);
          await tester.tap(find.byKey(key));

          expect(
            cartProvider.amount.toStringAsFixed(2),
            (4.20).toStringAsFixed(2),
          );
        },
      );

      testWidgets(
        'should increase count when press decrease button',
        (tester) async {
          await _pumpView(tester);

          when((() => cartProvider.decrease(fakeCart))).thenAnswer((_) {});
          when((() => cartProvider.amount)).thenReturn(2.10);

          const key = Key('_cart_item_decrease');
          expect(find.byKey(key), findsOneWidget);
          await tester.tap(find.byKey(key));

          expect(
            cartProvider.amount.toStringAsFixed(2),
            (2.10).toStringAsFixed(2),
          );
        },
      );

      testWidgets(
        'should remove item when press remove button',
        (tester) async {
          await _pumpView(tester);

          when((() => cartProvider.remove(fakeCart))).thenAnswer((_) {});
          when((() => cartProvider.items)).thenAnswer((_) => []);

          const key = Key('_cart_item_remove');
          expect(find.byKey(key), findsOneWidget);

          await tester.ensureVisible(find.byKey(key));
          await tester.tap(find.byKey(key));

          expect(cartProvider.items, isEmpty);
        },
      );

      testWidgets(
        'should successful when payment button pressed',
        (tester) async {
          await _pumpView(tester);

          when(() => cartProvider.process()).thenAnswer((_) async => true);
          when(() => cartProvider.resetStatus()).thenAnswer((_) {});
          when(() => cartProvider.status).thenAnswer((_) => CartStatus.done);

          expect(find.text('PAYOUT'), findsOneWidget);
          expect(find.byType(CartPayment), findsOneWidget);

          const key = Key('_cart_payment_button');
          expect(find.byKey(key), findsOneWidget);

          await tester.tap(find.byKey(key));
          await tester.pump();
          await tester.pumpAndSettle();

          expect(find.byType(CartDialog), findsOneWidget);
        },
      );
    });
  });
}
