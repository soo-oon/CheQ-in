import 'package:json_annotation/json_annotation.dart';

part 'suggestion.g.dart';

@JsonSerializable(nullable: false)
class Suggestion {
  String name;
  String title;
  String content;
  DateTime time;

  Suggestion({this.name, this.content, this.time, this.title});

  factory Suggestion.fromJson(Map<String, dynamic> json) => _$SuggestionFromJson(json);
  Map<String, dynamic> toJson() => _$SuggestionToJson(this);
}
