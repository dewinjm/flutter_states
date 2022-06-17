import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:state_management/features/no_package/no_package.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class FakeRoute extends Fake implements Route {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeRoute());
  });

  group('No Package: MainView', () {
    testWidgets('should render', (tester) async {
      await tester.pumpWidget(const MainView());
      await tester.pump(const Duration(seconds: 1));

      expect(find.byType(CatalogState), findsOneWidget);
      expect(find.byType(CatalogPage), findsOneWidget);

      await tester.tap(find.byKey(const Key('_core_app_bar_button')));
      await tester.pump();
      await tester.pump();

      expect(find.byType(CartPage), findsOneWidget);
    });
  });
}
