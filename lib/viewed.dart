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
  MyDatabase._() : super(FlutterQueryExecutor.inDatabaseFolder(path: 'db2.sqlite'));

  static final MyDatabase _instance = MyDatabase._();

  factory MyDatabase() {
    return _instance;
  }

  @override
  int get schemaVersion => 1;

  void addToViewed(RssItem f) async {
    ViewedItem viewed;
    if (f.guid != null) {
      viewed = ViewedItem(
        id: f.guid,
        title: f.title,
        content: f.description,
        link: f.link,
      );
      await into(viewedItems).insert(viewed);
    } else {
      viewed = ViewedItem(
        id: f.link, //bad code
        title: f.title,
        content: f.description,
        link: f.link,
      );
      await into(viewedItems).insert(viewed);
    }
  }

  Future<void> deleteRows() async {
    print('inside of deleteRows in db class');
    return await (delete(viewedItems)).go();
  }

  Future<bool> isViewedItemById(String id) async {
    ViewedItem item = await (select(viewedItems)..where((viewedItem) => viewedItem.id.equals(id))).getSingle();
    return item != null ? true : false;
  }

  Future<bool> isViewedItemByLink(String link) async {
    ViewedItem item = await (select(viewedItems)..where((viewedItem) => viewedItem.link.equals(link))).getSingle();
    return item != null ? true : false;
  }

//  Future<List<ViewedItem>> get allViewedItems => select(viewedItems).get();

//  List<ViewedItem> getAllViewedItems() {
//    List<ViewedItem> list = [];
//    select(viewedItems).get().then((items) {
//      list = items;
//    });
//    return list;
//  }

  Future<List<ViewedItem>> getAllViewedItems() {
//    List<ViewedItem> list = [];
    return select(viewedItems).get();
  }

}
