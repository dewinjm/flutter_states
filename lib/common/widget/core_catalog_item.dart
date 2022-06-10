import 'package:flutter/material.dart';
import 'package:state_management/common/catalog/model/catalog.dart';
import 'package:state_management/common/constant/constant.dart';

class CoreCatalogItem extends StatelessWidget {
  const CoreCatalogItem({
    required this.onPressed,
    required this.catalog,
    Key? key,
  }) : super(key: key);

  final Catalog catalog;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: Values.layoutmMaxWidth,
      ),
      child: Card(
        elevation: Values.cardElevation,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Values.borderRadius),
        ),
        child: Padding(
          padding: const EdgeInsets.all(Values.paddingSmall),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  _buildImageView(),
                  const SizedBox(width: 16),
                  _buildText(),
                ],
              ),
              IconButton(
                key: Key('_core_catalog_item_${catalog.id}'),
                onPressed: () => onPressed(),
                splashRadius: 28,
                icon: const Icon(
                  Icons.add_circle,
                  color: Palette.primary,
                  size: Values.iconSize,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageView() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Palette.form,
        borderRadius: BorderRadius.circular(Values.borderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          catalog.imageAsset,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildText() {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              catalog.name,
              style: const TextStyle(
                color: Palette.text,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: Values.paddingSmall),
            Row(
              children: [
                Text(
                  '\$${catalog.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Palette.accent,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  ' / ${catalog.unit}',
                  style: const TextStyle(color: Palette.text),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(width: 16),
      ],
    );
  }
}
