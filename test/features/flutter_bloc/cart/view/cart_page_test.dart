import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:state_management/common/common.dart';
import 'package:state_management/features/flutter_bloc/cart/cart.dart';

class MockCartBloc extends MockBloc<CartEvent, CartState> implements CartBloc {}

void main() {
  late MockCartBloc cartBloc;

  setUp(() {
    cartBloc = MockCartBloc();
  });

  group('Bloc: CartPage', () {
    const mockCart = Cart(
      item: Catalog(
        id: 1,
        name: 'name #1',
        price: 2,
        unit: '1lb',
        imageAsset: 'assets/images/tomatoes.png',
      ),
      count: 2,
      amount: 4.0,
    );

    Future<void> pumpView(WidgetTester tester) async {
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<CartBloc>.value(value: cartBloc),
          ],
          child: const MaterialApp(
            home: CartPage(),
          ),
        ),
      );
    }

    group('should renders', () {
      testWidgets('CartEmpty when cart items is empty',
          (WidgetTester tester) async {
        when(() => cartBloc.state).thenReturn(const CartState.initial());

        await pumpView(tester);

        expect(find.text('Cart'), findsOneWidget);
        expect(find.byType(CartEmpty), findsOneWidget);
      });

      testWidgets('CartContainer with list of CartItem when cart has items',
          (WidgetTester tester) async {
        when(() => cartBloc.state).thenReturn(
          const CartState(
            items: [mockCart],
            amount: 2,
            cartStatus: CartStatus.initial,
          ),
        );

        await pumpView(tester);

        expect(
          find.descendant(
            of: find.byType(CartContainer),
            matching: find.byType(CartItem),
          ),
          findsOneWidget,
        );
      });
    });

    group('CartItemOption behavior', () {
      const mockCartState = CartState(
        items: [mockCart],
        amount: 4,
        cartStatus: CartStatus.initial,
      );

      setUp(() {
        when(() => cartBloc.state).thenReturn(mockCartState);
      });

      testWidgets(
        'should increase total when press increase button',
        (WidgetTester tester) async {
          await pumpView(tester);

          expect(find.byType(CartItem), findsOneWidget);

          const key = Key('_cart_item_increase');
          expect(find.byKey(key), findsOneWidget);
          await tester.tap(find.byKey(key));
          await tester.pumpAndSettle();

          expect(find.text('Total: \$4.00'), findsOneWidget);
          verify(() => cartBloc.add(const CartItemAdded(mockCart))).called(1);
        },
      );

      testWidgets(
        'should decrease total when press decrease button',
        (WidgetTester tester) async {
          when(() => cartBloc.state).thenReturn(
            mockCartState.copyWith(amount: 2.0),
          );
          await pumpView(tester);

          const key = Key('_cart_item_decrease');
          expect(find.byKey(key), findsOneWidget);
          await tester.tap(find.byKey(key));
          await tester.pumpAndSettle();

          expect(find.text('Total: \$2.00'), findsOneWidget);
          verify(
            () => cartBloc.add(const CartItemCountDecreased(mockCart)),
          ).called(1);
        },
      );

      testWidgets(
        'should remove item when press remove button',
        (WidgetTester tester) async {
          await pumpView(tester);

          const key = Key('_cart_item_remove');
          expect(find.byKey(key), findsOneWidget);
          await tester.tap(find.byKey(key));
          await tester.pumpAndSettle();

          verify(() => cartBloc.add(const CartItemRemoved(mockCart))).called(1);
        },
      );
    });

    group('CartContainer onPaymentPressed', () {
      testWidgets(
        'should CartDialog when save is succefull',
        (WidgetTester tester) async {
          when(() => cartBloc.state).thenReturn(
            const CartState(
              items: [mockCart],
              amount: 2,
              cartStatus: CartStatus.done,
            ),
          );

          await pumpView(tester);

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

          verify(() => cartBloc.add(CartProcessed())).called(1);
        },
      );
    });
  });
}
