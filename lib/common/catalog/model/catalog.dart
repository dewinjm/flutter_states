import 'package:equatable/equatable.dart';

class Catalog extends Equatable {
  final String name;
  final double price;
  final String unit;
  final String imageAsset;

  const Catalog({
    required this.name,
    required this.price,
    required this.unit,
    required this.imageAsset,
  });

  @override
  List<Object?> get props => [
        name,
        price,
        unit,
        imageAsset,
      ];
}
