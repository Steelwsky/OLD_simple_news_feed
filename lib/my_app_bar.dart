import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'news_controller.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  MyAppBar({Key key})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    final newsController = Provider.of<ViewedNewsController>(context);
    return ValueListenableBuilder(
        valueListenable: sourceNotifier,
        builder: (_, sourceState, __) {
          return AppBar(
            title: Text('NewsFeed ${nameOfSource(sourceNotifier.value)}'),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: newsController.deleteEntries)
            ],
          );
        });
  }
}
