import 'package:flutter/material.dart';
import 'package:simplenewsfeed/list_view_history.dart';
import 'body_content.dart';

class MyBottomNavBar extends StatefulWidget {
  MyBottomNavBar({Key key}) : super(key: key);

  static List<Widget> widgetOptions = <Widget>[
    BodyContent(),
    ListViewHistory(),
  ];

  @override
  _MyBottomNavBarState createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
    );
  }
}
