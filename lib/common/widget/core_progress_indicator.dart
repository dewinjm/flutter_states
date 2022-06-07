import 'package:flutter/material.dart';
import 'package:state_management/common/common.dart';

class CoreProgressIndicator extends StatelessWidget {
  const CoreProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      color: Palette.accent,
    );
  }
}
