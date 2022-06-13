import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:state_management/common/common.dart';

import '../../../helpers/helpers.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class FakeRoute extends Fake implements Route {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    registerFallbackValue(FakeRoute());
  });

  group('CartPaymentSuccess', () {
    testWidgets('should renders', (tester) async {
      await tester.pumpApp(const CartPaymentSuccess());

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Payment success'), findsOneWidget);
    });
  });

  testWidgets('should navigate back when pressed ElevatedButton',
      (tester) async {
    final mockObserver = MockNavigatorObserver();

    await tester.pumpWidget(
      MaterialApp(
        home: const CartPaymentSuccess(),
        navigatorObservers: [mockObserver],
      ),
    );
    expect(find.byType(IconButton), findsOneWidget);
    await tester.tap(find.byType(IconButton));

    verify(() => mockObserver.didPop(any(), any())).called(1);
  });
}
