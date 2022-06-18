import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_management/common/common.dart';
import 'package:state_management/features/riverpod/riverpod.dart';

class CatalogView extends ConsumerWidget {
  const CatalogView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CatalogContainer(
      listOfCatalog: ref.watch(catalogProvider).when(
            data: ((data) {
              return Column(
                children: data
                    .asMap()
                    .entries
                    .map((entry) => CatalogItem(catalog: entry.value))
                    .toList(),
              );
            }),
            error: (err, statck) => const Center(
              child: Text('Error loading catalog'),
            ),
            loading: () => const CoreProgressIndicator(),
          ),
    );
  }
}
