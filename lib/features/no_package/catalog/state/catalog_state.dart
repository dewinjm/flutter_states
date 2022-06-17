import 'package:flutter/material.dart';
import 'package:state_management/common/catalog/catalog.dart';
import 'package:state_management/features/no_package/cart/cart.dart';

class CatalogState extends InheritedWidget {
  const CatalogState({
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

  static CatalogState of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<CatalogState>()!;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
