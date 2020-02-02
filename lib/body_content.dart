import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simplenewsfeed/news_controller.dart';
import 'package:simplenewsfeed/empty_list.dart';
import 'package:webfeed/webfeed.dart';

class BodyContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsController = Provider.of<NewsController>(context);
    return ValueListenableBuilder<RssFeed>(
        valueListenable: newsController.newsState,
        builder: (_, rssFeed, __) {
          return RefreshIndicator(
              key: Key('refresh'),
              onRefresh: () => newsController.fetchNews(),
              child: rssFeed.items == null
                  ? InitialEmptyList()
                  : ListView(
                  children: rssFeed.items
                      .map(
                        (i) => ListTile(
                      title: Text(
                        i.title,
                        style: TextStyle(fontSize: 18),
                      ),
                      subtitle: Text(
                        i.description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 16),
                      ),
                      onTap: () {},
                    ),
                  )
                      .toList()));
        });
  }
}
