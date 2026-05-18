import 'package:arpul_mobile/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows login screen for unauthenticated user', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: ArpulApp()));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Arpul'), findsOneWidget);
  });
}
