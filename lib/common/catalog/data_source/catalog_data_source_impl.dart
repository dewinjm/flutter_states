import 'package:state_management/common/catalog/data_source/catalog_data_source.dart';
import 'package:state_management/common/catalog/model/model.dart';

class CatalogDataSourceImpl extends CatalogDataSource {
  @override
  Future<List<Catalog>> getFakeData() async {
    return fakeCatalogoResponse;
  }
}
