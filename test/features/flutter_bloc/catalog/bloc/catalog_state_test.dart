// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:state_management/common/common.dart';
import 'package:state_management/features/flutter_bloc/flutter_bloc.dart';

void main() {
  group('Bloc: CatalogState', () {
    group('CatalogLoading', () {
      test('supports value comparison', () {
        expect(CatalogLoading(), CatalogLoading());
      });
    });

    group('CatalogLoaded', () {
      test('supports value comparison', () {
        const catalog = [
          Catalog(
            id: 1,
            name: 'fake_name',
            price: 2,
            unit: '1lb',
            imageAsset: 'assets/images/tomatoes.png',
          ),
        ];

        expect(CatalogLoaded(catalog), CatalogLoaded(catalog));
      });
    });
  });
}
