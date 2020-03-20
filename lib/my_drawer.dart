import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'news_controller.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 108,
            child: DrawerHeader(
              child: Text(
                'Select news sorce',
                style: TextStyle(color: Colors.white, fontSize: 21),
              ),
              decoration: BoxDecoration(
                color: Colors.deepOrange,
              ),
            ),
          ),
          ListTile(
              title: Text(
                'CNBC International',
                style: TextStyle(fontSize: 18),
              ),
              trailing: MyRadio(sources: Sources.cnbc), onTap: () {}),
          ListTile(
              title: Text(
                'The New York Times',
                style: TextStyle(fontSize: 18),
              ),
              trailing: MyRadio(sources: Sources.nytimes)),
        ],
      ),
    );
  }
}

class MyRadio extends StatelessWidget {
  const MyRadio({Key key, @required this.sources}) : super(key: key);
  final Sources sources;

  @override
  Widget build(BuildContext context) {
    final viewedController = Provider.of<ViewedNewsController>(context);
    return ValueListenableBuilder<Sources>(
        valueListenable: sourceNotifier,
        builder: (_, sourceState, __) {
          return Radio(
              value: sources,
              groupValue: sourceState,
              onChanged: (Sources value) {
                changeSource(value);
                viewedController.fetchNews();
                Navigator.of(context).pop();
              });
        });
  }
}
