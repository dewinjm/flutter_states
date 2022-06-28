import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management/common/common.dart';
import 'package:state_management/features/flutter_bloc/flutter_bloc.dart';

class MainView extends StatelessWidget {
  MainView({Key? key}) : super(key: key);

  final CatalogDataSource catalogDataSource = CatalogDataSourceImpl();
  final CartRepository cartRepository = CartRepositoryImpl();
  final CartService cartService = CartServiceImpl();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CatalogBloc(
            catalogRepository: CatalogRepositoryImpl(
              dataSource: catalogDataSource,
            ),
          )..add(CatalogStarted()),
        ),
        BlocProvider(
          create: (_) => CartBloc(
            cartRepository: cartRepository,
            cartService: cartService,
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Palette.primaryMaterialColor,
        ),
        home: const CatalogPage(),
      ),
    );
  }
}
