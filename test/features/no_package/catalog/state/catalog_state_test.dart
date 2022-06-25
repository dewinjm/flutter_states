import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:state_management/common/common.dart';
import 'package:state_management/features/no_package/no_package.dart';

class _MockCatalogRepository extends Mock implements CatalogRepository {}

void main() {
  group('No Package: CatalogState InheritedWidget', () {
    late _MockCatalogRepository catalogRepository;
    late CartService cartService;

    setUp(() {
      catalogRepository = _MockCatalogRepository();
      cartService = CartServiceImpl();
    });

    const fakeCart = Cart(
      item: Catalog(
          id: 1,
          name: 'Fake Name',
          unit: '1lb',
          price: 5,
          imageAsset: 'fake_path'),
      count: 10,
    );

    testWidgets('Update inherited when change state',
        (WidgetTester tester) async {
      final GlobalKey globalKey = GlobalKey();

      final CartNotifier notifier = CartNotifier(cartService: cartService);
      late CatalogProvider inner;

      final Widget widget = Container(
        key: globalKey,
        child: CatalogProvider(
          catalogRepository: catalogRepository,
          cartNotifier: notifier,
          child: Builder(
            builder: (BuildContext context) {
              inner = context.findAncestorWidgetOfExactType<CatalogProvider>()!;

              return Container();
            },
          ),
        ),
      );
      await tester.pumpWidget(widget);

      inner.cartNotifier.add(fakeCart);

      expect(inner.cartNotifier.value.items.length, equals(1));
      expect(inner.updateShouldNotify(inner), false);
    });
  });
}
