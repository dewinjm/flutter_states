import 'package:flutter/material.dart';
import 'package:state_management/common/constant/constant.dart';

class MenuOption extends StatelessWidget {
  const MenuOption({
    required this.title,
    required this.onPress,
    Key? key,
  }) : super(key: key);

  final String title;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: Values.layoutmMaxWidth,
      ),
      child: Card(
        elevation: Values.cardElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Values.borderRadius),
        ),
        child: InkWell(
          onTap: () {
            onPress();
          },
          borderRadius: BorderRadius.circular(Values.borderRadius),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Values.padding,
              vertical: 22,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: const TextStyle(color: Palette.text)),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Palette.text,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
