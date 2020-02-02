import 'package:flutter/material.dart';

class InitialEmptyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Pull down to update the feed',
            key: Key('empty'),
            style: TextStyle(fontSize: 18),
          ),
        )
      ],
    );
  }
}
