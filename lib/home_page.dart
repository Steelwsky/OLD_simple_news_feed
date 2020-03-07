import 'package:flutter/material.dart';
import 'package:simplenewsfeed/bottom_nav_bar.dart';
import 'news_controller.dart';
import 'package:provider/provider.dart';
import 'bottom_nav_bar.dart';
import 'my_page_view.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();
    final newsController = Provider.of<ViewedNewsController>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('NewsFeed'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.delete), onPressed: newsController.deleteEntries)
        ],
      ),
      body: MyPageView(pageController),
      bottomNavigationBar: MyBottomNavBar(pageController: pageController),
    );
  }
}
