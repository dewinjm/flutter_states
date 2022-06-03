import 'package:state_management/common/catalog/model/model.dart';

abstract class CatalogDataSource {
  Future<List<Catalog>> getFakeData();
}

const fakeCatalogoResponse = [
  Catalog(
    name: 'Tomatoes',
    price: 1.98,
    unit: '1lb',
    imageAsset: 'assets/images/tomatoes.png',
  ),
  Catalog(
    name: 'Pineapple',
    price: 2.18,
    unit: 'Each',
    imageAsset: 'assets/images/pineapple.png',
  ),
  Catalog(
    name: 'Orange',
    price: 1.23,
    unit: '1lb',
    imageAsset: 'assets/images/orange.png',
  ),
  Catalog(
    name: 'Potatoes',
    price: 4.23,
    unit: '1lb',
    imageAsset: 'assets/images/potatoes.png',
  ),
  Catalog(
    name: 'Watermelon',
    price: 3.98,
    unit: 'Each',
    imageAsset: 'assets/images/watermelon.png',
  ),
  Catalog(
    name: 'Water',
    price: 0.23,
    unit: 'Each',
    imageAsset: 'assets/images/water.png',
  ),
  Catalog(
    name: 'Apple',
    price: 1.63,
    unit: 'Buch',
    imageAsset: 'assets/images/banana.png',
  ),
  Catalog(
    name: 'Brocollis',
    price: 1.40,
    unit: '1lb',
    imageAsset: 'assets/images/brocollis.png',
  ),
  Catalog(
    name: 'Bell Pappers',
    price: 2.18,
    unit: '1lb',
    imageAsset: 'assets/images/bell_pappers.png',
  ),
  Catalog(
    name: 'Corns',
    price: 1.14,
    unit: '1lb',
    imageAsset: 'assets/images/corns.png',
  ),
  Catalog(
    name: 'Eggs',
    price: 3.10,
    unit: '12 count',
    imageAsset: 'assets/images/egg.png',
  ),
  Catalog(
    name: 'Milk',
    price: 2.97,
    unit: '20oz',
    imageAsset: 'assets/images/milk.png',
  ),
];
