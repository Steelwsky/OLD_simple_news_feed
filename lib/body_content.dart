import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'news_controller.dart';
import 'empty_list.dart';
import 'selected_news_page.dart';
import 'package:webfeed/webfeed.dart';

class BodyContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    final newsController = Provider.of<NewsController>(context);
    final viewedController = Provider.of<ViewedNewsController>(context);
    return ValueListenableBuilder<PreparedFeed>(
        valueListenable: viewedController.viewedState,
        builder: (_, rssFeed, __) {
          return RefreshIndicator(
              key: Key('refresh'),
              onRefresh: () => viewedController.fetchNews(),
              child: rssFeed.items == null
                  ? InitialEmptyList()
                  : ListView(
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
                              trailing: i
                                      .isViewed // without calling a method. we just need to check is it true or false
                                  ? Icon(Icons.bookmark,
                                      size: 24, color: Colors.amber)
                                  : Icon(Icons.bookmark_border,
                                      size: 24, color: Colors.amber),
                              onTap: () {
                                viewedController.addNotViewedToHistory(rssFeed
                                    .items[rssFeed.items.indexOf(i)].item.guid);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => SelectedNewsPage(
                                        item: rssFeed
                                            .items[rssFeed.items.indexOf(i)]
                                            .item)));
                              },
                            ),
                          )
                          .toList()));
        });
  }
}
