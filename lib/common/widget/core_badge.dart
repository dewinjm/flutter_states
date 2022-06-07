import 'package:flutter/material.dart';
import 'package:state_management/common/constant/constant.dart';

class CoreBadge extends StatelessWidget {
  const CoreBadge({required this.count, Key? key}) : super(key: key);

  final int count;

  @override
  Widget build(BuildContext context) {
    final text = count > 10 ? '10+' : count.toString();

    return Container(
      width: 22,
      height: 22,
      decoration: const BoxDecoration(
        color: Palette.accent,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
