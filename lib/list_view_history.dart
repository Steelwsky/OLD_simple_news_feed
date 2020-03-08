import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simplenewsfeed/viewed.dart';

class ListViewHistory extends StatelessWidget {
  const ListViewHistory({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myDatabase = Provider.of<MyDatabase>(context);
    return StreamBuilder(
      stream: myDatabase.watchAllViewedItems(),
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
                    onTap: () {},
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
          'There is no single record',
          key: Key('empty'),
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
