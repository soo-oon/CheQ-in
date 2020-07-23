import 'package:checkin/models/suggestion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailView extends StatelessWidget {
  final Suggestion suggestion;
  DetailView({Key key, @required this.suggestion}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Text(suggestion.title),
            Text(suggestion.content),
          ],
        ),
      ),
    );
  }
}
