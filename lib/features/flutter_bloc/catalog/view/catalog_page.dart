import 'package:flutter/material.dart';
import 'package:state_management/common/common.dart';
import 'package:state_management/features/flutter_bloc/catalog/view/catalog_view.dart';
import 'package:state_management/features/flutter_bloc/flutter_bloc.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({Key? key}) : super(key: key);

  static const String route = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.primary,
      appBar: CoreAppBar(
        title: 'Provider Catalog',
        badge: const CatalogBadge(),
        onPressed: () => _goToCart(context),
      ),
      body: const CatalogView(),
    );
  }

  void _goToCart(BuildContext context) {
    Navigator.of(context).push(CartPage.router());
  }
}
