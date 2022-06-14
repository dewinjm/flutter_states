import 'package:flutter/material.dart';
import 'package:state_management/common/common.dart';
import 'package:state_management/features/provider/provider.dart';

class MainView extends StatelessWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final catalogRepository = CatalogRepositoryImpl(
      dataSource: CatalogDataSourceImpl(),
    );

    final cartRepository = CartRepositoryImpl();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CatalogProvider(catalogRepository: catalogRepository),
        ),
        ChangeNotifierProvider(
          create: (_) => CartProvider(cartRepository: cartRepository),
        ),
      ],
      child: MaterialApp(
        navigatorKey: NavigatorRouter.navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Palette.primaryMaterialColor,
        ),
        initialRoute: NavigatorRouter.initial,
        routes: NavigatorRouter.routes(),
      ),
    );
  }
}
