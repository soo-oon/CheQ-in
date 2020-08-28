import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<bool> exitAppDialogue(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => new AlertDialog(
      title: new Text('종료'),
      content: new Text('앱을 나가실 껀가요?'),
      actions: <Widget>[
        new FlatButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: new Text('아니요'),
        ),
        new FlatButton(
          onPressed: () => SystemNavigator.pop(),
          child: new Text('네'),
        ),
      ],
    ),
  );
}
