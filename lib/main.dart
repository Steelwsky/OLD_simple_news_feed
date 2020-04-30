import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:simplenewsfeed/list_view_history.dart';
import 'package:simplenewsfeed/list_view_latest.dart';
import 'body_content.dart';
import 'viewed.dart';
import 'package:webfeed/webfeed.dart';
import 'home_page.dart';
import 'package:provider/provider.dart';
import 'news_controller.dart';


typedef GetRssFromUrl = Future<RssFeed> Function(String url);
typedef AddItemToHistory = void Function(RssItem item);
typedef CheckNewsInHistoryById = Future<bool> Function(String id);
typedef CheckNewsInHistoryByLink = Future<bool> Function(String link);
typedef DeleteRows = Future<void> Function();
typedef GetAllViewedItems = Future<List<ViewedItem>> Function();

//final ValueNotifier<MyDatabase> database = ValueNotifier(MyDatabase());

final MyDatabase database = MyDatabase();


class NetworkResponseToRssParser {
  RssFeed mapToRss(http.Response response) {
    final xmlStr = response.body;
    final parsedNews = RssFeed.parse(xmlStr);
    print('fetchNews(): ${parsedNews.items}');
    return parsedNews;
  }
}

abstract class Database {
  Database(
      {this.addItemToHistory,
      this.checkNewsInHistoryById,
      this.checkNewsInHistoryByLink,
      this.deleteRows,
      this.getAllViewedItems});

  final AddItemToHistory addItemToHistory;
  final CheckNewsInHistoryById checkNewsInHistoryById;
  final CheckNewsInHistoryByLink checkNewsInHistoryByLink;
  final DeleteRows deleteRows;
  final GetAllViewedItems getAllViewedItems;
}

class DDatabase implements Database{
  @override
  AddItemToHistory get addItemToHistory => database.addToViewed;

  @override
  CheckNewsInHistoryById get checkNewsInHistoryById => database.isViewedItemById;

  @override
  CheckNewsInHistoryByLink get checkNewsInHistoryByLink => database.isViewedItemByLink;

  @override
  DeleteRows get deleteRows => database.deleteRows;

  @override
  GetAllViewedItems get getAllViewedItems => database.getAllViewedItems;

}

void main() {
  final client = http.Client();
  final rssParser = NetworkResponseToRssParser();
  final Database myDatabase = DDatabase();


  runApp(MyApp(
      getRssFromUrl: (url) => client.get(url).then((data) {
            return rssParser.mapToRss(data);
          }),
      myDatabase: myDatabase)); // runDebugApp() if /// MyApp(networkClient)   //
}

class MyApp extends StatelessWidget {
  const MyApp({this.getRssFromUrl, this.myDatabase});

  final GetRssFromUrl getRssFromUrl;
  final Database myDatabase;

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController(initialPage: 0);
    return MultiProvider(
        providers: [
          Provider<NewsController>(
              create: (_) => NewsController(getRssFromUrl: getRssFromUrl, myDatabase: myDatabase)),
          Provider<MyPageIndexController>(
            create: (_) => MyPageIndexController(),
          ),
          Provider<SourceController>(
            create: (_) => SourceController(),
          )
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(primarySwatch: Colors.deepPurple),
          home: MyHomePage(pageController: pageController, myDatabase: myDatabase),
          initialRoute: '/',
          routes: {
            '/home': (context) => MyHomePage(),
            '/body': (context) => BodyContent(),
            '/latest': (context) => ListViewLatest(),
            '/history': (context) => ListViewHistory(),
          },
        ));
  }
}
