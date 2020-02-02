import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:webfeed/webfeed.dart';

class NewsController {
  final _url = 'http://www.cnbc.com/id/19789731/device/rss/rss.xml';
  final _client = Client();

  final ValueNotifier<RssFeed> newsState = ValueNotifier(RssFeed());

  Future<void> fetchNews() async {
    final res = await _client.get(_url);
    final xmlStr = res.body;
    final parsedNews = RssFeed.parse(xmlStr);
    final viewedNews = PreparedNewsFeed(feed: parsedNews);

//    newsState.value = RssFeed.parse(xmlStr); //TODO DON'T FORGET
  }
}

class PreparedNewsFeed {
  PreparedNewsFeed({this.feed, this.isViewed});
  final RssFeed feed;
  final bool isViewed;

}

class ViewedNewsController {
  ViewedNewsController({this.preparedNewsFeed});

  final PreparedNewsFeed preparedNewsFeed;
  final Set<String> _newsAlreadyViewed = Set.from([]);

  final ValueNotifier<RssFeed> viewedState = ValueNotifier(RssFeed());

  void addNotViewedToHistory(String guid) {
    _newsAlreadyViewed.add(guid);
    print(_newsAlreadyViewed);
  }

  void checkViewedItems () {
    for (var i = 0; i < preparedNewsFeed.feed.items.length; i++) {
      isNewsInHistory(preparedNewsFeed.feed.items.elementAt(i));
    }
  }

  bool isNewsInHistory(RssItem item) {
    if (_newsAlreadyViewed.contains(item.guid)) {
      return true;
    } else
      return false;
  }
}
