import 'user.dart';

class Log {
  User user;
  DateTime time;
  String building;

  Log({this.user, this.time, this.building});

  Log.fromData(Map<String, dynamic> data)
      : user = data['user'],
        time = data['time'],
        building = data['building'];

  Map<String, dynamic> toJson() {
    return {
      'user': user,
      'time': time,
      'building': building,
    };
  }
}
