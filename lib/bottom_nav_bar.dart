import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'news_controller.dart';

class MyBottomNavBar extends StatefulWidget {
  MyBottomNavBar({Key key, this.pageController}) : super(key: key);
  final PageController pageController;

  @override
  _MyBottomNavBarState createState() => _MyBottomNavBarState(pageController);
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
  _MyBottomNavBarState(this.pageController);
  final PageController pageController;
  @override
  Widget build(BuildContext context) {
    final MyPageIndexController myIntController =
        Provider.of<MyPageIndexController>(context);
    return ValueListenableBuilder<int>(
      valueListenable: myIntController.intState,
      builder: (_, newState, __) {
        return BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('Home'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.book),
                title: Text('History'),
              ),
            ],
            currentIndex: myIntController.intState.value,
            selectedItemColor: Colors.amber[800],
            onTap: (index) {
              myIntController.bottomTapped(index, pageController);
              print('bottomNavBar widget post: $index');
            });
      },
    );
  }
}
