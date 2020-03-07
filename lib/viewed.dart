import 'package:moor_flutter/moor_flutter.dart';
import 'package:webfeed/webfeed.dart';

part 'viewed.g.dart';

class ViewedItems extends Table {
  TextColumn get id => text()();

  TextColumn get title => text()();

  TextColumn get content => text()();

  TextColumn get link => text()();
}

@UseMoor(tables: [ViewedItems])
class MyDatabase extends _$MyDatabase {
  MyDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(path: 'db1.sqlite'));

  @override
  int get schemaVersion => 1;

  void addToViewed(RssItem f) {
    final viewed = ViewedItem(
      id: f.guid,
      title: f.title,
      content: f.description,
      link: f.link,
    );
    into(viewedItems).insert(viewed);
  }

  Future deleteRows() {
    return (delete(viewedItems)).go();
  }

  Future<ViewedItem> isViewedItem(String id) {
    return (select(viewedItems)
          ..where((viewedItem) => viewedItem.id.equals(id)))
        .getSingle();
  }

  Future<List<ViewedItem>> get allViewedItems => select(viewedItems).get();

  Stream<List<ViewedItem>> watchAllViewedItems() => select(viewedItems).watch();
}


