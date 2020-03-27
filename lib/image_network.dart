import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;

// WANTED separate function which goes to link and take first image. In UI that image will be showed right after AppBar
// -- parsing is not possible, because images are not reachable. Getting lazy placeholders!

class MyImageNetwork extends StatefulWidget {
  MyImageNetwork({Key key, this.link }) : super(key: key);

  final String link;

  @override
  _MyImageNetworkState createState() => _MyImageNetworkState(link: link);
}

class _MyImageNetworkState extends State<MyImageNetwork> {
  _MyImageNetworkState({this.link});

  final String link;
  List<String> picList = List();

  Future parseForPicture(String link) async {
    print('link: $link');
    final response = await http.get(link);
    dom.Document document = parser.parse(response.body);
    final elements =
        document.getElementsByClassName("InlineImage-imageEmbed hasBkg");
    print('elements: $elements');

    picList = elements.map((element) => element.getElementsByTagName("img")[0].attributes['src']).toList();
    print('parseForPicture is completed: $picList');
    return picList;
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: parseForPicture(link),
      // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        List<Widget> children;

        if (snapshot.hasData) {
          children = <Widget>[
            Image.network(picList[0]),
          ];
        } else if (snapshot.hasError) {
          children = <Widget>[
            Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text('Error: ${snapshot.error}'),
            )
          ];
        } else {
          children = <Widget>[
            SizedBox(
              child: CircularProgressIndicator(),
              width: 32,
              height: 32,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 24, bottom: 8),
              child: Text('Awaiting result...'),
            )
          ];
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: children,
          ),
        );
      },
    );
  }
}
