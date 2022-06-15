import 'dart:io' show Platform;
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
    final isMobile = Platform.isAndroid || Platform.isIOS;
    final padding = isMobile ? 0.0 : Values.paddingSmall;

    return AppBar(
      title: Text(title),
      centerTitle: true,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.of(context, rootNavigator: true).maybePop(),
        icon: const Icon(
          Icons.arrow_back_ios,
          size: Values.iconSize,
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.all(padding),
          child: IconButton(
            key: const Key('_core_app_bar_button'),
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
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
