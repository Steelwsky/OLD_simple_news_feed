import 'package:flutter/material.dart';
import 'package:simplenewsfeed/viewed.dart';
import 'package:webfeed/webfeed.dart';

class SelectedNewsPage extends StatelessWidget {
  SelectedNewsPage({Key key, this.rssItem, this.viewedItem}) : super(key: key);
  final RssItem rssItem;
  final ViewedItem viewedItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(rssItem != null ? rssItem.title : viewedItem.title),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Text(
                      rssItem != null
                          ? rssItem.description
                          : viewedItem.content,
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
