import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simplenewsfeed/viewed.dart';

class ListViewHistory extends StatelessWidget {
  const ListViewHistory({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myDatabase = Provider.of<MyDatabase>(context);

    //DON'T DO prepare viewed items in backend and just here the final list. It will help with auto updating list after deletion.
   // coz we'll duplicate exactly the same information in memory, which is overkill.
    //TODO Page should reload after deletion

    return StreamBuilder(
      stream: myDatabase.watchAllViewedItems(),
      builder: (context, AsyncSnapshot<List<ViewedItem>> snapshot) {
        final viewed = snapshot.data ?? List();
        return viewed.isEmpty
            ? Text('There is no single story =/')
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
