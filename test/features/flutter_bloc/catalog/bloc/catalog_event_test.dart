import 'package:flutter_test/flutter_test.dart';
import 'package:state_management/features/flutter_bloc/flutter_bloc.dart';

void main() {
  group('Bloc: CatalogEvent', () {
    group('CatalogStarted', () {
      test('supports value comparison', () {
        expect(CatalogStarted(), CatalogStarted());
      });
    });
  });
}
