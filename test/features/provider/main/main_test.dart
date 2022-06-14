import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:state_management/features/provider/provider.dart';

void main() {
  group('Provider: MainView', () {
    testWidgets('should render', (tester) async {
      await tester.pumpWidget(const MainView());
      await tester.pump(const Duration(seconds: 1));

      expect(find.byType(MultiProvider), findsOneWidget);
      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });
}
