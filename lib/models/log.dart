import 'package:json_annotation/json_annotation.dart';

part 'log.g.dart';

@JsonSerializable(nullable: false)
class Log {
  final String userName;
  final String buildingName;
  final String phoneNumber;
  final String time;
  final String key;
  
  Log({this.userName, this.buildingName, this.phoneNumber, this.time, this.key});

  factory Log.fromJson(Map<String, dynamic> json) => _$LogFromJson(json);
  Map<String, dynamic> toJson() => _$LogToJson(this);

}
