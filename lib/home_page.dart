import 'package:flutter/material.dart';
import 'package:simplenewsfeed/bottom_nav_bar.dart';
import 'news_controller.dart';
import 'body_content.dart';
import 'package:provider/provider.dart';
import 'bottom_nav_bar.dart';
import 'page_view_controller.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsController = Provider.of<ViewedNewsController>(context);
//    final bottomNavBar = MyBottomNavBar();
    return Scaffold(
      appBar: AppBar(
        title: Text('NewsFeed'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.delete), onPressed: newsController.deleteEntries)
        ],
      ),
      body: MyPageView(),
//      BodyContent(),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }
}
