import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:state_management/common/common.dart';
import 'package:state_management/features/riverpod/riverpod.dart';

class MockCartRepository extends Mock implements CartRepository {}

void main() {
  late MockCartRepository cartRepository;

  const fakeCart = Cart(
    item: Catalog(
      id: 1,
      name: 'fake_name',
      price: 2,
      unit: '1lb',
      imageAsset: 'assets/images/tomatoes.png',
    ),
    count: 1,
    amount: 0,
  );

  setUp(() {
    cartRepository = MockCartRepository();
  });

  group('Riverpod: CartPage', () {
    testWidgets('should render', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            cartRepositoryProvider.overrideWithValue(cartRepository),
          ],
          child: const MaterialApp(
            home: CartPage(),
          ),
        ),
      );

      expect(find.text('Cart'), findsOneWidget);
      expect(find.byType(CartView), findsOneWidget);
      expect(find.byType(CartEmpty), findsOneWidget);
    });

    testWidgets(
      'should increase total when press increase button',
      (tester) async {
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              cartRepositoryProvider.overrideWithValue(cartRepository),
            ],
            child: MaterialApp(
              home: Consumer(builder: (context, ref, child) {
                final notifier = ref.read(cartStateNotifierProvider.notifier);
                notifier.add(fakeCart);

                return const CartPage();
              }),
            ),
          ),
        );

        expect(find.byType(CartItem), findsOneWidget);

        const key = Key('_cart_item_increase');
        expect(find.byKey(key), findsOneWidget);
        await tester.tap(find.byKey(key));
        await tester.pumpAndSettle();

        expect(find.text('Total: \$4.00'), findsOneWidget);
      },
    );

    testWidgets(
      'should decrease total when press decrease button',
      (tester) async {
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              cartRepositoryProvider.overrideWithValue(cartRepository),
            ],
            child: MaterialApp(
              home: Consumer(builder: (context, ref, child) {
                final notifier = ref.read(cartStateNotifierProvider.notifier);
                notifier.add(fakeCart);
                notifier.add(fakeCart);

                return const CartPage();
              }),
            ),
          ),
        );

        const key = Key('_cart_item_decrease');
        expect(find.byKey(key), findsOneWidget);
        await tester.tap(find.byKey(key));
        await tester.pumpAndSettle();

        expect(find.text('Total: \$2.00'), findsOneWidget);
      },
    );

    testWidgets(
      'should remove item when press remove button',
      (tester) async {
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              cartRepositoryProvider.overrideWithValue(cartRepository),
            ],
            child: MaterialApp(
              home: Consumer(builder: (context, ref, child) {
                final notifier = ref.read(cartStateNotifierProvider.notifier);
                notifier.add(fakeCart);
                notifier.add(fakeCart);

                return const CartPage();
              }),
            ),
          ),
        );

        const key = Key('_cart_item_remove');
        expect(find.byKey(key), findsOneWidget);
        await tester.tap(find.byKey(key));
        await tester.pumpAndSettle();

        expect(find.byType(CartEmpty), findsOneWidget);
      },
    );

    testWidgets(
      'should successful when payment button pressed',
      (tester) async {
        late CartState cartState;
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              cartRepositoryProvider.overrideWithValue(cartRepository),
            ],
            child: MaterialApp(
              home: Consumer(builder: (context, ref, child) {
                final notifier = ref.read(cartStateNotifierProvider.notifier);
                notifier.add(fakeCart);

                cartState = ref.read(cartStateNotifierProvider);

                return const CartPage();
              }),
            ),
          ),
        );

        when(
          () => cartRepository.send(cartItems: cartState.items),
        ).thenAnswer((_) async {
          await Future<void>.delayed(const Duration(seconds: 1));
          return true;
        });

        expect(find.text('PAYOUT'), findsOneWidget);
        expect(find.byType(CartPayment), findsOneWidget);

        const key = Key('_cart_payment_button');
        expect(find.byKey(key), findsOneWidget);
        await tester.tap(find.byKey(key));
        await tester.pump();
        await tester.pumpAndSettle();

        expect(find.byType(CartDialog), findsOneWidget);
        expect(find.byType(CartPaymentSuccess), findsOneWidget);

        await tester.tap(
          find.byKey(const Key('_cart_payment_success_close_button')),
        );
        await tester.pump();
        await tester.pumpAndSettle();

        expect(
          cartState,
          equals(
            CartState(items: cartState.items, cartStatus: CartStatus.initial),
          ),
        );
      },
    );
  });
}
