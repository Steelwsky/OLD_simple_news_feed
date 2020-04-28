import 'package:simplenewsfeed/news_controller.dart';
import 'package:simplenewsfeed/viewed.dart';
import 'package:webfeed/webfeed.dart';


  final RssFeed fakeRssFeed = RssFeed(title: 'FakeFeed', items: fakeRssItems);
  List<RssItem> fakeRssItems =  [
  RssItem(title: 'ItemTitle 1', description: 'Description 1', link: 'link1', guid:'guid1'),
  RssItem(title: 'ItemTitle 2', description: 'Description 2', link: 'link2', guid:'guid2'),
  RssItem(title: 'ItemTitle 3', description: 'Description 3', link: 'link3', guid:'guid3'),
  RssItem(title: 'ItemTitle 4', description: 'Description 4', link: 'link4', guid:'guid4'),
  RssItem(title: 'ItemTitle 5', description: 'Description 5', link: 'link5', guid:'guid5'),
  RssItem(title: 'ItemTitle 6', description: 'Description 6', link: 'link6', guid:'guid6'),
  RssItem(title: 'ItemTitle 7', description: 'Description 7', link: 'link7', guid:'guid7'),
  RssItem(title: 'ItemTitle 8', description: 'Description 8', link: 'link8', guid:'guid8'),
  RssItem(title: 'ItemTitle 9', description: 'Description 9', link: 'link9', guid:'guid9'),
  ];

  final PreparedFeed fakePreparedFeed = PreparedFeed(items: fakeMyRssItems);

   List<MyRssItem> fakeMyRssItems = [
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

//   final ViewedItem fakeViewedItemData = ViewedItem(id: 'guid1', title: 'ItemTitle1', content: 'Description1', link: 'link1');


   List<ViewedItem> fakeViewedHistory = [
     ViewedItem(id: 'guid1', title: 'ItemTitle 1', content: 'Description 1', link: 'link1'),
     ViewedItem(id: 'guid2', title: 'ItemTitle 2', content: 'Description 2', link: 'link2'),
     ViewedItem(id: 'link1', title: 'Title 11', content: 'Description 11', link: 'link11'),
     ViewedItem(id: 'link2', title: 'Title 12', content: 'Description 12', link: 'link11'),
     ViewedItem(id: 'guid3', title: 'ItemTitle 3', content: 'Description 3', link: 'link3'),
     ViewedItem(id: 'guid4', title: 'ItemTitle 4', content: 'Description 4', link: 'link4'),
   ];



