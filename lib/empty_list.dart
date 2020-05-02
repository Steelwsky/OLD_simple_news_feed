import 'package:flutter/material.dart';
import 'package:simplenewsfeed/strings.dart';

class EmptyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Text(
              PULL_DOWN_TO_UPDATE,
              key: Key('empty'),
              style: TextStyle(fontSize: 18),
            ),
          ),
        )
      ],
    );
  }
}
