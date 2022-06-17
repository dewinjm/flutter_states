import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:state_management/common/common.dart';
import 'package:state_management/features/provider/provider.dart';

class _MockCatalogProvider extends Mock implements CatalogProvider {}

class _MockCartProvider extends Mock implements CartProvider {}

void main() {
  group('Provider: CatalogPage', () {
    late _MockCatalogProvider catalogProvider;
    late _MockCartProvider cartProvider;

    setUp(() {
      catalogProvider = _MockCatalogProvider();
      cartProvider = _MockCartProvider();
    });

    const fakeCatalog = [
      Catalog(
        id: 1,
        name: 'fake name',
        price: 2.10,
        unit: '1lb',
        imageAsset: 'assets/images/tomatoes.png',
      ),
    ];

    Future<void> _pumpView({
      required WidgetTester tester,
      List<Cart>? items,
    }) async {
      when(() => catalogProvider.fetch()).thenAnswer(
        (_) async => fakeCatalog,
      );

      when((() => cartProvider.items)).thenReturn(items ?? []);

      final provider = MultiProvider(
        providers: [
          ChangeNotifierProvider<CatalogProvider>.value(
            value: catalogProvider,
          ),
          ChangeNotifierProvider<CartProvider>.value(
            value: cartProvider,
          ),
        ],
        child: MaterialApp(
          routes: NavigatorRouter.routes(),
          initialRoute: CatalogPage.route,
        ),
      );

      await tester.pumpWidget(provider);
    }

    testWidgets('should render', (tester) async {
      await _pumpView(tester: tester);
      expect(find.byType(CatalogView), findsOneWidget);
    });

    testWidgets('should hidden badge when cart is empty', (tester) async {
      await _pumpView(tester: tester);
      expect(find.byType(CoreBadge), findsNothing);
    });

    testWidgets('should show badge when cart is not empty', (tester) async {
      final items = [Cart(item: fakeCatalog[0], count: 1)];
      await _pumpView(tester: tester, items: items);
      expect(find.byType(CoreBadge), findsOneWidget);
    });

    testWidgets('should open cart page when press app bar IconButton',
        (tester) async {
      await _pumpView(tester: tester);

      expect(find.byType(CoreAppBar), findsOneWidget);

      await tester.tap(find.byKey(const Key('_core_app_bar_button')));
      await tester.pump();
      await tester.pump();

      expect(find.byType(CartPage), findsOneWidget);
    });

    testWidgets('should add item on cart when press add item button',
        (tester) async {
      final items = Cart(item: fakeCatalog[0], count: 10);

      await _pumpView(tester: tester);
      await tester.pump(const Duration(seconds: 1));

      when((() => cartProvider.add(items))).thenAnswer((_) {});
      when(() => cartProvider.items).thenAnswer((_) => [items]);

      const key = Key('_core_catalog_item_1');

      expect(find.byType(CatalogItem), findsWidgets);
      expect(find.byType(CatalogItemBase), findsWidgets);
      expect(find.byKey(key), findsOneWidget);

      await tester.ensureVisible(find.byKey(key));
      await tester.tap(find.byKey(key));
      await tester.pump();

      expect(cartProvider.items.length, equals(1));
    });
  });
}
