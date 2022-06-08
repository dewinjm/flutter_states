import 'package:flutter/material.dart';
import 'package:state_management/common/constant/constant.dart';

class Github extends StatelessWidget {
  const Github({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/images/github.png',
          width: 48,
        ),
        const Text(
          'dewinjm',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
