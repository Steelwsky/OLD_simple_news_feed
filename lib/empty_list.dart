import 'package:flutter/material.dart';

class InitialEmptyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Text(
              'Pull down to update the feed',
              key: Key('empty'),
              style: TextStyle(fontSize: 18),
            ),
          ),
        )
      ],
    );
  }
}
