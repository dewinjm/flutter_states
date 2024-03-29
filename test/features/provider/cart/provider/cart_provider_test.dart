import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:state_management/common/common.dart';
import 'package:state_management/features/provider/provider.dart';

class MockCartRepository extends Mock implements CartRepository {}

void main() {
  late MockCartRepository cartRepository;
  late CartProvider cartProvider;
  late CartService cartService;

  setUp(() {
    cartRepository = MockCartRepository();
    cartService = CartServiceImpl();
    cartProvider = CartProvider(
      cartRepository: cartRepository,
      cartService: cartService,
    );
  });

  group('Provider: CartProvider', () {
    const fakeCart1 = Cart(
      item: Catalog(
        id: 1,
        name: 'Fake_name_1',
        price: 50,
        unit: 'fake_unit',
        imageAsset: 'path',
      ),
      count: 1,
    );

    const fakeCart2 = Cart(
      item: Catalog(
        id: 2,
        name: 'Fake_name_2',
        price: 25,
        unit: 'fake_unit',
        imageAsset: 'path',
      ),
      count: 1,
    );

    Future<void> pumpView(WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<CartProvider>.value(
              value: cartProvider,
            ),
          ],
          child: Consumer<CartProvider>(
            builder: (_, provider, __) {
              return Text(
                provider.state.amount.toString(),
                textDirection: TextDirection.ltr,
              );
            },
          ),
        ),
      );
    }

    testWidgets('should add item when call add function', (tester) async {
      await pumpView(tester);

      cartProvider.add(fakeCart1);
      await tester.pump();

      expect(find.text('50.0'), findsOneWidget);
      expect(cartProvider.state.amount, equals(50.0));

      cartProvider.add(fakeCart2);
      await tester.pump();

      expect(cartProvider.state.amount, equals(75.0));
      expect(cartProvider.state.items.length, equals(2));
    });

    testWidgets(
      'must reduce the number of items when the function decrease is called',
      (tester) async {
        await pumpView(tester);

        cartProvider.add(fakeCart2);
        cartProvider.add(fakeCart2);
        cartProvider.decrease(fakeCart2);
        await tester.pump();

        expect(find.text('25.0'), findsOneWidget);
        expect(cartProvider.state.amount, equals(25.0));
        expect(cartProvider.state.items.length, equals(1));
      },
    );

    testWidgets(
      'must remove item when the function remove is called',
      (tester) async {
        await pumpView(tester);

        cartProvider.add(fakeCart1);
        await tester.pump();
        cartProvider.remove(cartProvider.state.items.first);
        await tester.pump();

        expect(cartProvider.state.amount, equals(0.0));
        expect(cartProvider.state.items.length, equals(0));
      },
    );

    testWidgets(
      'should call CartRepository send function when call process function',
      (tester) async {
        await pumpView(tester);

        when(
          () => cartRepository.send(cartItems: cartProvider.state.items),
        ).thenAnswer((_) async => true);

        cartProvider.process();

        await tester.pump();
        expect(cartProvider.state.cartStatus, equals(CartStatus.done));
      },
    );

    testWidgets(
      'should return status error'
      'when CartRepository Send throws an error',
      (tester) async {
        await pumpView(tester);

        when(
          () => cartRepository.send(cartItems: cartProvider.state.items),
        ).thenThrow(Exception());

        cartProvider.process();

        await tester.pump();
        expect(cartProvider.state.cartStatus, equals(CartStatus.error));
      },
    );

    testWidgets(
      'should have initial status when call reset function',
      (tester) async {
        await pumpView(tester);
        cartProvider.resetStatus();

        await tester.pump();
        expect(cartProvider.state.cartStatus, equals(CartStatus.initial));
      },
    );
  });
}
