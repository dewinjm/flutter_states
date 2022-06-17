import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:state_management/common/common.dart';
import 'package:state_management/features/no_package/no_package.dart';

class MockCatalogRepository extends Mock implements CatalogRepository {}

class MockCartRepository extends Mock implements CartRepository {}

void main() {
  late MockCatalogRepository catalogRepository;
  late MockCartRepository cartRepository;

  setUp(() {
    catalogRepository = MockCatalogRepository();
    cartRepository = MockCartRepository();
  });

  group('No Package: CatalogPage ', () {
    const fakeCatalog = [
      Catalog(
        id: 1,
        name: 'fake_name_1',
        price: 2.10,
        unit: '1lb',
        imageAsset: 'assets/images/tomatoes.png',
      ),
      Catalog(
        id: 2,
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
      await tester.pumpWidget(
        MaterialApp(
          initialRoute: '/',
          routes: {
            '/': (context) => CatalogState(
                  catalogRepository: catalogRepository,
                  cartNotifier: CartNotifier(items ?? []),
                  child: const CatalogPage(),
                ),
            '/cart': (context) => CartState(
                  cartNotifier: CartNotifier(items ?? []),
                  cartRepository: cartRepository,
                  child: const CartPage(),
                ),
          },
        ),
      );
    }

    testWidgets('should renders', (tester) async {
      await _pumpView(tester: tester);

      expect(find.text('No Package Catalog'), findsOneWidget);
      expect(find.byType(CatalogView), findsOneWidget);
      expect(find.byType(CoreAppBar), findsOneWidget);
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

      await tester.tap(find.byKey(const Key('_core_app_bar_button')));
      await tester.pump();
      await tester.pump();

      expect(find.byType(CartPage), findsOneWidget);
    });

    testWidgets('should add item on cart when press add item button',
        (tester) async {
      final cart = Cart(item: fakeCatalog[0], count: 10);
      final items = [cart, cart];

      when((() => catalogRepository.fetch())).thenAnswer(
        ((_) async => fakeCatalog),
      );

      await _pumpView(tester: tester, items: items);

      await tester.pump(const Duration(seconds: 1));

      expect(find.byType(CatalogItem), findsWidgets);
      expect(find.byType(CatalogItemBase), findsWidgets);

      const key = Key('_core_catalog_item_2');
      expect(find.byKey(key), findsOneWidget);

      await tester.ensureVisible(find.byKey(key));
      await tester.tap(find.byKey(key));
      await tester.pump();

      final badge = tester.widget<CoreBadge>(find.byType(CoreBadge));
      expect(badge.count, equals(3));
    });
  });
}
