import 'package:flutter/material.dart';

class SuggestionWidget extends StatelessWidget {
  final TextEditingController _textController = new TextEditingController();
  final TextEditingController _titleController = new TextEditingController();
  TextEditingController get textController => _textController;
  TextEditingController get titleController => _titleController;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: _titleController,
                minLines: 1,
                maxLines: 2,
                autocorrect: false,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  hintText: '제목을 입력하시오',
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
          Container(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: _textController,
                minLines: 10,
                maxLines: 15,
                autocorrect: false,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  hintText: '내용을 입력하시오',
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
        ],
      ),
    );
  }
}
