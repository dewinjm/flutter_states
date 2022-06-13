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

  group('CartEmpty', () {
    testWidgets('should render', (tester) async {
      await tester.pumpApp(const CartEmpty());

      expect(find.text('Your cart is empty'), findsOneWidget);
      expect(
        find.text('Please go back and select your favorites items.'),
        findsOneWidget,
      );
    });

    testWidgets('should navigate back when pressed ElevatedButton',
        (tester) async {
      final mockObserver = MockNavigatorObserver();

      await tester.pumpWidget(
        MaterialApp(
          home: const CartEmpty(),
          navigatorObservers: [mockObserver],
        ),
      );
      expect(find.byType(ElevatedButton), findsOneWidget);
      await tester.tap(find.byType(ElevatedButton));

      verify(() => mockObserver.didPop(any(), any())).called(1);
    });
  });
}
