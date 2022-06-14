import 'package:flutter/material.dart';
import 'package:state_management/common/common.dart';

class CatalogProvider with ChangeNotifier {
  CatalogProvider({required this.catalogRepository});

  final CatalogRepository catalogRepository;

  Future<List<Catalog>> fetch() async {
    return await catalogRepository.fetch() ?? [];
  }
}
