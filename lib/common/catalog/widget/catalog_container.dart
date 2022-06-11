import 'package:flutter/material.dart';
import 'package:state_management/common/common.dart';

class CatalogContainer extends StatelessWidget {
  const CatalogContainer({
    required this.listOfCatalog,
    Key? key,
  }) : super(key: key);

  final Widget listOfCatalog;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(Values.paddingSmall),
        child: Container(
          decoration: BoxDecoration(
            color: Palette.form,
            borderRadius: BorderRadius.circular(Values.borderRadiusDouble),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Values.paddingDouble,
                horizontal: Values.padding,
              ),
              child: listOfCatalog,
            ),
          ),
        ),
      ),
    );
  }
}
