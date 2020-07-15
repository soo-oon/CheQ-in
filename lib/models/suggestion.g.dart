// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'suggestion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Suggestion _$SuggestionFromJson(Map<String, dynamic> json) {
  return Suggestion(
    name: json['name'] as String,
    content: json['content'] as String,
    time: DateTime.parse(json['time'] as String),
    title: json['title'] as String,
  );
}

Map<String, dynamic> _$SuggestionToJson(Suggestion instance) =>
    <String, dynamic>{
      'name': instance.name,
      'title': instance.title,
      'content': instance.content,
      'time': instance.time.toIso8601String(),
    };
