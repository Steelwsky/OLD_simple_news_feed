import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simplenewsfeed/viewed.dart';
import 'news_controller.dart';
import 'selected_news_page.dart';

class ListViewHistory extends StatelessWidget {
  const ListViewHistory({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myDatabase = Provider.of<MyDatabase>(context);

    //TODO prepare viewed items in backend and just here the final list.
    //TODO Also, this page should reload after deletion

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
