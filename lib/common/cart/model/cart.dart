import 'package:equatable/equatable.dart';
import 'package:state_management/common/catalog/catalog.dart';

class Cart extends Equatable {
  const Cart({
    required this.item,
    required this.count,
    this.amount,
  });

  final Catalog item;
  final int count;
  final double? amount;

  @override
  List<Object?> get props => [item, count, amount];

  Cart copyWith({
    Catalog? item,
    int? count,
    double? amount,
  }) =>
      Cart(
        item: item ?? this.item,
        count: count ?? this.count,
        amount: amount ?? this.amount,
      );
}
