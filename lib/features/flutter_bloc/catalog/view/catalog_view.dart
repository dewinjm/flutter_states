import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management/common/common.dart';
import 'package:state_management/features/flutter_bloc/catalog/catalog.dart';

class CatalogView extends StatelessWidget {
  const CatalogView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CatalogContainer(
      listOfCatalog: BlocBuilder<CatalogBloc, CatalogState>(
        builder: (context, state) {
          if (state is CatalogLoading) {
            return const CoreProgressIndicator();
          }

          if (state is CatalogLoaded) {
            return Column(
              children: state.catalog
                  .asMap()
                  .entries
                  .map((entry) => CatalogItem(catalog: entry.value))
                  .toList(),
            );
          }

          return const Center(
            child: Text('Error loading catalog'),
          );
        },
      ),
    );
  }
}
