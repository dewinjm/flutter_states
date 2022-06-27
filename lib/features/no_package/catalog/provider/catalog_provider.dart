import 'package:flutter/material.dart';
import 'package:state_management/common/catalog/catalog.dart';
import 'package:state_management/features/no_package/no_package.dart';

class CatalogProvider extends InheritedWidget {
  const CatalogProvider({
    required this.catalogRepository,
    required this.cartNotifier,
    required super.child,
    Key? key,
  }) : super(key: key);

  final CatalogRepository catalogRepository;
  final CartNotifier cartNotifier;

  Future<List<Catalog>> fetch() async {
    return await catalogRepository.fetch() ?? [];
  }

  static CatalogProvider of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<CatalogProvider>()!;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
