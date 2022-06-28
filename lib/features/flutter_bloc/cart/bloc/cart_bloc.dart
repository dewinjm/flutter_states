import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:state_management/common/common.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc({
    required this.cartRepository,
    required this.cartService,
  }) : super(const CartState.initial()) {
    on<CartItemAdded>(_onItemAdded);
    on<CartItemCountDecreased>(_onItemCountDecreased);
    on<CartItemRemoved>(_onItemRemoved);
    on<CartProcessed>(_onProcessed);
    on<CartResetStatus>(_onResetStatus);
  }

  final CartRepository cartRepository;
  final CartService cartService;

  void _onItemAdded(CartItemAdded event, Emitter<CartState> emit) {
    final items = cartService.addOrUpdateItem(event.cart, state.items);
    emit(state.copyWith(items: items, amount: _calculateAmount(items)));
  }

  void _onItemCountDecreased(
    CartItemCountDecreased event,
    Emitter<CartState> emit,
  ) {
    final items = cartService.decreaseItemCount(event.cart, state.items);
    emit(state.copyWith(items: items, amount: _calculateAmount(items)));
  }

  void _onItemRemoved(CartItemRemoved event, Emitter<CartState> emit) {
    final items = cartService.removeItem(event.cart, state.items);
    emit(state.copyWith(items: items, amount: _calculateAmount(items)));
  }

  void _onProcessed(CartProcessed event, Emitter<CartState> emit) async {
    emit(state.copyWith(cartStatus: CartStatus.loading));

    try {
      final isSuccessful = await cartRepository.send(cartItems: state.items);
      if (isSuccessful) {
        emit(state.copyWith(items: [], cartStatus: CartStatus.done, amount: 0));
      }
    } catch (ex) {
      emit(state.copyWith(cartStatus: CartStatus.error));
    }
  }

  double _calculateAmount(List<Cart> items) {
    return cartService.calculateAmount(items);
  }

  void _onResetStatus(CartResetStatus event, Emitter<CartState> emit) {
    emit(state.copyWith(items: [], cartStatus: CartStatus.initial, amount: 0));
  }
}
