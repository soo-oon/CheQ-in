import 'package:cloud_firestore/cloud_firestore.dart';

import 'user.dart';

class Log {
  User user;
  DateTime time;
  Log(this.user, this.time);
  DateTime _convertStamp(Timestamp _stamp) {
    if (_stamp != null) {
      return Timestamp(_stamp.seconds, _stamp.nanoseconds).toDate();
      /*
    if (Platform.isIOS) {
      return _stamp.toDate();
    } else {
      return Timestamp(_stamp.seconds, _stamp.nanoseconds).toDate();
    }
    */

    } else {
      return null;
    }
  }

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
