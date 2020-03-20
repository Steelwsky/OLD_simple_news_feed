import 'package:flutter/material.dart';
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
          Provider<Sources>(
            create: (_) => Sources.cnbc,
          )
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(primarySwatch: Colors.deepPurple),
          home: MyHomePage(),
        ));
  }
}
