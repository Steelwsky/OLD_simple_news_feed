import 'package:flutter/material.dart';
import 'bottom_nav_bar.dart';
import 'main.dart';
import 'my_app_bar.dart';
import 'my_drawer.dart';
import 'my_page_view.dart';


class MyHomePage extends StatefulWidget {
   MyHomePage({this.pageController, this.myDatabase});
  final PageController pageController;
  final Database myDatabase;

  @override
  _MyHomePageState createState() => _MyHomePageState(pageController: pageController, myDatabase: myDatabase);
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState({this.pageController, this.myDatabase});
  final PageController pageController;
  final Database myDatabase;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: GlobalKey(debugLabel: 'scaffoldKey'),
      drawer: MyDrawer(),
      appBar: MyAppBar(),
      body: MyPageView(pageController: pageController, myDatabase: myDatabase),
      bottomNavigationBar: MyBottomNavBar(pageController: pageController),
    );
  }
}
