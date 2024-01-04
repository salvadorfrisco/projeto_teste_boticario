import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_teste/core/components/components.dart';

void main() {
  // Define a test. The TestWidgets function also provides a WidgetTester
  // to work with. The WidgetTester allows building and interacting
  // with widgets in the test environment.
  testWidgets('CircularProgress Widget must not contains any text',
      (tester) async {
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(const CircularProgress());

    // Create the Finders.
    final textFinder = find.text('a');

    expect(textFinder, findsNothing);
  });
}
