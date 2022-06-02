import 'package:flutter/material.dart';
import 'package:state_management/common/constant/constant.dart';
import 'package:state_management/home/widget/github.dart';
import 'package:state_management/home/widget/widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final options = ['No Package', 'Provider', 'RiverPod', 'Flutter Bloc'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter State Managament'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Values.padding),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: Values.padding),
                const Text(
                  'Shopping cart example with state management',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: Values.padding),
                const Image(
                  image: AssetImage('assets/images/logo.png'),
                  width: 130,
                ),
                const SizedBox(height: Values.padding),
                Column(
                  children: List.from(
                    options.map(
                      (option) => MenuOption(
                        title: option,
                        onPress: () {},
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: Values.paddingDouble),
                const Github(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
