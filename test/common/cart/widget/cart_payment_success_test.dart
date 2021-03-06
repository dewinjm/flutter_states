import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:state_management/common/common.dart';

import '../../../helpers/helpers.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class FakeRoute extends Fake implements Route {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeRoute());
  });

  group('CartPaymentSuccess', () {
    testWidgets('should renders', (tester) async {
      await tester.pumpApp(
        const Scaffold(
          body: CartPaymentSuccess(),
        ),
      );

      expect(find.text('Payment success'), findsOneWidget);
      expect(find.text('Thanks your!'), findsOneWidget);
    });

    testWidgets('should navigate back when pressed ElevatedButton',
        (tester) async {
      final mockObserver = MockNavigatorObserver();
      final key = GlobalKey<NavigatorState>();

      await tester.pumpApp(
        MaterialApp(
          navigatorKey: key,
          home: ElevatedButton(
            onPressed: () => key.currentState!.push(
              MaterialPageRoute<void>(
                builder: (_) => const Scaffold(body: CartPaymentSuccess()),
              ),
            ),
            child: const SizedBox(),
          ),
          navigatorObservers: [mockObserver],
        ),
      );

      expect(find.byType(ElevatedButton), findsOneWidget);
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('_cart_payment_success_close_button')),
          findsOneWidget);

      await tester.tap(
        find.byKey(const Key('_cart_payment_success_close_button')),
      );
      await tester.pump();
      await tester.pumpAndSettle();

      verify(() => mockObserver.didPop(any(), any())).called(2);
    });
  });
}
