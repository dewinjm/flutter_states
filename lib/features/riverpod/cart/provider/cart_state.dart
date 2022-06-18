import 'package:equatable/equatable.dart';
import 'package:state_management/common/common.dart';

enum CartStatus {
  initial,
  loading,
  done,
}

class CartState extends Equatable {
  final List<Cart> items;
  final CartStatus cartStatus;

  const CartState({required this.items, required this.cartStatus});

  @override
  List<Object?> get props => [
        items,
        cartStatus,
      ];

  CartState copyWith({
    List<Cart>? items,
    CartStatus? cartStatus,
  }) {
    return CartState(
      items: items ?? this.items,
      cartStatus: cartStatus ?? this.cartStatus,
    );
  }
}
