import 'package:flutter_test/flutter_test.dart';
import 'package:bubmle_kel9/main.dart';

void main() {
  testWidgets('Bumble app starts', (WidgetTester tester) async {
    await tester.pumpWidget(const BumbleApp());

    expect(find.text('bumble'), findsOneWidget);
  });
}