import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simplenewsfeed/main.dart';
import 'package:simplenewsfeed/strings.dart';
import 'news_controller.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(0),
        children: <Widget>[
          Container(
            height: 108,
            child: DrawerHeader(
              child: Text(
                SELECT_SOURCE_NEWS,
                style: TextStyle(color: Colors.white, fontSize: 21),
              ),
              decoration: BoxDecoration(
                color: Colors.deepOrange,
              ),
            ),
          ),
          SourceList(),
        ],
      ),
    );
  }
}

class SourceList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<SourceModel>(
      valueListenable: sourceModelNotifier,
      builder: (_, sourceModelState, __) {
        return Column(
          children: <Widget>[
            ListView.builder(
                padding: EdgeInsets.only(top: 0),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: sourceList.length,
                itemBuilder: (BuildContext _, int index) {
                  return MyInkWellRadio(
                    title: sourceList[index].longName,
                    isSelected: sourceList[index].isSelected,
                    indx: index,
                  );
                }),
          ],
        );
      },
    );
  }
}

class MyInkWellRadio extends StatelessWidget {
  MyInkWellRadio({this.title, this.isSelected, this.indx});

  final String title;
  final bool isSelected;
  final int indx;

  @override
  Widget build(BuildContext context) {
    final ViewedNewsController viewedNewsController =
        Provider.of<ViewedNewsController>(context);
    final sourceController = Provider.of<SourceController>(context);
    return InkWell(
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(fontSize: 18),
        ),
        trailing: Icon(
            isSelected
                ? Icons.radio_button_checked
                : Icons.radio_button_unchecked,
            color: Colors.deepOrange),
      ),
      onTap: () {
        sourceController.changingSource(indx);
        Navigator.of(context).pushAndRemoveUntil(                   // TODO below ---------------------------------------------------------------------
            MaterialPageRoute(builder: (context) => MyApp()),       // Don't know how to do this part. MyApp() does everything good,
                (Route<dynamic> route) => false);                   // but user must manually update the list. MyHomePage() automatically updates list,
//        Navigator.of(context).pop();                              // but AppBar and BottomNavBar don't update automatically,
        viewedNewsController.fetchNews();                           // because they were done separately to each other.
      },
    );
  }
}
