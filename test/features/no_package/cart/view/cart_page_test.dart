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

  group('No Package: CartPage', () {
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
          CartProvider(
            cartRepository: mockCartRepository,
            cartNotifier: CartNotifier(),
            child: const CartPage(),
          ),
        );

        expect(find.text('Cart'), findsOneWidget);
        expect(find.byType(CartView), findsOneWidget);
        expect(find.byType(CartEmpty), findsOneWidget);
      });
    });

    group('cart with items', () {
      late CartProvider cartProvider;

      Future<void> _pumpView(WidgetTester tester) async {
        await tester.pumpApp(
          CartProvider(
            cartRepository: mockCartRepository,
            cartNotifier: CartNotifier(),
            child: Builder(
              builder: (BuildContext context) {
                cartProvider =
                    context.findAncestorWidgetOfExactType<CartProvider>()!;

                cartProvider.cartNotifier.add(
                  const Cart(item: fakeCatalogItem, count: 1),
                );
                cartProvider.cartNotifier.add(
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
            cartProvider.cartNotifier.value.amount.toStringAsFixed(2),
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

          expect(cartProvider.cartNotifier.value.amount, equals(2.10));
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

          expect(cartProvider.cartNotifier.value.items, isEmpty);
        },
      );
    });

    group('onPaymentPressed', () {
      late CartProvider cartProvider;

      Future<void> _pumpView(WidgetTester tester) async {
        await tester.pumpApp(
          CartProvider(
            cartRepository: mockCartRepository,
            cartNotifier: CartNotifier(),
            child: Builder(
              builder: (BuildContext context) {
                cartProvider =
                    context.findAncestorWidgetOfExactType<CartProvider>()!;

                cartProvider.cartNotifier.add(
                  const Cart(item: fakeCatalogItem, count: 1),
                );
                return const CartPage();
              },
            ),
          ),
        );
      }

      testWidgets(
        'should show dialog when payment cart process is successfully',
        (tester) async {
          await _pumpView(tester);
          final items = cartProvider.cartNotifier.value.items;

          when(() => mockCartRepository.send(cartItems: items))
              .thenAnswer((_) async => true);

          expect(find.text('PAYOUT'), findsOneWidget);
          expect(find.byType(CartPayment), findsOneWidget);

          const key = Key('_cart_payment_button');
          expect(find.byKey(key), findsOneWidget);

          await tester.tap(find.byKey(key));
          await tester.pump();
          await tester.pumpAndSettle();

          expect(find.byType(CartDialog), findsOneWidget);

          await tester.tap(
            find.byKey(const Key('_cart_payment_success_close_button')),
          );
          await tester.pump();
          await tester.pumpAndSettle();

          verify(() => mockCartRepository.send(cartItems: items)).called(1);
        },
      );

      testWidgets(
        'should return status error when cart process throws an error',
        (tester) async {
          await _pumpView(tester);

          final items = cartProvider.cartNotifier.value.items;
          when(() => mockCartRepository.send(cartItems: items)).thenThrow(
            Exception(),
          );

          await tester.tap(find.byKey(const Key('_cart_payment_button')));
          await tester.pump();
          await tester.pumpAndSettle();

          expect(
            cartProvider.cartNotifier.value.cartStatus,
            equals(CartStatus.error),
          );
        },
      );
    });
  });
}
