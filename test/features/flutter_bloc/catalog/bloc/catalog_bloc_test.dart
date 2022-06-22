import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:state_management/common/common.dart';
import 'package:state_management/features/flutter_bloc/flutter_bloc.dart';

class MockCatalogRepository extends Mock implements CatalogRepository {}

void main() {
  group('Bloc: Catalog Bloc', () {
    late MockCatalogRepository catalogRepository;

    const fakeCatalog = [
      Catalog(
        id: 1,
        name: 'fake_name',
        price: 2,
        unit: '1lb',
        imageAsset: 'assets',
      ),
    ];

    setUp(() {
      catalogRepository = MockCatalogRepository();
    });

    test('initial state is CatalogLoading', () {
      expect(
        CatalogBloc(catalogRepository: catalogRepository).state,
        CatalogLoading(),
      );
    });

    blocTest<CatalogBloc, CatalogState>(
      'emits [CatalogLoading, CatalogLoaded] '
      'when catalog is loaded successfully',
      setUp: () {
        when(() => catalogRepository.fetch()).thenAnswer(
          (_) async => fakeCatalog,
        );
      },
      build: () => CatalogBloc(catalogRepository: catalogRepository),
      act: (bloc) => bloc.add(CatalogStarted()),
      expect: () => <CatalogState>[
        CatalogLoading(),
        const CatalogLoaded(fakeCatalog),
      ],
      verify: (_) => verify(catalogRepository.fetch).called(1),
    );

    blocTest<CatalogBloc, CatalogState>(
      'emits [CatalogLoading, CatalogError] '
      'when loading the catalog throws an exception',
      setUp: () {
        when(catalogRepository.fetch).thenThrow(Exception('Error'));
      },
      build: () => CatalogBloc(catalogRepository: catalogRepository),
      act: (bloc) => bloc.add(CatalogStarted()),
      expect: () => <CatalogState>[
        CatalogLoading(),
        CatalogError(),
      ],
      verify: (_) => verify(catalogRepository.fetch).called(1),
    );
  });
}
