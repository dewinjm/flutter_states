import 'package:equatable/equatable.dart';

class Catalog extends Equatable {
  final int id;
  final String name;
  final double price;
  final String unit;
  final String imageAsset;

  const Catalog({
    required this.id,
    required this.name,
    required this.price,
    required this.unit,
    required this.imageAsset,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        price,
        unit,
        imageAsset,
      ];
}
