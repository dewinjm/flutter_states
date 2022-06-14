import 'package:flutter/material.dart';
import 'package:state_management/common/common.dart';
import 'package:state_management/features/provider/catalog/provider/provider.dart';
import 'package:state_management/features/provider/catalog/widgets/widgets.dart';

class CatalogView extends StatelessWidget {
  const CatalogView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CatalogContainer(
      listOfCatalog: FutureBuilder<List<Catalog>>(
        future: context.read<CatalogProvider>().fetch(),
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
      ),
    );
  }
}
