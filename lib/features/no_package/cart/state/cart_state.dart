part of 'cart_provider.dart';

enum CartStatus {
  initial,
  loading,
  done,
  error,
}

class CartState extends Equatable {
  const CartState({
    required this.items,
    required this.cartStatus,
    required this.amount,
  });

  const CartState.initial()
      : this(items: const [], cartStatus: CartStatus.initial, amount: 0.0);

  final List<Cart> items;
  final CartStatus cartStatus;
  final double amount;

  @override
  List<Object> get props => [items, cartStatus, amount];

  CartState copyWith({
    List<Cart>? items,
    CartStatus? cartStatus,
    double? amount,
  }) =>
      CartState(
        items: items ?? this.items,
        cartStatus: cartStatus ?? this.cartStatus,
        amount: amount ?? this.amount,
      );
}
