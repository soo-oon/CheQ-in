import 'package:cloud_firestore/cloud_firestore.dart';

import 'user.dart';

class Log {
  User user;
  DateTime time;
  Log(this.user, this.time);

  Log.fromData(Map<String, dynamic> data)
      : user = User.fromData(data['user']),
        time = DateTime.fromMillisecondsSinceEpoch(
            data['time'].millisecondsSinceEpoch);
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['time'] = time;
    return data;
  }
}
