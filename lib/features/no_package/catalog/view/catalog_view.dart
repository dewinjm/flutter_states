import 'package:flutter/material.dart';
import 'package:state_management/common/common.dart';
import 'package:state_management/features/no_package/catalog/catalog.dart';

class CatalogView extends StatelessWidget {
  const CatalogView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CoreCatalogContainer(
      listOfCatalog: _builListOfCatalog(context),
    );
  }

  Widget _builListOfCatalog(BuildContext context) {
    return FutureBuilder<List<Catalog>>(
      future: CatalogState.of(context).catalogRepository.fetch(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: snapshot.data!
                .asMap()
                .entries
                .map((entry) => CatalogItem(catalog: entry.value))
                .toList(),
          );
        } else {
          return const CoreProgressIndicator();
        }
      },
    );
  }
}
