import 'package:flutter/material.dart';
import 'main.dart';
import 'package:webfeed/webfeed.dart';

//todo unit tests of controller

final ValueNotifier<SourceModel> sourceModelNotifier = ValueNotifier(sourceList[0]);

class ViewedNewsController {
  ViewedNewsController(
      {this.getRssFromUrl,
      this.myDatabase});

  final GetRssFromUrl getRssFromUrl;
  final Database myDatabase;

  // not here, in MyApp()
  final ValueNotifier<PreparedFeed> viewedState = ValueNotifier(PreparedFeed());

  Future<void> fetchNews({String link}) async {
    final RssFeed feed = await getRssFromUrl(link != null ? link : sourceModelNotifier.value.link);
    checkViewedNews(feed);
  }

  void checkViewedNews(RssFeed feed) async {
    final List<MyRssItem> listItem = List<MyRssItem>();
    final preparedFeed = PreparedFeed(items: listItem);
    print(preparedFeed.items);
    for (var i = 0; i < feed.items.length; i++) {
      preparedFeed.items.add(MyRssItem(item: feed.items[i], isViewed: await isNewsInHistory(feed.items[i])));
    }
    viewedState.value = preparedFeed;
  }

  Future<bool> isNewsInHistory(RssItem item) async {
    print('for testing isNewsInHistory intro, ${item.title} and ${item.guid}');
    if (item.guid != null) {
      return myDatabase.checkNewsInHistoryById(item.guid);
    } else {
      return myDatabase.checkNewsInHistoryByLink(item.link);
    }
  }

  void addNotViewedToHistory(RssItem item, int index) async {
    if (await isNewsInHistory(item) == false) {
      myDatabase.addItemToHistory(item);
      final list = viewedState.value.items;
      list[index] =
          MyRssItem(item: list.elementAt(index).item, isViewed: await isNewsInHistory(list.elementAt(index).item));
      viewedState.value = PreparedFeed(items: list);
    }
  }

  void deleteHistory() {
    myDatabase.deleteRows();
    myDatabase.watchAllViewedItems();
    fetchNews(link: sourceModelNotifier.value.link);
    print('db after deletion');
  }

  void watchItems(){
    myDatabase.watchAllViewedItems();
  }
}

class MyRssItem {
  MyRssItem({this.item, this.isViewed});

  final RssItem item;
  final bool isViewed;
}

class PreparedFeed {
  PreparedFeed({this.items});

  final List<MyRssItem> items;
}

class MyPageIndexController {
  final ValueNotifier<int> intState = ValueNotifier(0);

  void pageChanged(int index) {
    intState.value = index;
    print('pageChanged: ${intState.value}');
  }

  void bottomTapped(int index, PageController pageController) {
    pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);
    intState.value = index;
    print('bottomTapped: ${intState.value}');
  }
}


enum Sources { cnbc, nytimes }

class SourceModel {
  SourceModel({
    this.source,
    this.link,
    this.longName,
    this.shortName,
    this.isSelected,
  });

  final Sources source;
  final String link;
  final String longName;
  final String shortName;
  bool isSelected;
}

List<SourceModel> sourceList = [
  SourceModel(
      source: Sources.cnbc,
      link: 'https://www.cnbc.com/id/100727362/device/rss/rss.html',
      longName: 'CNBC International',
      shortName: 'CNBC',
      isSelected: true),
  SourceModel(
    source: Sources.nytimes,
    link: 'https://www.nytimes.com/svc/collections/v1/publish/https://www.nytimes.com/section/world/rss.xml',
    longName: 'The New York Times',
    shortName: 'NY Times',
    isSelected: false,
  )
];

class SourceController {
  void changingSource(int index) {
    sourceList.forEach((element) => element.isSelected = false);
    final SourceModel sm = sourceList[index];
    sm.isSelected = true;
    sourceModelNotifier.value = sm;
  }
}
