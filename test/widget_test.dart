import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simplenewsfeed/main.dart';


void main() {
  Future<void> pumpGivenApp(WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    await tester.pump();
  }

  testWidgets('expect tip on screen', (WidgetTester tester) async {
    await pumpGivenApp(tester);
    expect(find.byKey(Key('empty')), findsOneWidget);
  });

  testWidgets('expect list after pull down', (WidgetTester tester) async {

    await pumpGivenApp(tester);
    expect(find.byKey(Key('empty')), findsOneWidget);
    await tester.drag(find.byKey(Key('empty')), const Offset(0.0, 500.0));
    await tester.pump(const Duration(seconds: 3));
    expect(find.byKey(Key('titleKey')), findsWidgets);
  });

}
