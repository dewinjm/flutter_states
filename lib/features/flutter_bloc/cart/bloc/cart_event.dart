part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
}

class CartItemAdded extends CartEvent {
  const CartItemAdded(this.cart);

  final Cart cart;

  @override
  List<Object> get props => [cart];
}

class CartItemCountDecreased extends CartEvent {
  const CartItemCountDecreased(this.cart);

  final Cart cart;

  @override
  List<Object> get props => [cart];
}

class CartItemRemoved extends CartEvent {
  const CartItemRemoved(this.cart);

  final Cart cart;

  @override
  List<Object> get props => [cart];
}

class CartProcessed extends CartEvent {
  @override
  List<Object?> get props => [];
}

class CartResetStatus extends CartEvent {
  @override
  List<Object?> get props => [];
}
