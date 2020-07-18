import 'package:json_annotation/json_annotation.dart';

part 'suggestion.g.dart';

@JsonSerializable(nullable: false)
class Suggestion {
  final String title;
  final String content;

  Suggestion({this.content, this.title});

  factory Suggestion.fromJson(Map<String, dynamic> json) =>
      _$SuggestionFromJson(json);
  Map<String, dynamic> toJson() => _$SuggestionToJson(this);
}
