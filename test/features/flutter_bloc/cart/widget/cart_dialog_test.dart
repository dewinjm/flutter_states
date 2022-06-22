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

  group('Bloc: CartDialog', () {
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

    Future<void> _pumpView(WidgetTester tester) async {
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<CartBloc>.value(value: cartBloc),
          ],
          child: const MaterialApp(
            home: CartDialog(),
          ),
        ),
      );
    }

    testWidgets('should renders Container when CartStatus is initial',
        (WidgetTester tester) async {
      when(() => cartBloc.state).thenReturn(
        const CartState(
          items: [mockCart],
          amount: 2,
          cartStatus: CartStatus.initial,
        ),
      );

      await _pumpView(tester);
      expect(
        find.descendant(
          of: find.byType(CartDialog),
          matching: find.byType(Container),
        ),
        findsOneWidget,
      );
    });

    testWidgets(
      'should renders CartPaymentSuccess when CartStatus is error',
      (WidgetTester tester) async {
        when(() => cartBloc.state).thenReturn(
          const CartState(
            items: [mockCart],
            amount: 2,
            cartStatus: CartStatus.error,
          ),
        );

        await _pumpView(tester);
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
        when(() => cartBloc.state).thenReturn(
          const CartState(
            items: [mockCart],
            amount: 2,
            cartStatus: CartStatus.loading,
          ),
        );

        await _pumpView(tester);
        expect(find.byType(CoreProgressIndicator), findsOneWidget);
      },
    );

    testWidgets(
      'should renders CartPaymentSuccess when CartStatus is done',
      (WidgetTester tester) async {
        when(() => cartBloc.state).thenReturn(
          const CartState(
            items: [mockCart],
            amount: 2,
            cartStatus: CartStatus.done,
          ),
        );

        await _pumpView(tester);
        expect(find.byType(CartPaymentSuccess), findsOneWidget);
      },
    );
  });
}
