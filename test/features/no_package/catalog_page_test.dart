import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:state_management/common/common.dart';
import 'package:state_management/features/no_package/no_package.dart';

import '../../helpers/helpers.dart';

void main() {
  group('Catalog of No Package', () {
    Future<void> _pumpView(WidgetTester tester) async {
      await tester.pumpApp(const CatalogPage());
      await tester.pump(const Duration(seconds: 1));
    }

    testWidgets('should renders', (tester) async {
      await _pumpView(tester);

      expect(find.byType(CatalogState), findsOneWidget);
      expect(find.byType(CatalogView), findsOneWidget);
      expect(find.byType(CoreAppBar), findsOneWidget);
    });

    testWidgets('should open cart page when press app bar IconButton',
        (tester) async {
      await _pumpView(tester);

      await tester.tap(find.byKey(const Key('_core_app_bar_button')));
      await tester.pump();
      await tester.pump();

      expect(find.byType(CartPage), findsOneWidget);
    });

    testWidgets('should add item on cart when press add item button',
        (tester) async {
      await _pumpView(tester);
      const key = Key('_core_catalog_item_1');

      expect(find.byType(CoreCatalogItem), findsWidgets);
      expect(find.byKey(key), findsOneWidget);

      await tester.ensureVisible(find.byKey(key));
      await tester.tap(find.byKey(key));
      await tester.pump();

      final badge = tester.widget<CoreBadge>(find.byType(CoreBadge));
      expect(badge.count, equals(1));
    });
  });
}
