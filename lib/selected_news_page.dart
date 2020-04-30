import 'package:flutter/material.dart';
import 'package:simplenewsfeed/strings.dart';
import 'package:simplenewsfeed/viewed.dart';
import 'package:webfeed/webfeed.dart';
import 'package:url_launcher/url_launcher.dart';

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
                      rssItem != null ? rssItem.description : viewedItem.content,
                      style: TextStyle(fontSize: 16),
                    ),
                    Container(
                      height: 50,
                      width: 174,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: InkWell(
                            onTap: () async {
                              final url = rssItem != null ? rssItem.link : viewedItem.link;
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                            child: Row(
                              children: <Widget>[
                                Text(
                                  CONTINUE_READING,
                                  style: (TextStyle(fontSize: 20)),
                                ),
                                Icon(Icons.open_in_new, size: 20),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
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
