import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:state_management/common/common.dart';
import 'package:state_management/features/flutter_bloc/flutter_bloc.dart';

class MockCartBloc extends MockBloc<CartEvent, CartState> implements CartBloc {}

class MockCatalogBloc extends MockBloc<CatalogEvent, CatalogState>
    implements CatalogBloc {}

void main() {
  late MockCartBloc cartBloc;
  late MockCatalogBloc catalogBloc;

  setUp(() {
    cartBloc = MockCartBloc();
    catalogBloc = MockCatalogBloc();
  });

  group('Bloc: Catalog Page', () {
    Future<void> _pumpView(WidgetTester tester) async {
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<CatalogBloc>.value(value: catalogBloc),
            BlocProvider<CartBloc>.value(value: cartBloc),
          ],
          child: const MaterialApp(
            home: CatalogPage(),
          ),
        ),
      );
    }

    group('should renders', () {
      testWidgets(
          'CoreProgressIndicator with loading indicator '
          'when catalog is loading', (WidgetTester tester) async {
        when(() => catalogBloc.state).thenReturn(CatalogLoading());
        when(() => cartBloc.state).thenReturn(const CartState.initial());

        await _pumpView(tester);

        expect(
          find.descendant(
            of: find.byType(CatalogContainer),
            matching: find.byType(CoreProgressIndicator),
          ),
          findsOneWidget,
        );
      });

      testWidgets('CatalogItem when catalog is loaded',
          (WidgetTester tester) async {
        const fakeCatalog = [
          Catalog(
            id: 1,
            name: 'fake_name',
            price: 2,
            unit: '1lb',
            imageAsset: 'assets/images/tomatoes.png',
          ),
        ];
        when(() => catalogBloc.state).thenReturn(
          const CatalogLoaded(fakeCatalog),
        );
        when(() => cartBloc.state).thenReturn(const CartState.initial());

        await _pumpView(tester);

        expect(find.byType(CatalogItem), findsNWidgets(1));
      });

      testWidgets('error Text when catalog fails to load',
          (WidgetTester tester) async {
        when(() => catalogBloc.state).thenReturn(CatalogError());
        when(() => cartBloc.state).thenReturn(const CartState.initial());

        await _pumpView(tester);

        expect(find.text('Error loading catalog'), findsOneWidget);
      });
    });

    testWidgets('should open cart page when press app bar IconButton',
        (tester) async {
      when(() => catalogBloc.state).thenReturn(CatalogLoading());
      when(() => cartBloc.state).thenReturn(const CartState.initial());

      await _pumpView(tester);

      expect(find.byType(CoreAppBar), findsOneWidget);

      await tester.tap(find.byKey(const Key('_core_app_bar_button')));
      await tester.pump();
      await tester.pump();

      expect(find.byType(CartPage), findsOneWidget);
    });

    testWidgets('should add item on cart when press add item button',
        (tester) async {
      const fakeCatalog = [
        Catalog(
          id: 1,
          name: 'fake_name',
          price: 2,
          unit: '1lb',
          imageAsset: 'assets/images/tomatoes.png',
        ),
      ];
      final fakeCart = Cart(item: fakeCatalog[0], count: 1);

      when(() => catalogBloc.state).thenReturn(
        const CatalogLoaded(fakeCatalog),
      );

      when(() => cartBloc.state).thenReturn(
        const CartState.initial().copyWith(items: [fakeCart]),
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

      verify(
        () => cartBloc.add(CartItemAdded(fakeCart)),
      ).called(1);
    });
  });
}
