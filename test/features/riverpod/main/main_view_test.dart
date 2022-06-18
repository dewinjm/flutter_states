import 'package:flutter_test/flutter_test.dart';
import 'package:state_management/features/riverpod/riverpod.dart';

void main() {
  group('Riverpod: MainView', () {
    testWidgets('should render', (tester) async {
      await tester.pumpWidget(const MainView());

      await tester.pump(const Duration(seconds: 1));
      expect(find.byType(CatalogView), findsOneWidget);
    });
  });
}
