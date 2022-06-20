import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:state_management/common/common.dart';
import 'package:state_management/features/riverpod/riverpod.dart';

class MockCatalogRepository extends Mock implements CatalogRepository {}

void main() {
  late MockCatalogRepository catalogRepository;

  setUp(() {
    catalogRepository = MockCatalogRepository();
  });

  group('Riverpod: CatalogPage', () {
    const fakeCatalog = [
      Catalog(
        id: 1,
        name: 'fake_name',
        price: 10,
        unit: '1lb',
        imageAsset: 'assets/images/tomatoes.png',
      ),
    ];

    Future<void> _pumpView(WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            catalogRepositoryProvider.overrideWithValue(catalogRepository),
          ],
          child: const MaterialApp(
            home: CatalogPage(),
          ),
        ),
      );
    }

    testWidgets('should render', (tester) async {
      when(() => catalogRepository.fetch()).thenAnswer(
        (_) async => fakeCatalog,
      );

      await _pumpView(tester);

      await tester.pump(const Duration(seconds: 1));
      expect(find.byType(CatalogView), findsOneWidget);
    });

    testWidgets('should render text error when has loading error',
        (tester) async {
      when(() => catalogRepository.fetch()).thenThrow(Exception());
      await _pumpView(tester);

      await tester.pump(const Duration(seconds: 1));
      expect(find.text('Error loading catalog'), findsOneWidget);
    });

    testWidgets('should open cart page when press app bar IconButton',
        (tester) async {
      when(() => catalogRepository.fetch()).thenAnswer(
        (_) async => fakeCatalog,
      );
      await _pumpView(tester);

      expect(find.byType(CoreAppBar), findsOneWidget);

      await tester.tap(find.byKey(const Key('_core_app_bar_button')));
      await tester.pump();
      await tester.pump();

      expect(find.byType(CartPage), findsOneWidget);
    });

    testWidgets('should add item on cart when press add item button',
        (tester) async {
      when(() => catalogRepository.fetch()).thenAnswer(
        (_) async => fakeCatalog,
      );

      await _pumpView(tester);
      await tester.pump(const Duration(seconds: 1));

      const key = Key('_core_catalog_item_1');

      expect(find.byType(CatalogItem), findsWidgets);
      expect(find.byType(CatalogItemBase), findsWidgets);
      expect(find.byKey(key), findsOneWidget);

      await tester.ensureVisible(find.byKey(key));
      await tester.tap(find.byKey(key));
      await tester.pump();

      expect(find.byType(CoreBadge), findsOneWidget);
    });
  });
}
