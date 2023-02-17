import 'package:flutter/material.dart';
import 'package:state_management/common/common.dart';
import 'package:state_management/features/no_package/no_package.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({Key? key}) : super(key: key);

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.primary,
      appBar: CoreAppBar(
        title: 'No Package Catalog',
        badge: const BadgeItem(),
        onPressed: () => _goToCart(),
      ),
      body: const CatalogView(),
    );
  }

  void _goToCart() {
    Navigator.of(context).pushNamed('/cart');
  }
}
