import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'news_controller.dart';
import 'selected_news_page.dart';

class ListViewLatest extends StatelessWidget {
  const ListViewLatest({Key key, @required this.preparedRssFeed})
      : super(key: key);
  final PreparedFeed preparedRssFeed;

  @override
  Widget build(BuildContext context) {
    final viewedController = Provider.of<ViewedNewsController>(context);
    return ListView(
        key: PageStorageKey('latest'),
        children: preparedRssFeed.items
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
                trailing: Icon(
                    i.isViewed ? Icons.bookmark : Icons.bookmark_border,
                    size: 24,
                    color: Colors.amber),
                onTap: () {
                  viewedController.addNotViewedToHistory(
                      i.item, preparedRssFeed.items.indexOf(i));
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => SelectedNewsPage(rssItem: i.item)));
                },
              ),
            )
            .toList());
  }
}
