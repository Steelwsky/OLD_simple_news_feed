import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:simplenewsfeed/main.dart';
import 'package:simplenewsfeed/my_app_bar.dart';
import 'package:simplenewsfeed/my_page_view.dart';
import 'package:simplenewsfeed/news_controller.dart';
import 'package:simplenewsfeed/strings.dart';
import 'package:simplenewsfeed/viewed.dart';
import 'rss_fake_data_test.dart';

final NewsController viewedNewsController = NewsController();

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
      expect(find.byType(ListTile), findsWidgets);
//      expect(find.byType(ListTile), findsNWidgets(9));                          //TODO we actually don't see all 9 items due to screen size
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
      thenShouldBeInSelectedNews();
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
      await whenUserSwipesToCallDrawer(tester);
      thenShouldHaveOpenedDrawer();
    });

    testWidgets('expect drawer opens via menu button', (WidgetTester tester) async {
      await givenAppIsPumped(tester, fakeDatabase);
      await whenUserSwipesToCallDrawer(tester);
      thenShouldHaveOpenedDrawer();
    });

    testWidgets('expect NO drawer opened when app is pumped', (WidgetTester tester) async {
      await givenAppIsPumped(tester, fakeDatabase);
      thenShouldHaveClosedDrawer();
    });

    testWidgets('expect two items in opened drawer', (WidgetTester tester) async {
      await givenAppIsPumped(tester, fakeDatabase);
      await whenUserSwipesToCallDrawer(tester);
      expect(find.byKey(ValueKey('drawerItem0')), findsOneWidget);
      expect(find.byKey(ValueKey('drawerItem1')), findsOneWidget);
      expect(find.byType(ListTile), findsNWidgets(2));
    });

    testWidgets('expect one source is selected and another is not in opened drawer', (WidgetTester tester) async {
      await givenAppIsPumped(tester, fakeDatabase);
      await whenUserSwipesToCallDrawer(tester);
      expect(find.byIcon(Icons.radio_button_unchecked), findsOneWidget);
      expect(find.byIcon(Icons.radio_button_checked), findsOneWidget);
    });

    testWidgets('expect drawer closes after a tap on one of the items ', (WidgetTester tester) async {
      await givenAppIsPumped(tester, fakeDatabase);
      await whenUserSwipesToCallDrawer(tester);
      expect(find.byKey(ValueKey('drawerItem1')), findsOneWidget);
      await tester.tap(find.byKey(ValueKey('drawerItem1')));
      await tester.pumpAndSettle();
      thenShouldHaveClosedDrawer();
    });

    testWidgets('drawer closes after a tap on one of the items and find news in the list', (WidgetTester tester) async {
      await givenAppIsPumped(tester, fakeDatabase);
      await whenUserSwipesToCallDrawer(tester);
      expect(find.byKey(ValueKey('drawerItem1')), findsOneWidget);
      await tester.tap(find.byKey(ValueKey('drawerItem1')));
      await tester.pumpAndSettle();
      thenShouldHaveClosedDrawer();
      thenUserShouldSeeListOfNews();
    });

    testWidgets('expect title changes in AppBar after news source is picked by user', (WidgetTester tester) async {
      await givenAppIsPumped(tester, fakeDatabase);
      expect(find.text('Home - CNBC'), findsOneWidget);
      expect(find.text('Home - NY Times'), findsNothing);
      await whenUserSwipesToCallDrawer(tester);
      expect(find.byKey(ValueKey('drawerItem1')), findsOneWidget);
      await tester.tap(find.byKey(ValueKey('drawerItem1')));
      await tester.pumpAndSettle();
      thenShouldHaveClosedDrawer();
      expect(find.text('Home - NY Times'), findsOneWidget);
      expect(find.text('Home - CNBC'), findsNothing);
    });

    testWidgets('expect drawer has still 1 selected and 1 unseleted items after one of them was taped',
        (WidgetTester tester) async {
      await givenAppIsPumped(tester, fakeDatabase);
      await whenUserSwipesToCallDrawer(tester);
      expect(find.byKey(ValueKey('drawerItem1')), findsOneWidget);
      await tester.tap(find.byKey(ValueKey('drawerItem1')));
      await tester.pumpAndSettle();
      thenUserShouldSeeListOfNews();
      await whenUserSwipesToCallDrawer(tester);
      expect(find.byIcon(Icons.radio_button_unchecked), findsOneWidget);
      expect(find.byIcon(Icons.radio_button_checked), findsOneWidget);
    });

    testWidgets('expect drawer closes after user taps outside of drawer. Drawer\'s width by default is 304.0',
        (WidgetTester tester) async {
      await givenAppIsPumped(tester, fakeDatabase);
      await whenUserSwipesToCallDrawer(tester);
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
      await whenUserSelectsHistoryTabInNavBar(tester);
      thenShouldHaveHistoryPage();
    });

    testWidgets('Expect finding No Single Record in the body after changing page', (WidgetTester tester) async {
      await givenAppIsPumped(tester, fakeDatabase);
      expect(find.byIcon(Icons.book), findsOneWidget);
      await whenUserSelectsHistoryTabInNavBar(tester);
      thenShouldHaveHistoryPage();
    });

    testWidgets('Expect changing AppBar title by swiping page', (WidgetTester tester) async {
      await givenAppIsPumped(tester, fakeDatabase);
      await whenUserSwipeToChangePage(tester);
      thenShouldHaveHistoryPage();
    });
  });


  group('testing history page', () {
    testWidgets('Should see a fake history list', (WidgetTester tester) async {
      await givenAppIsPumped(tester, fakeDatabase);
      await whenUserPullsToRefresh(tester);
      await whenUserSwipeToChangePage(tester);
      thenShouldHaveHistoryPage();
      thenShouldSeeListOfHistoryNews();
    });

    testWidgets('history item should be opened by tapping on it', (WidgetTester tester) async {
      await givenAppIsPumped(tester, fakeDatabase);
      await whenUserPullsToRefresh(tester);
      await whenUserSwipeToChangePage(tester);
      thenShouldHaveHistoryPage();
      thenShouldSeeListOfHistoryNews();
      await whenUserTapsToNews(tester);
      thenShouldBeInSelectedNews();
    });

    testWidgets('should be in history news list after closing selected news page ', (WidgetTester tester) async {
      await givenAppIsPumped(tester, fakeDatabase);
      await whenUserPullsToRefresh(tester);
      await whenUserSwipeToChangePage(tester);
      thenShouldHaveHistoryPage();
      thenShouldSeeListOfHistoryNews();
      await whenUserTapsToNews(tester);
      thenShouldBeInSelectedNews();
      await whenUserTapsToBackButtonIcon(tester);
      thenShouldHaveHistoryPage();
      thenShouldSeeListOfHistoryNews();
    });

    testWidgets('History list should have 7 items instead of 6 after one news was watched',
        (WidgetTester tester) async {
      await givenAppIsPumped(tester, fakeDatabase);
      await whenUserPullsToRefresh(tester);
      await whenUserTapsToNews(tester);
      await whenUserTapsToBackButtonIcon(tester);
      await whenUserSwipeToChangePage(tester);
      expect(find.byType(ListTile), findsNWidgets(7));
    });

    testWidgets('history should be empty after when taps delete from home page', (WidgetTester tester) async {
      await givenAppIsPumped(tester, fakeDatabase);
      await whenUserPullsToRefresh(tester);
      await whenUserTapsToDeleteIcon(tester);
      await whenUserSwipeToChangePage(tester);
      expect(find.byType(ListTile), findsNothing);
      thenShouldHaveEmptyHistoryList();
    });



//    testWidgets('history list should be empty after deletion by tapping Delete icon WHILE being on history page', (WidgetTester tester) async {
    testWidgets('should clear history list when taps delete from history page', (WidgetTester tester) async {
      await givenAppIsPumped(tester, fakeDatabase);
      await whenUserPullsToRefresh(tester);
      await whenUserSwipeToChangePage(tester);
      await whenUserTapsToDeleteIcon(tester);
      expect(find.byType(ListTile), findsNothing);
      thenShouldHaveEmptyHistoryList();
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

void thenUserShouldSeeListOfNews() {
  expect(find.text(fakePreparedFeed.items.first.item.description), findsOneWidget);
  expect(find.text(CONTINUE_READING), findsNothing);
  expect(find.byType(BackButtonIcon), findsNothing);
  expect(find.byType(ListTile), findsWidgets);
}

void thenShouldHaveOpenedDrawer() {
  expect(find.text(SELECT_SOURCE_NEWS), findsOneWidget);
}

void thenShouldHaveClosedDrawer() {
  expect(find.text(SELECT_SOURCE_NEWS), findsNothing);
}

void thenShouldHaveHistoryPage() {
  expect(find.text(PULL_DOWN_TO_UPDATE), findsNothing);
  expect(find.byKey(PageStorageKey('history')), findsOneWidget);
  expect(find.text(HISTORY), findsNWidgets(2));
}

void thenShouldSeeListOfHistoryNews() {
  expect(find.byType(ListTile), findsNWidgets(6));
}

void thenShouldBeInSelectedNews() {
  expect(find.text(CONTINUE_READING), findsOneWidget);
  expect(find.byIcon(Icons.open_in_new), findsOneWidget);
  expect(find.byType(BackButtonIcon), findsOneWidget);
}

void thenShouldHaveEmptyHistoryList() {
  expect(find.text(EMPTY_LIST), findsOneWidget);
}

Future whenUserPullsToRefresh(WidgetTester tester) async {
  await tester.drag(find.byType(RefreshIndicator), Offset(100.0, 500.0));
  await tester.pumpAndSettle();
}

Future whenUserSwipesToCallDrawer(WidgetTester tester) async {
  await tester.dragFrom(tester.getTopLeft(find.byType(MyAppBar)), Offset(300, 0));
  await tester.pumpAndSettle();
}

Future whenUserTapsToMenuIconToCallDrawer(WidgetTester tester) async {
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

Future whenUserSwipeToChangePage(WidgetTester tester) async {
  await tester.fling(find.byType(MyPageView), Offset(-300.0, 0.0), 1000);
  await tester.pumpAndSettle();
}

Future whenUserSelectsHistoryTabInNavBar(WidgetTester tester) async {
  await tester.tap(find.byIcon(Icons.book));
  await tester.pumpAndSettle();

}

Future whenUserTapsToDeleteIcon(WidgetTester tester) async { //taps delete icon
  await tester.tap(find.byIcon(Icons.delete));
  await tester.pumpAndSettle();

}


class FakeDatabase implements Database {
//List<ViewedItem> fakeListViewedHistory = <List<ViewedItem>>.value(fakeViewedHistory);
//List<ViewedItem> fakeEmptyListViewedHistory = Stream<List<ViewedItem>>.value(fakeEmptyViewedHistory);

//  void thenShouldHaveInHistory(String id) {
//    expect(fakeHistory, contains(id));
//  }

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
        }
        fakeViewedHistory.add(viewed);
        print('ADDED NEW ITEM: ${fakeViewedHistory.last.title}');
      };

  @override
  CheckNewsInHistoryById get checkNewsInHistoryById => (id) {
        bool myBool = false;
        for (var i = 0; i < fakeViewedHistory.length; i++) {
          if (fakeViewedHistory[i].id == id) {
            myBool = true;
          }
        }
        print('bool is: $myBool');
        return Future.value(myBool);
      };

  @override
  CheckNewsInHistoryByLink get checkNewsInHistoryByLink => (link) {
        bool myBool = false;
        for (var i = 0; i < fakeViewedHistory.length; i++) {
          if (fakeViewedHistory[i].link == link) {
            myBool = true;
          }
        }
        return Future.value(myBool);
      };

  Completer<void> deleteRowsCompleter = Completer(); //

//  Completer<List<ViewedItem>> completer = Completer();

  @override
//  DeleteRows get deleteRows => () async {
  DeleteRows get deleteRows => () {
    fakeViewedHistory = [];
    return deleteRowsCompleter.future;
  };


  @override
  GetAllViewedItems get getAllViewedItems => () => Future.value(fakeViewedHistory);
}

//StreamController streamController = StreamController();
