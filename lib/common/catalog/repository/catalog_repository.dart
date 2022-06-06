import 'package:state_management/common/catalog/model/catalog.dart';

abstract class CatalogRepository {
  Future<List<Catalog>>? fetch();
}
