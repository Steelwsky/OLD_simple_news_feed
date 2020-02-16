import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:simplenewsfeed/viewed.dart';
import 'package:webfeed/webfeed.dart';

//todo unit tests of controller

class ViewedNewsController {
  final _url = 'http://www.cnbc.com/id/19789731/device/rss/rss.xml';
  final _client = Client();

  final myDatabase = MyDatabase();

  final ValueNotifier<PreparedFeed> viewedState = ValueNotifier(PreparedFeed());

  Future<void> fetchNews() async {
    final res = await _client.get(_url);
    final xmlStr = res.body;
    final parsedNews = RssFeed.parse(xmlStr);
    print('fetchNews(): ${parsedNews.items}');
    checkViewedNews(parsedNews);
  }

  void addNotViewedToHistory(RssItem item, int index) async {
    if (await isNewsInHistory(item) == false) {
      myDatabase.addToViewed(item);
      final list = viewedState.value.items;
      list[index] = MyRssItem(
          item: list
              .elementAt(index)
              .item,
          isViewed: await isNewsInHistory(list
              .elementAt(index)
              .item));
      viewedState.value = PreparedFeed(items: list);
    }
  }

  Future<bool> isNewsInHistory(RssItem item) async {
    final something = await myDatabase.isViewedItem(item.guid);
    if (something != null) {
      return true;
    } else {
      return false;
    }
  }


  void deleteEntries() {
    myDatabase.deleteRows();
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
