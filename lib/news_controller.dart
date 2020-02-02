import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:webfeed/webfeed.dart';

class NewsController {

  final _url = 'http://www.cnbc.com/id/19789731/device/rss/rss.xml';
  final _client = Client();
  final Set<String> _newsAlreadyViewed = Set.from([]);

  final ValueNotifier<RssFeed> newsState = ValueNotifier(RssFeed());

  Future<void> fetchNews() async {
    final res = await _client.get(_url);
    final xmlStr = res.body;
    newsState.value = RssFeed.parse(xmlStr);
    print('fetchNews(): ${newsState.value.items}');
  }

  void addNotViewedToHistory(String guid) {
    _newsAlreadyViewed.add(guid);
    print(_newsAlreadyViewed);
  }

  bool isNewsInHistory(RssItem item) {
    if(_newsAlreadyViewed.contains(item.guid)) {
      return true;
    } else
      return false;
  }
}
