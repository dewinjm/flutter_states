import 'package:state_management/common/common.dart';

class CatalogRepositoryImpl implements CatalogRepository {
  CatalogRepositoryImpl({required this.dataSource});

  final CatalogDataSource dataSource;

  @override
  Future<List<Catalog>>? fetch() async {
    try {
      List<Catalog> fakeList = List.from(await dataSource.getFakeData());
      fakeList.sort(((a, b) => a.name.compareTo(b.name)));

      return Future.delayed(
        const Duration(milliseconds: Values.timeLoad),
        () => fakeList,
      );
    } catch (ex) {
      return throw Exception(ex.toString());
    }
  }
}
