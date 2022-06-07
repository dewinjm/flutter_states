import 'package:state_management/common/catalog/model/model.dart';

abstract class CatalogDataSource {
  Future<List<Catalog>> getFakeData();
}

const fakeCatalogoResponse = [
  Catalog(
    id: 1,
    name: 'Tomatoes',
    price: 1.98,
    unit: '1lb',
    imageAsset: 'assets/images/tomatoes.png',
  ),
  Catalog(
    id: 2,
    name: 'Pineapple',
    price: 2.18,
    unit: 'Each',
    imageAsset: 'assets/images/pineapple.png',
  ),
  Catalog(
    id: 3,
    name: 'Orange',
    price: 1.23,
    unit: '1lb',
    imageAsset: 'assets/images/orange.png',
  ),
  Catalog(
    id: 4,
    name: 'Potatoes',
    price: 4.23,
    unit: '1lb',
    imageAsset: 'assets/images/potatoes.png',
  ),
  Catalog(
    id: 5,
    name: 'Watermelon',
    price: 3.98,
    unit: 'Each',
    imageAsset: 'assets/images/watermelon.png',
  ),
  Catalog(
    id: 6,
    name: 'Water',
    price: 0.23,
    unit: 'Each',
    imageAsset: 'assets/images/water.png',
  ),
  Catalog(
    id: 7,
    name: 'Banana',
    price: 1.63,
    unit: 'Buch',
    imageAsset: 'assets/images/banana.png',
  ),
  Catalog(
    id: 8,
    name: 'Brocollis',
    price: 1.40,
    unit: '1lb',
    imageAsset: 'assets/images/brocollis.png',
  ),
  Catalog(
    id: 9,
    name: 'Bell Pappers',
    price: 2.18,
    unit: '1lb',
    imageAsset: 'assets/images/bell_pappers.png',
  ),
  Catalog(
    id: 10,
    name: 'Corns',
    price: 1.14,
    unit: '1lb',
    imageAsset: 'assets/images/corns.png',
  ),
  Catalog(
    id: 11,
    name: 'Eggs',
    price: 3.10,
    unit: '12 count',
    imageAsset: 'assets/images/egg.png',
  ),
  Catalog(
    id: 12,
    name: 'Milk',
    price: 2.97,
    unit: '20oz',
    imageAsset: 'assets/images/milk.png',
  ),
  Catalog(
    id: 13,
    name: 'Apple',
    price: 3.12,
    unit: '1lb',
    imageAsset: 'assets/images/apple.png',
  ),
];
