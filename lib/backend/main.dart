import 'package:checkin/backend/ui/view/push_view.dart';
import 'package:checkin/backend/ui/view/suggestion_view.dart';
import 'package:checkin/backend/ui/view/visitor_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(primarySwatch: Colors.lightBlue),
    home: checkinBackEndMainPage(),
  ));
}

class checkinBackEndMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: new Scaffold(
          appBar: AppBar(
            title: Text("Back End Main Page"),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  text: "Visitors",
                ),
                Tab(
                  text: "Suggestions ",
                ),
                Tab(
                  text: "Push",
                )
              ],
            ),
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              VisitorView(),
              SuggestionView(),
              PushView(),
            ],
          )),
    );
  }
}
