import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';
import 'news_controller.dart';
import 'selected_news_page.dart';
import 'strings.dart';
import 'viewed.dart';

class ListViewHistory extends StatelessWidget {
  const ListViewHistory({Key key, this.myDatabase}) : super(key: key);
  final Database myDatabase;

  @override
  Widget build(BuildContext context) {
//    final myDatabase = Provider.of<MyDatabase>(context);
    return ValueListenableBuilder<List<ViewedItem>>( // HistoryValueNotifier
     valueListenable: viewedModelNotifier,       //myDatabase.watchAllViewedItems(),  //TODO ValueListenableBuilder
      builder: (_, historyState, __) {
        return historyState.isEmpty
            ? EmptyHistoryList()
            : ListView.builder(
                key: PageStorageKey('history'),
                itemCount: historyState.length,
                itemBuilder: (_, index) {
                  final favItem = historyState[index];
                  return ListTile(
                    key: ValueKey('item$index'),
                    title: Text(
                      favItem.title,
                      style: TextStyle(fontSize: 18),
                    ),
                    subtitle: Text(
                      favItem.content,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 16),
                    ),
                    trailing: Icon(Icons.bookmark, size: 24, color: Colors.amber),
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) => SelectedNewsPage(viewedItem: historyState[index])));
                    },
                  );
                },
              );
      },
    );
  }
}


class EmptyHistoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: Text(
          EMPTY_LIST,
          key: Key('empty'),
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}


// @override
//  Widget build(BuildContext context) {
////    final myDatabase = Provider.of<MyDatabase>(context);
//    return StreamBuilder( // HistoryValueNotifier
//      stream: myDatabase.watchAllViewedItems(),       //myDatabase.watchAllViewedItems(),  //TODO ValueListanableBuilder
//      builder: (_, AsyncSnapshot<List<ViewedItem>> snapshot) {
//        final viewed = snapshot.data ?? List();
//        return viewed.isEmpty
//            ? EmptyHistoryList()
//            : ListView.builder(
//                key: PageStorageKey('history'),
//                itemCount: viewed.length,
//                itemBuilder: (_, index) {
//                  final favItem = viewed[index];
//                  return ListTile(
//                    key: ValueKey('item$index'),
//                    title: Text(
//                      favItem.title,
//                      style: TextStyle(fontSize: 18),
//                    ),
//                    subtitle: Text(
//                      favItem.content,
//                      maxLines: 3,
//                      overflow: TextOverflow.ellipsis,
//                      style: TextStyle(fontSize: 16),
//                    ),
//                    trailing: Icon(Icons.bookmark, size: 24, color: Colors.amber),
//                    onTap: () {
//                      Navigator.of(context)
//                          .push(MaterialPageRoute(builder: (_) => SelectedNewsPage(viewedItem: viewed[index])));
//                    },
//                  );
//                },
//              );
//      },
//    );
//  }
//}