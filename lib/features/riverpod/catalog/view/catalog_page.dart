import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_management/common/common.dart';
import 'package:state_management/features/riverpod/riverpod.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: Scaffold(
        backgroundColor: Palette.primary,
        appBar: CoreAppBar(
          title: 'Riverpord Catalog',
          badge: const CatalogBadge(),
          onPressed: () => _goToCart(context),
        ),
        body: const CatalogView(),
      ),
    );
  }

  void _goToCart(BuildContext context) {
    Navigator.of(context).push(CartPage.router());
  }
}
