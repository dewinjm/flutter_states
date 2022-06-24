import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:state_management/common/common.dart';
import 'package:state_management/features/no_package/no_package.dart';

class MockCartRepository extends Mock implements CartRepository {}

void main() {
  late MockCartRepository cartRepository;

  setUp(() {
    cartRepository = MockCartRepository();
  });

  group('No package: CartDialog', () {
    late CartProvider cartProvider;

    Future<void> _pumpView(WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CartProvider(
            cartRepository: cartRepository,
            cartNotifier: CartNotifier(),
            child: Builder(
              builder: (BuildContext context) {
                cartProvider =
                    context.findAncestorWidgetOfExactType<CartProvider>()!;

                return CartDialog(cartProvider: cartProvider);
              },
            ),
          ),
        ),
      );
    }

    testWidgets(
      'should renders Container when CartStatus is initial',
      (WidgetTester tester) async {
        await _pumpView(tester);

        cartProvider.cartNotifier.value =
            cartProvider.cartNotifier.value.copyWith(
          cartStatus: CartStatus.initial,
        );
        await tester.pump();

        expect(
          find.descendant(
            of: find.byType(CartDialog),
            matching: find.byType(Container),
          ),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'should renders CartPaymentSuccess when CartStatus is error',
      (WidgetTester tester) async {
        await _pumpView(tester);

        cartProvider.cartNotifier.value =
            cartProvider.cartNotifier.value.copyWith(
          cartStatus: CartStatus.error,
        );
        await tester.pump();

        expect(
          find.descendant(
            of: find.byType(CartDialog),
            matching: find.byType(Container),
          ),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'should renders CoreProgressIndicator'
      'when CartStatus is loading',
      (WidgetTester tester) async {
        await _pumpView(tester);

        cartProvider.cartNotifier.value =
            cartProvider.cartNotifier.value.copyWith(
          cartStatus: CartStatus.loading,
        );
        await tester.pump();

        expect(
          find.descendant(
            of: find.byType(CartDialog),
            matching: find.byType(CoreProgressIndicator),
          ),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'should renders CartPaymentSuccess when CartStatus is done',
      (WidgetTester tester) async {
        await _pumpView(tester);

        cartProvider.cartNotifier.value =
            cartProvider.cartNotifier.value.copyWith(
          cartStatus: CartStatus.done,
        );
        await tester.pump();

        expect(
          find.descendant(
            of: find.byType(CartDialog),
            matching: find.byType(CartPaymentSuccess),
          ),
          findsOneWidget,
        );
      },
    );
  });
}
