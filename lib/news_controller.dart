import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:simplenewsfeed/viewed.dart';
import 'package:webfeed/webfeed.dart';

//todo unit tests of controller

final ValueNotifier<MyDatabase> database = ValueNotifier(MyDatabase());


class ViewedNewsController {
  final _client = http.Client();

  final ValueNotifier<PreparedFeed> viewedState = ValueNotifier(PreparedFeed());

  Future<void> fetchNews() async {
    final res = await _client.get(_sourceLink(sourceNotifier.value));
    final xmlStr = res.body;
    final parsedNews = RssFeed.parse(xmlStr);
    print('fetchNews(): ${parsedNews.items}');
    checkViewedNews(parsedNews);
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

  void deleteEntries() {
    database.value.deleteRows();
    database.value.watchAllViewedItems();
    fetchNews();
    print('db after deletion');
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

enum Sources {cnbc, nytimes}

final ValueNotifier<Sources> sourceNotifier = ValueNotifier(Sources.cnbc);

_sourceLink(Sources sources) {
  switch (sources) {
    case Sources.cnbc:
      return 'http://www.cnbc.com/id/19789731/device/rss/rss.xml';
    case Sources.nytimes:
      return 'https://www.nytimes.com/svc/collections/v1/publish/https://www.nytimes.com/section/world/rss.xml';
  }
}

changeSource(Sources sources) {
  sourceNotifier.value = sources;
  print('source is: ${sourceNotifier.value}');
}

nameOfSource (Sources sources) {
  switch (sources) {
    case Sources.cnbc:
      return 'CNBC';
    case Sources.nytimes:
      return 'NY Times';
  }
}
