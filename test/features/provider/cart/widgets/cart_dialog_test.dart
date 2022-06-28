import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:state_management/common/common.dart';
import 'package:state_management/features/provider/provider.dart';

import '../../../../helpers/helpers.dart';

class _MockCartProvider extends Mock implements CartProvider {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class FakeRoute extends Fake implements Route {}

void main() {
  late _MockCartProvider cartProvider;
  late MockNavigatorObserver mockObserver;

  setUp(() {
    cartProvider = _MockCartProvider();
    mockObserver = MockNavigatorObserver();
  });

  setUpAll(() {
    registerFallbackValue(FakeRoute());
  });

  group('Provider: CartDialog', () {
    Future<void> _pumpView(WidgetTester tester) async {
      await tester.pumpApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<CartProvider>.value(
              value: cartProvider,
            ),
          ],
          child: MaterialApp(
            home: const CartDialog(),
            navigatorObservers: [mockObserver],
          ),
        ),
      );
    }

    testWidgets('should renders', (tester) async {
      when(() => cartProvider.state).thenAnswer(
        (_) => const CartState.initial(),
      );
      await _pumpView(tester);
      expect(find.byType(AlertDialog), findsOneWidget);
    });

    testWidgets(
      'should show progress widget when status is loading',
      (tester) async {
        when(() => cartProvider.state).thenAnswer(
          (_) => const CartState(
            items: [],
            cartStatus: CartStatus.loading,
            amount: 0,
          ),
        );

        await _pumpView(tester);
        expect(find.byType(CoreProgressIndicator), findsOneWidget);
      },
    );

    testWidgets(
      'should show successful widget when status is done',
      (tester) async {
        when(() => cartProvider.state).thenAnswer(
          (_) => const CartState(
            items: [],
            cartStatus: CartStatus.done,
            amount: 0,
          ),
        );

        await _pumpView(tester);
        expect(find.text('Payment success'), findsOneWidget);
      },
    );

    testWidgets(
      'should show Container when status is initial',
      (tester) async {
        when(() => cartProvider.state).thenAnswer(
          (_) => const CartState(
            items: [],
            cartStatus: CartStatus.initial,
            amount: 0,
          ),
        );

        await _pumpView(tester);
        expect(find.byType(Container), findsOneWidget);
      },
    );

    testWidgets(
      'should navigate back when pressed IconButton',
      (tester) async {
        when(() => cartProvider.state).thenAnswer(
          (_) => const CartState(
            items: [],
            cartStatus: CartStatus.done,
            amount: 0,
          ),
        );

        final key = GlobalKey<NavigatorState>();
        await tester.pumpApp(
          MultiProvider(
            providers: [
              ChangeNotifierProvider<CartProvider>.value(
                value: cartProvider,
              ),
            ],
            child: MaterialApp(
              navigatorKey: key,
              home: ElevatedButton(
                onPressed: () => key.currentState!.push(
                  MaterialPageRoute<void>(
                    builder: (_) => const CartDialog(),
                  ),
                ),
                child: const SizedBox(),
              ),
              navigatorObservers: [mockObserver],
            ),
          ),
        );

        expect(find.byType(ElevatedButton), findsOneWidget);
        await tester.tap(find.byType(ElevatedButton));
        await tester.pump();
        await tester.pumpAndSettle();

        expect(find.byType(IconButton), findsOneWidget);
        await tester.tap(find.byType(IconButton));

        verify(() => mockObserver.didPop(any(), any())).called(2);
      },
    );
  });
}
