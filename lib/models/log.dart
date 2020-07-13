import 'user.dart';

class Log {
  User user;
  DateTime time;

  Log({this.user, this.time});

  Log.fromData(Map<String, dynamic> data)
      : user = data['user'],
        time = data['time'];

  Map<String, dynamic> toJson() {
    return {
      'user': user,
      'time': time,
    };
  }
}
