import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  Future initialise() async {
    if(Platform.isIOS){
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
  }
}