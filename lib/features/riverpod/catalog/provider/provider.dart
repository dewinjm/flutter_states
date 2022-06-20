import 'package:riverpod/riverpod.dart';
import 'package:state_management/common/catalog/catalog.dart';

final catalogDatasourceProvider = Provider<CatalogDataSource>(
  (ref) => CatalogDataSourceImpl(),
);

final catalogRepositoryProvider = Provider<CatalogRepository>(
  (ref) => CatalogRepositoryImpl(
    dataSource: ref.read(catalogDatasourceProvider),
  ),
);

final catalogProvider = FutureProvider.autoDispose<List<Catalog>>(
  (ref) async {
    final repository = ref.read(catalogRepositoryProvider);

    return await repository.fetch() ?? [];
  },
);
