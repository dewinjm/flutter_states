import 'package:flutter/material.dart';
import 'package:state_management/common/constant/constant.dart';
import 'package:state_management/home/home.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Palette.primaryMaterialColor,
      ),
      home: const HomePage(),
    );
  }
}
