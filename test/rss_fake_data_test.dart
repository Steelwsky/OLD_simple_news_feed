import 'package:simplenewsfeed/news_controller.dart';
import 'package:webfeed/webfeed.dart';

class FakeData {
  final RssFeed fakeRssFeed = RssFeed(title: 'FakeFeed', items: fakeRssItems);
 static List<RssItem> fakeRssItems =  [
  RssItem(title: 'ItemTitle 1', description: 'Description 1', link: '', guid:'1'),
  RssItem(title: 'ItemTitle 2', description: 'Description 2', link: '', guid:'2'),
  RssItem(title: 'ItemTitle 3', description: 'Description 3', link: '', guid:'3'),
  RssItem(title: 'ItemTitle 4', description: 'Description 4', link: '', guid:'4'),
  RssItem(title: 'ItemTitle 5', description: 'Description 5', link: '', guid:'5'),
  RssItem(title: 'ItemTitle 6', description: 'Description 6', link: '', guid:'6'),
  RssItem(title: 'ItemTitle 7', description: 'Description 7', link: '', guid:'7'),
  RssItem(title: 'ItemTitle 8', description: 'Description 8', link: '', guid:'8'),
  RssItem(title: 'ItemTitle 9', description: 'Description 9', link: '', guid:'9'),
  ];

  final PreparedFeed fakePreparedFeed = PreparedFeed(items: fakeMyRssItems);

  static List<MyRssItem> fakeMyRssItems = [
    MyRssItem(item: fakeRssItems[0], isViewed: false),
    MyRssItem(item: fakeRssItems[1], isViewed: false),
    MyRssItem(item: fakeRssItems[2], isViewed: false),
    MyRssItem(item: fakeRssItems[3], isViewed: false),
    MyRssItem(item: fakeRssItems[4], isViewed: false),
    MyRssItem(item: fakeRssItems[5], isViewed: false),
    MyRssItem(item: fakeRssItems[6], isViewed: false),
    MyRssItem(item: fakeRssItems[7], isViewed: false),
    MyRssItem(item: fakeRssItems[8], isViewed: false),
  ];

}

