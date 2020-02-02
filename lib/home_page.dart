import 'package:flutter/material.dart';
import 'news_controller.dart';
import 'body_content.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<NewsController>(
            create: (context) => NewsController(),
          ),
          Provider<ViewedNewsController>(
            create: (context) => ViewedNewsController(),
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: Text('NewsFeed'),
          ),
          body: BodyContent(),
        ));
  }
}
