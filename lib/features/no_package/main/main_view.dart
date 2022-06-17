import 'package:flutter/material.dart';
import 'package:state_management/common/common.dart';
import 'package:state_management/features/no_package/no_package.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final catalogRepository = CatalogRepositoryImpl(
    dataSource: CatalogDataSourceImpl(),
  );

  final cartRepository = CartRepositoryImpl();
  final cartNotifier = CartNotifier([]);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Palette.primaryMaterialColor,
      ),
      routes: routes(),
    );
  }

  Map<String, WidgetBuilder> routes() {
    return {
      '/': (context) => CatalogState(
            catalogRepository: catalogRepository,
            cartNotifier: cartNotifier,
            child: const CatalogPage(),
          ),
      '/cart': (context) => CartState(
            cartNotifier: cartNotifier,
            cartRepository: cartRepository,
            child: const CartPage(),
          ),
    };
  }
}
