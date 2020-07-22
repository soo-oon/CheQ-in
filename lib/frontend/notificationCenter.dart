import 'package:checkin/util/dbHelper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class PushMessagingExample extends StatefulWidget {
  @override
  _PushMessagingExampleState createState() => _PushMessagingExampleState();
}

class _PushMessagingExampleState extends State<PushMessagingExample> {

  Map _not;
  Future<List<Notifications>> _notifications;
  DBHelper _dbHelper;
  String _homeScreenText = "Waiting for token...";
  String _messageText = "Waiting for message...";
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();


  refreshNotificationList() {
    setState(() {
      _notifications = _dbHelper.getNotifications();
    });
  }

  getNotificationMessage(Map message){
    setState(() {
      print("");
      _not = message["notification"];
      _dbHelper.add(Notifications(null, _not['title'], _not['body']));
      _messageText = "Push Messaging message: $message";
    });
    print("onMessage: $message ${_not['title'] }${_not['title'] }");
  }

  @override
  void initState() {
    super.initState();
    _dbHelper = DBHelper();
    refreshNotificationList();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        getNotificationMessage(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        getNotificationMessage(message);
      },
      onResume: (Map<String, dynamic> message) async {
        getNotificationMessage(message);
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      setState(() {
        _homeScreenText = "Push Messaging token: $token";
      });
      //print(_homeScreenText);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
            child: FutureBuilder(
                future: _notifications,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return generateList(snapshot.data);
                  }
                  if (snapshot.data == null || snapshot.data.length == 0) {
                    return Text('No Data Found');
                  }
                  return CircularProgressIndicator();
                }
            )
        ),
        Row(children: <Widget>[
          Expanded(
            child: Text(_messageText),
          ),
        ])
      ],
    );
  }

  SingleChildScrollView generateList(List<Notifications> notifications) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SizedBox(
        width: double.infinity,
        child: DataTable(
          columns: [
            DataColumn(
              label: Text('BODY'),
            ),
            DataColumn(
              label: Text('TITLE'),
            )
          ],
          rows: notifications.map((notification) => DataRow(
            cells: [
              DataCell(
                Text(notification.body),
                onTap: () {},
              ),
              DataCell(
                Text(notification.title),
              )
            ],
          ),
          ).toList(),
        ),
      ),
    );
  }
}

class Notifications{
  int notiID;
  String title;
  String body;

  Notifications(this.notiID, this.title, this.body);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "notiID": notiID,
      "title" : title,
      "body" : body,
    };
    return map;
  }

  Notifications.fromMap(Map<String, dynamic> map){

    notiID = map['notiID'];
    title = map['title'];
    body =  map['body'];
  }
}
