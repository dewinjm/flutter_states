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

  group('CoreAppBar', () {
    testWidgets('should render', (tester) async {
      await tester.pumpApp(
        CoreAppBar(
          title: 'APP NAME',
          badge: Container(),
          onPressed: () {},
        ),
      );

      expect(find.text('APP NAME'), findsOneWidget);
      expect(find.byKey(const Key('_core_app_bar_button')), findsOneWidget);
    });

    testWidgets('should navigate back when pressed leading IconButton',
        (tester) async {
      final mockObserver = MockNavigatorObserver();
      final key = GlobalKey<NavigatorState>();

      await tester.pumpWidget(
        MaterialApp(
          navigatorKey: key,
          home: Scaffold(
            body: ElevatedButton(
              onPressed: () => key.currentState!.push(
                MaterialPageRoute<void>(
                  builder: (_) => CoreAppBar(
                    title: 'APP NAME',
                    badge: Container(),
                    onPressed: () {},
                  ),
                ),
              ),
              child: const Text('button'),
            ),
          ),
          navigatorObservers: [mockObserver],
        ),
      );

      expect(find.byType(ElevatedButton), findsOneWidget);
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('_core_app_bar_back_button')));
      await tester.pump();

      verify(() => mockObserver.didPop(any(), any())).called(1);
    });
  });
}
