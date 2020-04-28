import 'package:flutter/material.dart';
import 'main.dart';
import 'selected_news_page.dart';
import 'strings.dart';
import 'viewed.dart';

class ListViewHistory extends StatelessWidget{
  const ListViewHistory({Key key, this.myDatabase}) : super(key: key);
  final Database myDatabase;

  @override
  Widget build(BuildContext context) {
//    final myDatabase = Provider.of<MyDatabase>(context);
    return StreamBuilder(
      stream: myDatabase.watchAllViewedItems(),   //myDatabase.watchAllViewedItems(),
      builder: (context, AsyncSnapshot<List<ViewedItem>> snapshot) {
        final viewed = snapshot.data ?? List();
        return viewed.isEmpty
            ? EmptyHistoryList()
            : ListView.builder(
                key: PageStorageKey('history'),
                itemCount: viewed.length,
                itemBuilder: (_, index) {
                  final favItem = viewed[index];
                  return ListTile(
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
                    trailing:
                        Icon(Icons.bookmark, size: 24, color: Colors.amber),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => SelectedNewsPage(viewedItem: viewed[index])));
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
