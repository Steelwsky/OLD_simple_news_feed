import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simplenewsfeed/bookmark_widget.dart';

import 'news_controller.dart';
import 'selected_news_page.dart';

class ListViewWidget extends StatelessWidget {
  const ListViewWidget(
      {Key key, @required this.viewedController, @required this.rssFeed})
      : super(key: key);

  final ViewedNewsController viewedController;
  final PreparedFeed rssFeed;

  @override
  Widget build(BuildContext context) {
    final viewedController = Provider.of<ViewedNewsController>(context);
    return ListView(
        children: rssFeed.items
            .map(
              (i) => ListTile(
                title: Text(
                  i.item.title,
                  style: TextStyle(fontSize: 18),
                ),
                subtitle: Text(
                  i.item.description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 16),
                ),
                trailing: Bookmark(isViewed: i.isViewed),
                onTap: () {
                  viewedController.addNotViewedToHistory(
                      i.item.guid, rssFeed.items.indexOf(i));
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => SelectedNewsPage(item: i.item)));
                },
              ),
            )
            .toList());
  }
}
