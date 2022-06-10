import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:state_management/common/common.dart';

import '../../../helpers/helpers.dart';

void main() {
  group('CartPaymentSuccess', () {
    testWidgets('should renders', (tester) async {
      await tester.pumpApp(const CartPaymentSuccess());

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Payment success'), findsOneWidget);
    });
  });
}
