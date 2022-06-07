import 'package:equatable/equatable.dart';
import 'package:state_management/common/catalog/catalog.dart';

class Cart extends Equatable {
  const Cart({required this.item, required this.count});

  final Catalog item;
  final int count;

  @override
  List<Object?> get props => [item, count];
  Cart copyWith({
    Catalog? item,
    int? count,
  }) =>
      Cart(
        item: item ?? this.item,
        count: count ?? this.count,
      );
}
