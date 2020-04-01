import 'package:flutter/material.dart';
import 'package:simplenewsfeed/body_content.dart';
import 'package:simplenewsfeed/list_view_history.dart';
import 'package:simplenewsfeed/list_view_latest.dart';
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
          Provider<MyPageIndexController>(
            create: (_) => MyPageIndexController(),
          ),
          Provider<SourceController>(
            create: (_) => SourceController(),
          )
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(primarySwatch: Colors.deepPurple),
          home: MyHomePage(),
          initialRoute: '/',
          routes: {
            '/home': (context) => MyHomePage(),
            '/body': (context) => BodyContent(),
            '/listLatest': (context) => ListViewLatest(),
            '/history': (context) => ListViewHistory(),
          },
        ));
  }
}
