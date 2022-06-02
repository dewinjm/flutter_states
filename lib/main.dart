import 'package:flutter/material.dart';
import 'package:state_management/common/constant/constant.dart';
import 'package:state_management/home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop example',
      theme: ThemeData(
        primarySwatch: Palette.primaryMaterialColor,
      ),
      home: const HomePage(),
    );
  }
}
