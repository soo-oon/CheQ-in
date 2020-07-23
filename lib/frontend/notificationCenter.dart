import 'package:checkin/util/dbHelper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class PushMessagingExample extends StatefulWidget {
  @override
  _PushMessagingExampleState createState() => _PushMessagingExampleState();
}

class _PushMessagingExampleState extends State<PushMessagingExample> {

  Future<List<Notifications>> _notifications;
  DBHelper _dbHelper = DBHelper();

  refreshNotificationList() {
    setState(() {
      _notifications = _dbHelper.getNotifications();
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      refreshNotificationList();
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
