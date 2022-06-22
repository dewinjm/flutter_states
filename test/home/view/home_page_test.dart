import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:state_management/features/no_package/catalog/catalog.dart'
    as no_package;
import 'package:state_management/features/provider/catalog/catalog.dart'
    as provider;
import 'package:state_management/features/riverpod/catalog/catalog.dart'
    as riverpod;
import 'package:state_management/features/flutter_bloc/catalog/catalog.dart'
    as bloc;
import 'package:state_management/home/home.dart';

import '../../helpers/helpers.dart';

void main() {
  Future<void> _pumpView(WidgetTester tester) async {
    await tester.pumpApp(const HomePage());
  }

  group('HomePage', () {
    testWidgets('should renders', (tester) async {
      await _pumpView(tester);

      expect(
        find.text('Flutter State Managament'),
        findsOneWidget,
      );

      expect(
        find.text('Shopping cart example with state management'),
        findsOneWidget,
      );

      expect(find.byType(MenuOption), findsWidgets);
      expect(find.byType(Github), findsOneWidget);
    });

    testWidgets('should open catalog page when press menu "No Package"',
        (tester) async {
      await _pumpView(tester);

      await tester.tap(find.byKey(const Key('_menu_0')));
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      expect(find.byType(no_package.CatalogPage), findsOneWidget);
    });

    testWidgets('should open catalog page when press menu "Provider"',
        (tester) async {
      await _pumpView(tester);

      await tester.tap(find.byKey(const Key('_menu_1')));
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      expect(find.byType(provider.CatalogPage), findsOneWidget);
    });

    testWidgets('should open catalog page when press menu "Riverpod"',
        (tester) async {
      await _pumpView(tester);

      await tester.tap(find.byKey(const Key('_menu_2')));
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      expect(find.byType(riverpod.CatalogPage), findsOneWidget);
    });

    testWidgets('should open catalog page when press menu "Bloc"',
        (tester) async {
      await _pumpView(tester);

      await tester.tap(find.byKey(const Key('_menu_3')));
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      expect(find.byType(bloc.CatalogPage), findsOneWidget);
    });
  });
}
