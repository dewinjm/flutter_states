import 'package:flutter/material.dart';
import 'package:state_management/common/common.dart';
import 'package:state_management/features/no_package/no_package.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({Key? key}) : super(key: key);

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  final cartNotifier = CartNotifier([]);
  final catalogRepository = CatalogRepositoryImpl(
    dataSource: CatalogDataSourceImpl(),
  );

  @override
  Widget build(BuildContext context) {
    return CatalogState(
      catalogRepository: catalogRepository,
      cartNotifier: cartNotifier,
      child: Scaffold(
        backgroundColor: Palette.primary,
        appBar: CoreAppBar(
          title: 'No Package Catalog',
          badge: const Badge(),
          onPressed: () {},
        ),
        body: const CatalogView(),
      ),
    );
  }
}
