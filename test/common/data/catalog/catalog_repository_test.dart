import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:state_management/common/catalog/catalog.dart';

class _MockCatalogDataSource extends Mock implements CatalogDataSource {}

void main() {
  group('CatalogRepository', () {
    late _MockCatalogDataSource dataSource;
    late CatalogRepositoryImpl catalogRepository;

    const fakeRemoteDataSource = [
      Catalog(
        name: 'Tomatoes',
        id: 10,
        price: 1.98,
        unit: '1lb',
        imageAsset: 'fake_image.png',
      ),
      Catalog(
        id: 11,
        name: 'Pineapple',
        price: 2.18,
        unit: 'Each',
        imageAsset: 'fake_image.png',
      ),
    ];

    setUp(() {
      dataSource = _MockCatalogDataSource();
      catalogRepository = CatalogRepositoryImpl(dataSource: dataSource);
    });

    group('Fetch', () {
      test('Should return a list of catalog when DataSource is successful',
          () async {
        when(() => dataSource.getFakeData()).thenAnswer(
          (_) async => fakeRemoteDataSource,
        );

        final result = await catalogRepository.fetch();
        verify(() => dataSource.getFakeData());

        expect(result, fakeRemoteDataSource);
      });

      test('Should return a exception when DataSource is fail', () async {
        when(() => dataSource.getFakeData()).thenThrow(
          const SocketException('Fake Error'),
        );

        expect(catalogRepository.fetch, throwsA(isA<Exception>()));
      });
    });
  });
}
