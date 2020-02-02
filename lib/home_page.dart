import 'package:flutter/material.dart';
import 'package:simplenewsfeed/body_content.dart';
import 'package:provider/provider.dart';
import 'package:simplenewsfeed/news_controller.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<NewsController>(
        create: (_) => NewsController(),
        child: Scaffold(
          appBar: AppBar(
            title: Text('NewsFeed'),
          ),
          body: BodyContent(),
        ));
  }
}
