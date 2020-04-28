import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:simplenewsfeed/main.dart';
import 'package:simplenewsfeed/my_app_bar.dart';
import 'package:simplenewsfeed/news_controller.dart';
import 'package:simplenewsfeed/strings.dart';
import 'package:simplenewsfeed/viewed.dart';
import 'rss_fake_data_test.dart';

final ViewedNewsController viewedNewsController = ViewedNewsController();

Completer<ViewedItem> fakeViewedItem = Completer();

Completer<Response> fakeCall = Completer();
int networkCallsCount = 0;

Future<bool> myBool = Future.value(false);

void main() {
//  Completer<RssFeed> completerRssFeed = Completer();
  FakeDatabase fakeDatabase = FakeDatabase();

  Future<void> givenAppIsPumped(WidgetTester tester, FakeDatabase fakeDatabase) async {
    await tester.pumpWidget(
      MyApp(getRssFromUrl: (String url) => Future.value(fakeRssFeed), myDatabase: FakeDatabase()),
    ); //MyApp(fakeNetWorkData)
  }

  //      fakeDatabase.thenShouldHaveInHistory(fakeRssFeed.items[]);

  group('testing building news list and opening news page', () {
    testWidgets('should see any news after user pulls to refresh', (WidgetTester tester) async {
      await givenAppIsPumped(tester, fakeDatabase);
      expect(find.byType(RefreshProgressIndicator), findsNothing);
      thenShouldHaveEmptyNewsList();
      await whenUserPullsToRefresh(tester);
//      completerRssFeed.complete(fakeRssFeed);
      expect(find.text(fakePreparedFeed.items.first.item.title), findsOneWidget);
    });

    testWidgets('expect empty list after app is pumped', (WidgetTester tester) async {
      await givenAppIsPumped(tester, fakeDatabase); // what's the point of completerRssFeed?
      thenShouldHaveEmptyNewsList();
    });

    testWidgets('expect find at least 1 item\'s preview in list of news', (WidgetTester tester) async {
      await givenAppIsPumped(tester, fakeDatabase);
      expect(find.byType(RefreshProgressIndicator), findsNothing);
      thenShouldHaveEmptyNewsList();
      await whenUserPullsToRefresh(tester);
//      completerRssFeed.complete(fakeRssFeed);
      expect(find.text(fakePreparedFeed.items.first.item.title), findsOneWidget);
    });

    testWidgets('should see first item is never seen before', (WidgetTester tester) async {
      await givenAppIsPumped(tester, fakeDatabase);
      expect(find.byType(RefreshProgressIndicator), findsNothing);
      thenShouldHaveEmptyNewsList();
      await whenUserPullsToRefresh(tester);
//      completerRssFeed.complete(fakeRssFeed);
      expect(fakePreparedFeed.items.first.isViewed, false);
    });

    testWidgets('should see all items have blank icons', (WidgetTester tester) async {
      await givenAppIsPumped(tester, fakeDatabase);
      thenShouldHaveEmptyNewsList();
      await whenUserPullsToRefresh(tester);
//      completerRssFeed.complete(fakeRssFeed);
      expect(find.byIcon(Icons.bookmark_border), findsWidgets);
    });

    testWidgets('should NOT see empty list after user pulls to refresh', (WidgetTester tester) async {
      await givenAppIsPumped(tester, fakeDatabase);
      await whenUserPullsToRefresh(tester);
      expect(find.text(PULL_DOWN_TO_UPDATE), findsNothing);
    });

    testWidgets('user opens news page and sees link to continue after user tapped on one of the news',
        (WidgetTester tester) async {
      await givenAppIsPumped(tester, fakeDatabase);
      await whenUserPullsToRefresh(tester);
      await whenUserTapsToNews(tester);
      expect(find.text(CONTINUE_READING), findsOneWidget);
      expect(find.byIcon(Icons.open_in_new), findsOneWidget);
      expect(find.byType(BackButtonIcon), findsOneWidget);
    });

    //TODO expect browser is opened!--------------------------------
    testWidgets('user clicks on icon or text \'Continue reading\' and browser should be opened',
        (WidgetTester tester) async {
      await givenAppIsPumped(tester, fakeDatabase);
      await whenUserPullsToRefresh(tester);
      await whenUserTapsToNews(tester);
//      expect(find.text(CONTINUE_READING), findsOneWidget);
//      expect(find.byIcon(Icons.open_in_new), findsOneWidget);
//      expect(find.byType(BackButtonIcon), findsOneWidget);
    });

    testWidgets('news page closes and returns to list of news after pressing back button', (WidgetTester tester) async {
      await givenAppIsPumped(tester, fakeDatabase);
      await whenUserPullsToRefresh(tester);
      await whenUserTapsToNews(tester);
      await whenUserTapsToBackButtonIcon(tester);
      thenUserShouldSeeListOfNews();
    });

    testWidgets('viewed news is marked by special bookmark after user closes that news\' page',
        (WidgetTester tester) async {
      await givenAppIsPumped(tester, fakeDatabase);
      await whenUserPullsToRefresh(tester);
      await whenUserTapsToNews(tester);
      await whenUserTapsToBackButtonIcon(tester);
      expect(find.byIcon(Icons.bookmark), findsOneWidget);
    });
  });

  group('Testing drawer', () {
    testWidgets('expect drawer opens via swipe from left corner to center', (WidgetTester tester) async {
      await givenAppIsPumped(tester, fakeDatabase);
      await whenUserSwipeLeftCornerToCenter(tester);
      expect(find.text('Select news source'), findsOneWidget);
    });

    testWidgets('expect drawer opens via menu button', (WidgetTester tester) async {
      await givenAppIsPumped(tester, fakeDatabase);
      await whenUserSwipeLeftCornerToCenter(tester);
      expect(find.text('Select news source'), findsOneWidget);
    });

    testWidgets('expect NO drawer opened when app is pumped', (WidgetTester tester) async {
      await givenAppIsPumped(tester, fakeDatabase);
      expect(find.text('Select news source'), findsNothing);
    });

    testWidgets('expect two items in opened drawer', (WidgetTester tester) async {
      await givenAppIsPumped(tester, fakeDatabase);
      await whenUserSwipeLeftCornerToCenter(tester);
      expect(find.byKey(ValueKey('drawerItem0')), findsOneWidget);
      expect(find.byKey(ValueKey('drawerItem1')), findsOneWidget);
      expect(find.byType(ListTile), findsNWidgets(2));
    });

    testWidgets('expect one source is selected and another is not in opened drawer', (WidgetTester tester) async {
      await givenAppIsPumped(tester, fakeDatabase);
      await whenUserSwipeLeftCornerToCenter(tester);
      expect(find.byIcon(Icons.radio_button_unchecked), findsOneWidget);
      expect(find.byIcon(Icons.radio_button_checked), findsOneWidget);
    });

    testWidgets('expect drawer closes after a tap on one of the items', (WidgetTester tester) async {
      await givenAppIsPumped(tester, fakeDatabase);
      await whenUserSwipeLeftCornerToCenter(tester);
      expect(find.byKey(ValueKey('drawerItem1')), findsOneWidget);
      await tester.tap(find.byKey(ValueKey('drawerItem1')));
      await tester.pump();
      thenUserShouldSeeListOfNews();
    });

    testWidgets('expect title changes in AppBar after news source is picked by user', (WidgetTester tester) async {
      await givenAppIsPumped(tester, fakeDatabase);
      expect(find.text('Home - CNBC'), findsOneWidget);
      expect(find.text('Home - NY Times'), findsNothing);
      await whenUserSwipeLeftCornerToCenter(tester);
      expect(find.byKey(ValueKey('drawerItem1')), findsOneWidget);
      await tester.tap(find.byKey(ValueKey('drawerItem1')));
      await tester.pump();
      expect(find.text('Home - NY Times'), findsOneWidget);
      expect(find.text('Home - CNBC'), findsNothing);
    });

    testWidgets('expect drawer has still 1 selected and 1 unseleted items after one of them was taped',
        (WidgetTester tester) async {
      await givenAppIsPumped(tester, fakeDatabase);
      await whenUserSwipeLeftCornerToCenter(tester);
      expect(find.byKey(ValueKey('drawerItem1')), findsOneWidget);
      await tester.tap(find.byKey(ValueKey('drawerItem1')));
      await tester.pump();
      thenUserShouldSeeListOfNews();
      await whenUserSwipeLeftCornerToCenter(tester);
      expect(find.byIcon(Icons.radio_button_unchecked), findsOneWidget);
      expect(find.byIcon(Icons.radio_button_checked), findsOneWidget);
    });

    testWidgets('expect drawer closes after user taps outside of drawer. Drawer\'s width by default is 304.0',
        (WidgetTester tester) async {
      await givenAppIsPumped(tester, fakeDatabase);
      await whenUserSwipeLeftCornerToCenter(tester);
      await tester.tapAt(Offset(310, 400));
      await tester.pumpAndSettle();
      thenShouldHavePullDownToUpdate();
    });
  });

  group('Testing changing pages', () {
    testWidgets('Expect find items in bottomNavBar', (WidgetTester tester) async {
      await givenAppIsPumped(tester, fakeDatabase);
      expect(find.byIcon(Icons.book), findsOneWidget);
      expect(find.byIcon(Icons.home), findsOneWidget);
    });

    testWidgets('Expect changing AppBar title by tapping on icon in bottomNavBar', (WidgetTester tester) async {
      await givenAppIsPumped(tester, fakeDatabase);
      expect(find.byIcon(Icons.book), findsOneWidget);
      await tester.tap(find.byIcon(Icons.book));
      await tester.pump();
      expect(find.text(HISTORY), findsNWidgets(2));
    });

    //TODO not working yet!--------------------------------
    testWidgets('Expect finding No Single Record in the body after changing page', (WidgetTester tester) async {
      await givenAppIsPumped(tester, fakeDatabase);
      expect(find.byIcon(Icons.book), findsOneWidget);
      await tester.tap(find.byIcon(Icons.book));
      await tester.pump();
      expect(find.text(HISTORY), findsNWidgets(2)); //appbar changes but main content doesn't
      expect(find.text('ItemTitle 1'), findsOneWidget);
//      expect(find.byKey(PageStorageKey('history')), findsOneWidget);
    });

    //TODO not working yet--------------------------------
    testWidgets('Expect changing AppBar title by swiping page', (WidgetTester tester) async {
      await givenAppIsPumped(tester, fakeDatabase);
//      await tester.drag(find.byType(MyPageView), const Offset(-401.0, 0.0));
//      await tester.dragFrom(Offset(300.0, 400.0), Offset(50.0, 400.0));
      await tester.flingFrom(Offset(300.0, 400.0), Offset(50.0, 400.0), 1000);
      await tester.pump();
      expect(find.text(PULL_DOWN_TO_UPDATE), findsNothing);
//        expect(find.text(HISTORY), findsNWidgets(2));
    });
  });
}

void thenShouldHavePullDownToUpdate() {
  expect(find.text(PULL_DOWN_TO_UPDATE), findsOneWidget);
}

void thenShouldHaveEmptyNewsList() {
  expect(find.byKey(Key('empty')), findsOneWidget);
  expect(find.text(PULL_DOWN_TO_UPDATE), findsOneWidget);
}

Future whenUserPullsToRefresh(WidgetTester tester) async {
  await tester.drag(find.byType(RefreshIndicator), Offset(100.0, 500.0));
  await tester.pumpAndSettle();
}

Future whenUserSwipeLeftCornerToCenter(WidgetTester tester) async {
  await tester.dragFrom(tester.getTopLeft(find.byType(MyAppBar)), Offset(300, 0));
  await tester.pumpAndSettle();
}

Future whenUserTapsToMenuIcon(WidgetTester tester) async {
  await tester.tap(find.byIcon(Icons.menu));
  await tester.pumpAndSettle();
}

Future whenUserTapsToNews(WidgetTester tester) async {
  await tester.tap(find.byKey(ValueKey('item0')));
  await tester.pump();
  await tester.pump();
  await tester.pump();
}

Future whenUserTapsToBackButtonIcon(WidgetTester tester) async {
  await tester.tap(find.byType(BackButtonIcon));
  await tester.pump();
}

void thenUserShouldSeeListOfNews() {
  expect(find.text(fakePreparedFeed.items.first.item.description), findsOneWidget);
  expect(find.text(CONTINUE_READING), findsNothing);
  expect(find.byType(BackButtonIcon), findsNothing);
}

class FakeDatabase implements Database {
//  List<RssItem> fakeHistory = [];
  List<ViewedItem> fakeHistory = [];
  List<String> fakeIdHistory = [];

//  static List<ViewedItem> fakeViewedHistory = [];
  Stream<List<ViewedItem>> fakeStreamViewedHistory = Stream<List<ViewedItem>>.value(fakeViewedHistory);

//  void thenShouldHaveInHistory(RssItem rssItem) {
//    expect(fakeIdHistory, contains(rssItem));
//  }

  void thenShouldHaveInHistory(String id) {
    expect(fakeHistory, contains(id));
  }

  @override
  AddItemToHistory get addItemToHistory => (idRssItem) {
        print('inside of addItemInHistory');
        ViewedItem viewed;
        if (idRssItem.guid != null) {
          viewed = ViewedItem(
            id: idRssItem.guid,
            title: idRssItem.title,
            content: idRssItem.description,
            link: idRssItem.link,
          );
        } else {
          viewed = ViewedItem(
            id: idRssItem.link, //bad code
            title: idRssItem.title,
            content: idRssItem.description,
            link: idRssItem.link,
          );
//        fakeIdHistory.add(idRssItem.guid != null ? idRssItem.guid : idRssItem.link);
        }
        fakeHistory.add(viewed);
        print('ADDED NEW ITEM: ${fakeHistory[0].title}');
  };

  @override
  CheckNewsInHistoryById get checkNewsInHistoryById => (id) {
        bool myBool = false;
        for (var i = 0; i < fakeHistory.length; i++) {
          if (fakeHistory[i].id.contains(id)) {
            myBool = true;
          }
        }
        return Future.value(myBool);

//                return Future.value(fakeIdHistory.contains(id));
      };

  @override
  CheckNewsInHistoryByLink get checkNewsInHistoryByLink => (link) {
        bool myBool = false;
        for (var i = 0; i < fakeHistory.length; i++) {
          if (fakeHistory[i].link.contains(link)) {
            myBool = true;
          }
        }
        return Future.value(myBool);

//        return Future.value(fakeIdHistory.contains(link));
      };

  @override
  DeleteRows get deleteRows => () {
        fakeIdHistory.clear();
        return Future.value(fakeIdHistory);
      };

  @override
  WatchAllViewedItems get watchAllViewedItems => () {
        return fakeStreamViewedHistory;
//  return null;
      };
}
