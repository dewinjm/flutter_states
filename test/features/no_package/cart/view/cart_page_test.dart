import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:state_management/common/common.dart';
import 'package:state_management/features/no_package/no_package.dart';

import '../../../../helpers/helpers.dart';

class _MockCartRepository extends Mock implements CartRepository {}

void main() {
  late _MockCartRepository mockCartRepository;

  setUp(() {
    mockCartRepository = _MockCartRepository();
  });

  group('CartPage', () {
    const fakeCatalogItem = Catalog(
      id: 1,
      name: 'fake name',
      price: 2.10,
      unit: '1lb',
      imageAsset: 'assets/images/tomatoes.png',
    );

    group('cart without items', () {
      testWidgets('should show CartEmpty widget when is empty', (tester) async {
        await tester.pumpApp(
          CartState(
            cartRepository: mockCartRepository,
            cartNotifier: CartNotifier([]),
            child: const CartPage(),
          ),
        );

        expect(find.text('Cart'), findsOneWidget);
        expect(find.byType(CartView), findsOneWidget);
        expect(find.byType(CartEmpty), findsOneWidget);
      });
    });

    group('cart with items', () {
      late CartState cartState;

      Future<void> _pumpView(WidgetTester tester) async {
        await tester.pumpApp(
          CartState(
            cartRepository: mockCartRepository,
            cartNotifier: CartNotifier([]),
            child: Builder(
              builder: (BuildContext context) {
                cartState = context.findAncestorWidgetOfExactType<CartState>()!;

                cartState.cartNotifier.add(
                  const Cart(item: fakeCatalogItem, count: 1),
                );
                cartState.cartNotifier.add(
                  const Cart(item: fakeCatalogItem, count: 1),
                );
                return const CartPage();
              },
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
          const key = Key('_cart_item_increase');

          expect(find.byKey(key), findsOneWidget);

          await tester.tap(find.byKey(key));

          expect(
            cartState.cartNotifier.amount.toStringAsFixed(2),
            (6.30).toStringAsFixed(2),
          );
        },
      );

      testWidgets(
        'should increase count when press decrease button',
        (tester) async {
          await _pumpView(tester);

          const key = Key('_cart_item_decrease');

          expect(find.byKey(key), findsOneWidget);

          await tester.tap(find.byKey(key));

          expect(cartState.cartNotifier.amount, equals(2.10));
        },
      );

      testWidgets(
        'should remove item when press remove button',
        (tester) async {
          await _pumpView(tester);

          const key = Key('_cart_item_remove');

          expect(find.byKey(key), findsOneWidget);

          await tester.ensureVisible(find.byKey(key));
          await tester.tap(find.byKey(key));

          expect(cartState.cartNotifier.items, isEmpty);
        },
      );
    });

    group('onPaymentPressed', () {
      testWidgets(
        'should successful when payment button pressed',
        (tester) async {
          late CartState cartState;

          await tester.pumpApp(
            CartState(
              cartRepository: mockCartRepository,
              cartNotifier: CartNotifier([]),
              child: Builder(
                builder: (BuildContext context) {
                  cartState =
                      context.findAncestorWidgetOfExactType<CartState>()!;

                  cartState.cartNotifier.add(
                    const Cart(item: fakeCatalogItem, count: 1),
                  );
                  return const CartPage();
                },
              ),
            ),
          );

          when(
            () => mockCartRepository.send(
              cartItems: cartState.cartNotifier.items,
            ),
          ).thenAnswer((_) async => true);

          expect(find.text('PAYOUT'), findsOneWidget);
          expect(find.byType(CartPayment), findsOneWidget);

          const key = Key('_cart_payment_button');
          expect(find.byKey(key), findsOneWidget);

          await tester.tap(find.byKey(key));
          await tester.pump();
          await tester.pumpAndSettle();

          expect(find.byType(CartPaymentSuccess), findsOneWidget);
        },
      );
    });
  });
}
