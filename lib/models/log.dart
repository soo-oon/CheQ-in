import 'user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'log.g.dart';

@JsonSerializable(nullable: false)
class Log {
  final String userName;
  final String buildingName;
  final String time;
  
  Log({this.userName, this.buildingName, this.time});

  factory Log.fromJson(Map<String, dynamic> json) => _$LogFromJson(json);
  Map<String, dynamic> toJson() => _$LogToJson(this);
}
