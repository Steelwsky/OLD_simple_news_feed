import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simplenewsfeed/main.dart';
import 'package:simplenewsfeed/my_app_bar.dart';
import 'package:simplenewsfeed/my_page_view.dart';
import 'package:simplenewsfeed/strings.dart';

const Duration _frameDuration = Duration(milliseconds: 200);

void main() {
  Future<void> pumpGivenApp(WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle();
  }

  testWidgets('expect tip on screen', (WidgetTester tester) async {
    await pumpGivenApp(tester);
    expect(find.byKey(Key('empty')), findsOneWidget);
  });

  //TODO not working yet
  testWidgets('expect list after pull down', (WidgetTester tester) async {
    await pumpGivenApp(tester);
    expect(find.byKey(Key('empty')), findsOneWidget);
    await tester.drag(
        find.text('Pull down to update the feed'), Offset(0.0, 500.0));
//    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
    expect(find.text('Pull down to update the feed'), findsOneWidget);
//    expect(find.byKey(Key('latest')), findsOneWidget);
//    expect(find.byIcon(Icons.bookmark_border), findsWidgets);
  }, skip: true);

  group('Testing drawer', () {

    testWidgets('expect drawer opens', (WidgetTester tester) async {
      await pumpGivenApp(tester);
      await tester.dragFrom(tester.getTopLeft(find.byType(MyAppBar)), Offset(300, 0));
      await tester.pumpAndSettle(_frameDuration);
      expect(find.text('Select news source'), findsOneWidget);

    });

    testWidgets('expect NO drawer opened', (WidgetTester tester) async {
      await pumpGivenApp(tester);
      expect(find.text('Select news source'), findsNothing);

    });

    testWidgets('expect two items in drawer', (WidgetTester tester) async {
      await pumpGivenApp(tester);
      await tester.dragFrom(tester.getTopLeft(find.byType(MyApp)), Offset(300, 0));
      await tester.pumpAndSettle();
      expect(find.byKey(ValueKey('drawerItem0')), findsOneWidget);
      expect(find.byKey(ValueKey('drawerItem1')), findsOneWidget);

    });

    //TODO not working yet
    testWidgets('expect drawer closes after a tap on one of the items', (WidgetTester tester) async {
      await pumpGivenApp(tester);
      await tester.dragFrom(tester.getTopLeft(find.byType(AppBar)), Offset(300, 0));
      await tester.pumpAndSettle(_frameDuration);
      expect(find.byKey(ValueKey('drawerItem1')), findsOneWidget);
      await tester.tap(find.byKey(ValueKey('drawerItem1')));
      await tester.pump();
    }, skip: true);
    
    group('Testing changing pages', () {

      testWidgets('Expect find items in bottomNavBar', (WidgetTester tester) async {
        await pumpGivenApp(tester);
        expect(find.byIcon(Icons.book), findsOneWidget);
        expect(find.byIcon(Icons.home), findsOneWidget);
        expect(find.text(PULL_DOWN_TO_UPDATE), findsOneWidget);
      });

      testWidgets('Expect changing AppBar title by tapping on icon in bottomNavBar', (WidgetTester tester) async {
        await pumpGivenApp(tester);
        expect(find.byIcon(Icons.book), findsOneWidget);
        await tester.tap(find.byIcon(Icons.book));
        await tester.pump();
        expect(find.text(HISTORY), findsNWidgets(2));
      });

      //TODO not working yet
      testWidgets('Expect finding No Single Record in the body after changing page', (WidgetTester tester) async {
        await pumpGivenApp(tester);
        expect(find.byIcon(Icons.book), findsOneWidget);
        await tester.tap(find.byIcon(Icons.book));
        await tester.pumpAndSettle(_frameDuration);
        expect(find.text(NO_SINGLE_RECORD), findsOneWidget);
      });

      //TODO now working yet
      testWidgets('Expect changing AppBar title by swiping page', (WidgetTester tester) async {
        await pumpGivenApp(tester);
        await tester.drag(find.byType(MyPageView), const Offset(-401.0, 0.0));
        await tester.pumpAndSettle(_frameDuration);
        expect(find.text(PULL_DOWN_TO_UPDATE), findsNothing);
//        expect(find.text(HISTORY), findsNWidgets(2));

      });


    });
    
  });

  

}


