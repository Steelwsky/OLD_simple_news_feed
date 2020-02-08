import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:webfeed/webfeed.dart';

class NewsController {
  final _url = 'http://www.cnbc.com/id/19789731/device/rss/rss.xml';
  final _client = Client();
  final viewedNewsController = ViewedNewsController();


//  final ValueNotifier<RssFeed> newsState = ValueNotifier(RssFeed());

  Future<void> fetchNews() async {
    final res = await _client.get(_url);
    final xmlStr = res.body;
    final parsedNews = RssFeed.parse(xmlStr);
    print(parsedNews.items);
//    ViewedNewsController().checkViewedNews(parsedNews);

    viewedNewsController.checkViewedNews(parsedNews);

//    newsState.value = RssFeed.parse(xmlStr); //TODO DON'T FORGET
  }
}

class ViewedNewsController {

  final Set<String> _newsAlreadyViewed = Set.from([]);

  final ValueNotifier<PreparedFeed> viewedState = ValueNotifier(PreparedFeed());

  void addNotViewedToHistory(String guid) {
    _newsAlreadyViewed.add(guid);
    print(_newsAlreadyViewed);
  }

  bool isNewsInHistory(RssItem item) {
    if (_newsAlreadyViewed.contains(item.guid)) {
      return true;
    } else
      return false;
  }

  void checkViewedNews(RssFeed feed) {
    final List<MyRssItem> listItem = List<MyRssItem>();
    final preparedFeed = PreparedFeed(items: listItem);
    for (var i = 0; i < feed.items.length; i++) {
      preparedFeed.items.add(MyRssItem(
          item: feed.items[i], isViewed: isNewsInHistory(feed.items[i])));
      print('i: $i, ${preparedFeed.items[i].isViewed}');
    }
    viewedState.value = preparedFeed;
    print('preparedFeed: ${viewedState.value.items}');
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
