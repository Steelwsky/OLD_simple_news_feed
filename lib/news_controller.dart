import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:webfeed/webfeed.dart';

class ViewedNewsController {
  final _url = 'http://www.cnbc.com/id/19789731/device/rss/rss.xml';
  final _client = Client();

  final Set<String> _newsAlreadyViewed = Set.from([]);

  final ValueNotifier<PreparedFeed> viewedState = ValueNotifier(PreparedFeed());

  Future<void> fetchNews() async {
    final res = await _client.get(_url);
    final xmlStr = res.body;
    final parsedNews = RssFeed.parse(xmlStr);
    print(parsedNews.items);
    checkViewedNews(parsedNews);
  }

  void addNotViewedToHistory(String guid, int index) {
    _newsAlreadyViewed.add(guid);
    final list = viewedState.value.items;
    list[index] = MyRssItem(
        item: list.elementAt(index).item,
        isViewed: isNewsInHistory(list.elementAt(index).item));
    viewedState.value = PreparedFeed(items: list);
  }

  bool isNewsInHistory(RssItem item) {
    if (_newsAlreadyViewed.contains(item.guid)) {
      return true;
    } else {
      return false;
    }
  }

  void checkViewedNews(RssFeed feed) {
    final List<MyRssItem> listItem = List<MyRssItem>();
    final preparedFeed = PreparedFeed(items: listItem);
    for (var i = 0; i < feed.items.length; i++) {
      preparedFeed.items.add(MyRssItem(
          item: feed.items[i], isViewed: isNewsInHistory(feed.items[i])));
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
