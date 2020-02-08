import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'list_view_widget.dart';
import 'news_controller.dart';
import 'empty_list.dart';

class BodyContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewedController = Provider.of<ViewedNewsController>(context);
    return ValueListenableBuilder<PreparedFeed>(
        valueListenable: viewedController.viewedState,
        builder: (_, rssFeed, __) {
          return RefreshIndicator(
              key: Key('refresh'),
              onRefresh: () => viewedController.fetchNews(),
              child: rssFeed.items == null
                  ? InitialEmptyList()
                  : ListViewWidget(
                      viewedController: viewedController, rssFeed: rssFeed));
        });
  }
}
