import 'package:flutter/material.dart';
import 'package:simplenewsfeed/body_content.dart';

import 'list_view_history.dart';

class MyPageView extends StatefulWidget {
  @override
  _MyPageViewState createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
//        pageChanged(index);
      },
      children: <Widget>[
        BodyContent(),
        ListViewHistory(),
      ],
    );
  }

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  @override
  void initState() {
    super.initState();
  }

//  void pageChanged(int index) {
//    setState(() {
//      bottomSelectedIndex = index;
//    });
//  }
//
//  void bottomTapped(int index) {
//    setState(() {
//      bottomSelectedIndex = index;
//      pageController.animateToPage(index,
//          duration: Duration(milliseconds: 500), curve: Curves.ease);
//    });
//  }
}
