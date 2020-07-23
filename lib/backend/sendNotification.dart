import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class SendNotificationPage extends StatefulWidget{
  @override
  _SendNotificationPageState createState() => _SendNotificationPageState();
}

class _SendNotificationPageState extends State<SendNotificationPage>{

  final String serverToken = 'AAAAoWePb7w:APA91bHmCPc70xnMoXWTWYA26KU4wfM_85I89qkigzMB6vyeTE2ioH-8EF6XZQcISJdWkQgpLno_nMip8B-tmFdqdDstaRYxEQseM2stsGOpCJG41DlmlTr3e2yCMBMgOEiC7159Espn';
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  /*Future<Map<String, dynamic>>*/ _sendNotificationMessage() async {
    await firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(sound: true, badge: true, alert: true, provisional: false),
    );

    await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': 'Amazing Grace',
            'title': 'I have done it'
          },
          //'priority': 'high',
          'data': <String, dynamic>{
            'body': 'Amazing Grace',
            'title': 'weew',
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          'to': "/topics/all",
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          RaisedButton(
            child: Text("Push Message"),
              onPressed: _sendNotificationMessage,
          )
        ],
      )    ,
    );
  }

}

