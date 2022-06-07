import 'package:flutter_test/flutter_test.dart';
import 'package:state_management/home/home.dart';

import '../../helpers/helpers.dart';

void main() {
  group('HomePage', () {
    testWidgets('renders', (tester) async {
      await tester.pumpApp(const HomePage());

      expect(
        find.text('Flutter State Managament'),
        findsWidgets,
      );
      expect(
        find.text('Shopping cart example with state management'),
        findsWidgets,
      );
    });
  });
}
