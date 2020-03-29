import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simplenewsfeed/strings.dart';
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
    final MyPageIndexController myIntController =
        Provider.of<MyPageIndexController>(context);
    return ValueListenableBuilder(
        valueListenable: myIntController.intState,
        builder: (_, sourceState, __) {
          return AppBar(
            title: myIntController.intState.value == 0
                ? TextAppBar()
                : Text(HISTORY),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: newsController.deleteEntries)
            ],
          );
        });
  }
}

class TextAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: sourceModelNotifier,
        builder: (_, sourceState, __) {
          return Text('$HOME - ${sourceModelNotifier.value.shortName}');
        });
  }
}
