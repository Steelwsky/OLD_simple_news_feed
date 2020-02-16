import 'package:flutter/material.dart';
import 'news_controller.dart';
import 'body_content.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsController = Provider.of<ViewedNewsController>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('NewsFeed'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.delete), onPressed: newsController.deleteEntries)
        ],
      ),
      body: BodyContent(),
    );
  }
}
