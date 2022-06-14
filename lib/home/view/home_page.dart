import 'package:flutter/material.dart';
import 'package:state_management/common/constant/constant.dart';
import 'package:state_management/features/no_package/no_package.dart'
    as no_package;

import 'package:state_management/features/provider/provider.dart' as provider;
import 'package:state_management/home/widget/widget.dart';

const options = ['No Package', 'Provider', 'Riverpod', 'Flutter Bloc'];

enum Option {
  noPackage,
  provider,
  riverpod,
  flutterBloc,
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  children: options
                      .asMap()
                      .entries
                      .map(
                        (entry) => MenuOption(
                          key: Key('_menu_${entry.key}'),
                          title: entry.value,
                          onPress: () => _onOptionSelect(
                            context,
                            Option.values.elementAt(entry.key),
                          ),
                        ),
                      )
                      .toList(),
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

  void _onOptionSelect(BuildContext context, Option option) {
    Widget? page;

    switch (option) {
      case Option.noPackage:
        page = const no_package.CatalogPage();
        break;
      case Option.provider:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const provider.MainView()),
        );
        break;
      case Option.riverpod:
        break;
      case Option.flutterBloc:
        break;
      default:
        page = const no_package.CatalogPage();
        break;
    }

    if (page == null) return;
    Navigator.push(context, MaterialPageRoute(builder: (context) => page!));
  }
}
