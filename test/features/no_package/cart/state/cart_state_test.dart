import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:state_management/common/common.dart';
import 'package:state_management/features/no_package/cart/cart.dart';

class _MockCartRepository extends Mock implements CartRepository {}

void main() {
  late _MockCartRepository cartRepository;

  setUp(() {
    cartRepository = _MockCartRepository();
  });

  group('No Package: CartState InheritedWidget', () {
    const fakeCart = Cart(
      item: Catalog(
          id: 1,
          name: 'Fake Name',
          unit: '1lb',
          price: 5,
          imageAsset: 'fake_path'),
      count: 10,
    );

    testWidgets(
      'Update inherited when change state',
      (WidgetTester tester) async {
        late CartState inner;

        final Widget widget = CartState(
          cartRepository: cartRepository,
          cartNotifier: CartNotifier([fakeCart]),
          child: Builder(
            builder: (BuildContext context) {
              inner = context.dependOnInheritedWidgetOfExactType<CartState>()!;
              return Container();
            },
          ),
        );

        await tester.pumpWidget(widget);

        when(
          () => cartRepository.send(
            cartItems: inner.cartNotifier.value,
          ),
        ).thenAnswer((_) async => true);

        await inner.process();

        expect(inner.cartNotifier.value.length, equals(0));
        expect(inner.updateShouldNotify(inner), false);
      },
    );
  });
}
