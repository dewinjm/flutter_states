import 'package:state_management/common/data/catalog/model/catalog.dart';

abstract class CatalogRepository {
  Future<List<Catalog>>? fetch();
}
