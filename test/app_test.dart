import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:state_management/app/view/app.dart';
import 'package:state_management/home/home.dart';

void main() {
  group('App', () {
    testWidgets('Counter increments smoke test', (WidgetTester tester) async {
      await tester.pumpWidget(const App());

      expect(find.byType(HomePage), findsOneWidget);

      final materialApp = tester.widget<MaterialApp>(
        find.byType(MaterialApp),
      );

      expect(materialApp.title, 'Shop Example');
      expect(materialApp.debugShowCheckedModeBanner, isFalse);
    });
  });
}
