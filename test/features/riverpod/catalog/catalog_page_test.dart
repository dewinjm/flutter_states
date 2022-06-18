import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:state_management/features/riverpod/riverpod.dart';

void main() {
  group('description', () {
    testWidgets('should render', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: CatalogPage(),
          ),
        ),
      );

      await tester.pump(const Duration(seconds: 1));
      expect(find.byType(CatalogView), findsOneWidget);
    });
  });
}
