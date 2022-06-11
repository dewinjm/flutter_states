import 'package:flutter/material.dart';
import 'package:state_management/common/common.dart';

enum CartItemOption {
  remove,
  increase,
  decrease,
}

class CartItem extends StatelessWidget {
  const CartItem({
    required this.cart,
    required this.onChange,
    Key? key,
  }) : super(key: key);

  final Cart cart;
  final Function(CartItemOption option) onChange;

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
                  _buildRemove(),
                  _buildImageView(),
                  const SizedBox(width: 16),
                  _buildText(),
                ],
              ),
              _buildCountView()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRemove() {
    return IconButton(
      key: const Key('_cart_item_remove'),
      onPressed: () => onChange(CartItemOption.remove),
      splashRadius: 22,
      icon: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Palette.accent,
        ),
        child: const Icon(Icons.close_rounded, size: 12),
      ),
      color: Palette.form,
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
          cart.item.imageAsset,
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
              cart.item.name,
              style: const TextStyle(
                color: Palette.text,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Text(
                  '\$${cart.item.price.toString()}',
                  style: const TextStyle(
                    color: Palette.accent,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  ' / ${cart.item.unit}',
                  style: const TextStyle(color: Palette.text),
                ),
              ],
            ),
            const SizedBox(height: Values.paddingSmall),
            Text(
              '\$${(cart.amount)!.toStringAsFixed(2)}',
              style: const TextStyle(
                color: Palette.primary,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(width: Values.padding),
      ],
    );
  }

  Widget _buildCountView() {
    final disableDecrease = cart.count <= 1;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          key: const Key('_cart_item_increase'),
          onPressed: () => onChange(CartItemOption.increase),
          splashRadius: 22,
          icon: const Icon(
            Icons.add_circle,
            color: Palette.primary,
            size: Values.iconSize,
          ),
        ),
        Text(
          cart.count.toString(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        AbsorbPointer(
          absorbing: disableDecrease,
          child: IconButton(
            key: const Key('_cart_item_decrease'),
            onPressed: () => onChange(CartItemOption.decrease),
            splashRadius: 22,
            icon: Icon(
              Icons.remove_circle_outline,
              color: disableDecrease ? Palette.text : Palette.primary,
              size: Values.iconSize,
            ),
          ),
        ),
      ],
    );
  }
}
