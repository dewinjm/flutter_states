import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:state_management/common/common.dart';
import 'package:state_management/features/flutter_bloc/flutter_bloc.dart';

class MockCartRepository extends Mock implements CartRepository {}

void main() {
  group('Bloc: CartBloc', () {
    const cartItems = [
      Cart(
        item: Catalog(
          id: 1,
          name: 'name #1',
          price: 1,
          unit: '1lb',
          imageAsset: 'assets',
        ),
        count: 1,
        amount: 1.0,
      ),
    ];

    const mockItemToAdd = Cart(
      item: Catalog(
        id: 2,
        name: 'name #2',
        price: 2,
        unit: '1lb',
        imageAsset: 'assets',
      ),
      count: 1,
      amount: 2.0,
    );

    late MockCartRepository cartRepository;

    setUp(() {
      cartRepository = MockCartRepository();
    });

    test('initial state', () {
      expect(
        CartBloc(cartRepository: cartRepository).state,
        const CartState.initial(),
      );
    });

    blocTest<CartBloc, CartState>(
      'emits [CartState] with items and amount value'
      'when item is added successfully',
      build: () => CartBloc(cartRepository: cartRepository),
      seed: () => const CartState(
        items: cartItems,
        cartStatus: CartStatus.initial,
        amount: 3,
      ),
      act: (bloc) {
        bloc.add(const CartItemAdded(mockItemToAdd));
        bloc.add(const CartItemAdded(mockItemToAdd));
      },
      expect: () => <CartState>[
        const CartState(
          items: [...cartItems, mockItemToAdd],
          cartStatus: CartStatus.initial,
          amount: 3.0,
        ),
        CartState(
          items: [...cartItems, mockItemToAdd.copyWith(amount: 4.0, count: 2)],
          cartStatus: CartStatus.initial,
          amount: 5.0,
        )
      ],
    );

    blocTest<CartBloc, CartState>(
      'emits [CartState] with items and amount value'
      'when item count is decreased',
      build: () => CartBloc(cartRepository: cartRepository),
      seed: () => CartState(
        items: [mockItemToAdd.copyWith(count: 2, amount: 4)],
        cartStatus: CartStatus.initial,
        amount: 0,
      ),
      act: (bloc) => bloc.add(const CartItemCountDecreased(mockItemToAdd)),
      expect: () => <CartState>[
        const CartState(
          items: [mockItemToAdd],
          cartStatus: CartStatus.initial,
          amount: 2,
        )
      ],
    );

    blocTest<CartBloc, CartState>(
      'emits [CartState] when item is removed successfully',
      build: () => CartBloc(cartRepository: cartRepository),
      seed: () => const CartState(
        items: [...cartItems, mockItemToAdd],
        cartStatus: CartStatus.initial,
        amount: 1,
      ),
      act: (bloc) => bloc.add(const CartItemRemoved(mockItemToAdd)),
      expect: () => <CartState>[
        const CartState(
          items: cartItems,
          cartStatus: CartStatus.initial,
          amount: 1,
        )
      ],
    );

    blocTest<CartBloc, CartState>(
      'emits [CartState] with status [loading, done]'
      'when CartProcessed is successfully',
      setUp: () {
        when(() => cartRepository.send(cartItems: cartItems))
            .thenAnswer((_) async => true);
      },
      build: () => CartBloc(cartRepository: cartRepository),
      seed: () => const CartState(
        items: [...cartItems],
        cartStatus: CartStatus.initial,
        amount: 1,
      ),
      act: (bloc) => bloc.add(CartProcessed()),
      expect: () => <CartState>[
        const CartState(
          items: cartItems,
          cartStatus: CartStatus.loading,
          amount: 1,
        ),
        const CartState(
          items: [],
          cartStatus: CartStatus.done,
          amount: 0,
        ),
      ],
      verify: (_) {
        verify(
          () => cartRepository.send(cartItems: cartItems),
        ).called(1);
      },
    );

    blocTest<CartBloc, CartState>(
      'emits [CartState] with status error'
      'when CartRepository Send throws an error',
      setUp: () {
        when(() => cartRepository.send(cartItems: cartItems))
            .thenThrow(Exception());
      },
      build: () => CartBloc(cartRepository: cartRepository),
      seed: () => const CartState(
        items: [...cartItems],
        cartStatus: CartStatus.initial,
        amount: 1,
      ),
      act: (bloc) => bloc.add(CartProcessed()),
      expect: () => <CartState>[
        const CartState(
          items: cartItems,
          cartStatus: CartStatus.loading,
          amount: 1,
        ),
        const CartState(
          items: cartItems,
          cartStatus: CartStatus.error,
          amount: 1,
        ),
      ],
      verify: (_) {
        verify(
          () => cartRepository.send(cartItems: cartItems),
        ).called(1);
      },
    );

    blocTest<CartBloc, CartState>(
      'emits [CartState] with status initial'
      'when CartResetStatus is successfully',
      build: () => CartBloc(cartRepository: cartRepository),
      seed: () => const CartState(
        items: [...cartItems],
        cartStatus: CartStatus.initial,
        amount: 1,
      ),
      act: (bloc) => bloc.add(CartResetStatus()),
      expect: () => <CartState>[
        const CartState(
          items: [],
          cartStatus: CartStatus.initial,
          amount: 0,
        ),
      ],
    );
  });
}
