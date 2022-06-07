import 'package:flutter/material.dart';
import 'package:state_management/common/constant/constant.dart';

class CoreAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CoreAppBar({
    required this.title,
    required this.badge,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final String title;
  final Widget badge;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      elevation: 0,
      actions: [
        IconButton(
          onPressed: () => onPressed(),
          icon: Stack(
            children: [
              const Icon(
                Icons.shopping_cart_sharp,
                size: Values.iconSize,
              ),
              Positioned(
                top: 0,
                right: 0,
                child: badge,
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
