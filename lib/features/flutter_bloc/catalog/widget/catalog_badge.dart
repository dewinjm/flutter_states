import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management/common/widget/widget.dart';
import 'package:state_management/features/flutter_bloc/cart/bloc/cart_bloc.dart';

class CatalogBadge extends StatelessWidget {
  const CatalogBadge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        final count = state.items.length;
        if (count <= 0) {
          return const SizedBox();
        } else {
          return CoreBadge(count: state.items.length);
        }
      },
    );
  }
}
