import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class PushNotificationService {
  final String serverToken =
      'AAAAoWePb7w:APA91bHmCPc70xnMoXWTWYA26KU4wfM_85I89qkigzMB6vyeTE2ioH-8EF6XZQcISJdWkQgpLno_nMip8B-tmFdqdDstaRYxEQseM2stsGOpCJG41DlmlTr3e2yCMBMgOEiC7159Espn';
  final FirebaseMessaging _fcm = FirebaseMessaging();

  Future initialise() async {
    if (Platform.isIOS) {
      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }

    _fcm.configure(
      //When the app is open and it receives a push notification
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },

      //When the app is completely closed (not in the background) and opened directly from the push notification
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },

      //When the app is in the background and opened directly from the push notification.
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );

    _fcm.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _fcm.subscribeToTopic("all");
    _fcm.getToken().then((String token) {
      assert(token != null);
      print("Push Notification token retrieved $token");
    });
  }

  Future sendNotificationMessage() async {
    try {
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
    } catch(e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
    
  }

  
}
