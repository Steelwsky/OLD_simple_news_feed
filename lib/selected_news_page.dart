import 'package:flutter/material.dart';
import 'package:webfeed/webfeed.dart';

class SelectedNewsPage extends StatelessWidget {
  SelectedNewsPage({Key key, this.item}) : super(key: key);
  final RssItem item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(item.title)),
      body: Column(
        children: [
          SingleChildScrollView(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Text(
                      item.description,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }
}
