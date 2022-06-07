import 'package:flutter_test/flutter_test.dart';
import 'package:state_management/common/catalog/model/catalog.dart';

void main() {
  group('CatalogModel', () {
    const fakeModel = Catalog(
      id: 1,
      name: 'fake name',
      price: 1.0,
      unit: 'fake unit',
      imageAsset: 'fake_image',
    );

    test('should return correct toString', () {
      expect(
        fakeModel.toString(),
        'Catalog(fake name, 1.0, fake unit, fake_image)',
      );
    });

    test('should return true when instance is the same', () {
      const instance = Catalog(
        id: 1,
        name: 'fake name',
        price: 1.0,
        unit: 'fake unit',
        imageAsset: 'fake_image',
      );
      expect(instance == fakeModel, true);
    });

    test('should return false when compared to non-equatable', () {
      const instance = Catalog(
        id: 4,
        name: 'name',
        price: 0,
        unit: 'unit',
        imageAsset: 'fake_image',
      );
      expect(instance == fakeModel, false);
    });
  });
}
