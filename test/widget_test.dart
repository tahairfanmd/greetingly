import 'package:flutter_test/flutter_test.dart';
import 'package:greeting_card_app/main.dart';

void main() {
  testWidgets('Home screen displays the greeting card creator',
      (WidgetTester tester) async {
    await tester.pumpWidget(const GreetinglyApp());

    expect(find.text('Greetingly ✨'), findsOneWidget);
    expect(find.text('Choose an Occasion'), findsOneWidget);
    expect(find.text('Explore Card Templates'), findsOneWidget);
  });
}
