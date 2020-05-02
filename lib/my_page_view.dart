import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'body_content.dart';
import 'news_controller.dart';
import 'list_view_history.dart';
import 'main.dart';

class MyPageView extends StatefulWidget {
  MyPageView({this.pageController, this.myDatabase});

  final Database myDatabase;

  final PageController pageController;

  @override
  _MyPageViewState createState() => _MyPageViewState(pageController: pageController, myDatabase: myDatabase);
}

class _MyPageViewState extends State<MyPageView> {
  _MyPageViewState({this.pageController, this.myDatabase});

  final PageController pageController;
  final Database myDatabase;

  @override
  Widget build(BuildContext context) {
    final MyPageIndexController myIntController = Provider.of<MyPageIndexController>(context);
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        myIntController.pageChanged(index);
        print('widget PageView: $index');
      },
      children: <Widget>[
        BodyContent(),
        ListViewHistory(myDatabase: myDatabase),
      ],
    );
  }

}
