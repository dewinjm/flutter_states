import 'package:state_management/common/data/catalog/data_source/data_source.dart';
import 'package:state_management/common/data/catalog/model/model.dart';
import 'package:state_management/common/data/catalog/repository/repository.dart';

class CatalogRepositoryImpl implements CatalogRepository {
  CatalogRepositoryImpl({required this.remoteDataResponse});

  final CatalogDataSource remoteDataResponse;

  @override
  Future<List<Catalog>>? fetch() async {
    try {
      var fakeList = await remoteDataResponse.getFakeData();

      fakeList
          .asMap()
          .entries
          .toList()
          .sort(((a, b) => a.value.name.compareTo(b.value.name)));

      return Future.delayed(
        const Duration(milliseconds: 800),
        () => fakeList,
      );
    } catch (ex) {
      return throw Exception(ex.toString());
    }
  }
}
