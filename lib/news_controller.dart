import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:simplenewsfeed/viewed.dart';
import 'package:webfeed/webfeed.dart';

//todo unit tests of controller

final ValueNotifier<MyDatabase> database = ValueNotifier(MyDatabase());

final ValueNotifier<SourceModel> sourceModelNotifier =
ValueNotifier(sourceList[0]);


class ViewedNewsController {
  final _client = http.Client();
  final ValueNotifier<PreparedFeed> viewedState = ValueNotifier(PreparedFeed());

  Future<void> fetchNews({String link}) async {
    final res = await _client.get(link != null ? link : sourceModelNotifier.value.link);
    if (res.statusCode == 200) {
      final xmlStr = res.body;
      final parsedNews = RssFeed.parse(xmlStr);
      print('fetchNews(): ${parsedNews.items}');
      checkViewedNews(parsedNews);
    } else {
      throw Exception('Failed to load data');
    }

  }

  void addNotViewedToHistory(RssItem item, int index) async {
    if (await isNewsInHistory(item) == false) {
      database.value.addToViewed(item);
      final list = viewedState.value.items;
      list[index] = MyRssItem(
          item: list.elementAt(index).item,
          isViewed: await isNewsInHistory(list.elementAt(index).item));
      viewedState.value = PreparedFeed(items: list);
    }
  }

  Future<bool> isNewsInHistory(RssItem item) async {
    ViewedItem _isViewed;
    if (item.guid != null) {
      _isViewed = await database.value.isViewedItemById(item.guid);
    } else {
      _isViewed = await database.value.isViewedItemByLink(item.link);
    }
    if (_isViewed != null) {
      return true;
    } else {
      return false;
    }
  }

  void checkViewedNews(RssFeed feed) async {
    final List<MyRssItem> listItem = List<MyRssItem>();
    final preparedFeed = PreparedFeed(items: listItem);
    for (var i = 0; i < feed.items.length; i++) {
      preparedFeed.items.add(MyRssItem(
          item: feed.items[i], isViewed: await isNewsInHistory(feed.items[i])));
    }
    viewedState.value = preparedFeed;
  }

  void deleteHistory() {
    database.value.deleteRows();
    database.value.watchAllViewedItems();
    fetchNews(link: sourceModelNotifier.value.link);
    print('db after deletion');
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
    print('pagecontroller index: ${pageController.initialPage}');
    pageController.animateToPage(index,
        duration: Duration(milliseconds: 500), curve: Curves.ease);

    intState.value = index;
    print('bottomTapped: ${intState.value}');
  }
}

class MyPageController {
  MyPageController({this.pageController});

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );
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
      link: 'http://www.cnbc.com/id/19789731/device/rss/rss.xml',
      longName: 'CNBC International',
      shortName: 'CNBC',
      isSelected: true),
  SourceModel(
    source: Sources.nytimes,
    link:
    'https://www.nytimes.com/svc/collections/v1/publish/https://www.nytimes.com/section/world/rss.xml',
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
