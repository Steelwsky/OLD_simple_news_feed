import 'package:flutter/material.dart';
import 'package:simplenewsfeed/list_view_history.dart';
import 'package:simplenewsfeed/viewed.dart';
import 'home_page.dart';
import 'package:provider/provider.dart';
import 'news_controller.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<ViewedNewsController>(
            create: (_) => ViewedNewsController(),
          ),
          Provider<MyDatabase>(
            create: (_) => MyDatabase(),
            child: ListViewHistory(),
            dispose: (context, db) => db.close(),
          ),
          Provider<MyPageIndexController>(
            create: (_) => MyPageIndexController(),
          )
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(primarySwatch: Colors.deepPurple),
          home: MyHomePage(),
        ));
  }
}
