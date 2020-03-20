import 'package:flutter/material.dart';
import 'package:simplenewsfeed/bottom_nav_bar.dart';
import 'package:simplenewsfeed/my_app_bar.dart';
import 'my_drawer.dart';
import 'bottom_nav_bar.dart';
import 'my_page_view.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();
    return Scaffold(
      drawer: MyDrawer(),
      appBar: MyAppBar(),
      body: MyPageView(pageController),
      bottomNavigationBar: MyBottomNavBar(pageController: pageController),
    );
  }
}
