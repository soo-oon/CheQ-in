import 'package:flutter/material.dart';

class Suggestion extends StatefulWidget {
  const Suggestion({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => SuggestionState();
}

class SuggestionState extends State<Suggestion> {
  final TextEditingController _textController = new TextEditingController();
  String building = "Building1";
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "Suggestion",
            style: new TextStyle(fontSize: 40.0),
          ),
          DropdownButton<String>(
            value: building,
            onChanged: (String newValue) {
              setState(() {
                building = newValue;
              });
            },
            items: <String>["Building1", "Building2", "Building3", "Building4"]
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: _textController,
                minLines: 10,
                maxLines: 15,
                autocorrect: false,
                decoration: InputDecoration(
                  hintText: 'Write your status here',
                  filled: true,
                  fillColor: Color(0xFFDBEDFF),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text("clear"),
                onPressed: () {
                  _textController.clear();
                },
              ),
              FlatButton(
                child: Text("Send"),
              )
            ],
          )
        ],
      ),
    );
  }
}
