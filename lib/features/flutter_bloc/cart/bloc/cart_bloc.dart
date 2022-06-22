import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:state_management/common/common.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc({required this.cartRepository}) : super(const CartState.initial()) {
    on<CartItemAdded>(_onItemAdded);
    on<CartItemCountDecreased>(_onItemCountDecreased);
    on<CartItemRemoved>(_onItemRemoved);
    on<CartProcessed>(_onProcessed);
    on<CartResetStatus>(_onResetStatus);
  }

  final CartRepository cartRepository;

  void _onItemAdded(CartItemAdded event, Emitter<CartState> emit) {
    final List<Cart> items = List.from(state.items);

    if (items.where((e) => e.item.id == event.cart.item.id).isNotEmpty) {
      final index = items.indexWhere((e) => e.item == event.cart.item);
      final item = items[index];
      final count = item.count + 1;

      items[index] = item.copyWith(
        count: count,
        amount: (item.item.price * count),
      );
    } else {
      items.add(
        Cart(
          item: event.cart.item,
          count: 1,
          amount: event.cart.item.price,
        ),
      );
    }

    emit(state.copyWith(items: items, amount: _calculateAmount(items)));
  }

  void _onItemCountDecreased(
    CartItemCountDecreased event,
    Emitter<CartState> emit,
  ) {
    final List<Cart> items = List.from(state.items);
    final index = items.indexWhere((e) => e.item == event.cart.item);
    final item = items[index];
    final count = item.count - 1;

    items[index] = item.copyWith(
      count: count,
      amount: (item.item.price * count),
    );

    emit(state.copyWith(items: items, amount: _calculateAmount(items)));
  }

  void _onItemRemoved(CartItemRemoved event, Emitter<CartState> emit) {
    final List<Cart> items = List.from(state.items);
    if (items.contains(event.cart)) {
      items.remove(event.cart);
    }

    emit(state.copyWith(items: items, amount: _calculateAmount(items)));
  }

  void _onProcessed(CartProcessed event, Emitter<CartState> emit) async {
    emit(state.copyWith(cartStatus: CartStatus.loading));

    final isSuccessful = await cartRepository.send(cartItems: state.items);

    if (isSuccessful) {
      emit(state.copyWith(items: [], cartStatus: CartStatus.done, amount: 0));
    } else {
      emit(state.copyWith(cartStatus: CartStatus.error));
    }
  }

  double _calculateAmount(List<Cart> items) {
    if (items.isEmpty) return 0.0;

    return items
        .map((item) => item.amount ?? 0)
        .reduce((value, current) => value + current);
  }

  void _onResetStatus(CartResetStatus event, Emitter<CartState> emit) {
    emit(state.copyWith(items: [], cartStatus: CartStatus.initial, amount: 0));
  }
}
