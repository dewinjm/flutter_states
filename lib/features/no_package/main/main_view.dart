import 'package:flutter/material.dart';
import 'package:state_management/common/common.dart';
import 'package:state_management/features/no_package/no_package.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

final cartService = CartServiceImpl();
final catalogRepository = CatalogRepositoryImpl(
  dataSource: CatalogDataSourceImpl(),
);
final cartRepository = CartRepositoryImpl();

class _MainViewState extends State<MainView> {
  final cartNotifier = CartNotifier(cartService: cartService);

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
      '/': (context) => CatalogProvider(
            catalogRepository: catalogRepository,
            cartNotifier: cartNotifier,
            child: const CatalogPage(),
          ),
      '/cart': (context) => CartProvider(
            cartNotifier: cartNotifier,
            cartRepository: cartRepository,
            child: const CartPage(),
          ),
    };
  }
}
