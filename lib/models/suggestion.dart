class Suggestion {
  String name;
  String title;
  String content;
  DateTime time;

  Suggestion({this.name, this.content, this.time, this.title});

  Suggestion.fromData(Map<String, dynamic> data)
      : name = data['name'],
        content = data['content'],
        time = data['time'],
        title = data['title'];

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'content': content,
      'time': time,
      'title': title,
    };
  }
}
