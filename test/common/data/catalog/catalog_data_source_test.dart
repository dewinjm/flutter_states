import 'package:flutter_test/flutter_test.dart';
import 'package:state_management/common/catalog/catalog.dart';

void main() {
  group('CatalogDataSource', () {
    late CatalogDataSource catalogDataSource;

    setUp(() {
      catalogDataSource = CatalogDataSourceImpl();
    });

    group('getFakeData', () {
      test('Should return a list of catalog', () async {
        final result = await catalogDataSource.getFakeData();
        expect(result, fakeCatalogoResponse);
      });
    });
  });
}
