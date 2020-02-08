import 'package:flutter/material.dart';

class Bookmark extends StatelessWidget {
  const Bookmark({Key key, @required this.isViewed}) : super(key: key);

  final bool isViewed;

  @override
  Widget build(BuildContext context) {
    return Icon(isViewed ? Icons.bookmark : Icons.bookmark_border,
        size: 24, color: Colors.amber);
  }
}
