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
    testWidgets(
      'Update inherited when change state',
      (WidgetTester tester) async {
        late CartProvider inner;

        final Widget widget = CartProvider(
          cartRepository: cartRepository,
          cartNotifier: CartNotifier(),
          child: Builder(
            builder: (BuildContext context) {
              inner =
                  context.dependOnInheritedWidgetOfExactType<CartProvider>()!;
              return Container();
            },
          ),
        );

        await tester.pumpWidget(widget);

        when(
          () => cartRepository.send(
            cartItems: inner.cartNotifier.value.items,
          ),
        ).thenAnswer((_) async => true);

        await inner.process();

        expect(inner.cartNotifier.value.items.length, equals(0));
        expect(inner.updateShouldNotify(inner), false);
      },
    );
  });
}
